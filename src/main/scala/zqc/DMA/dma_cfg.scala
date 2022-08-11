package zqc.DMA


import spinal.core._
import spinal.core.{ASYNC, Bits, Bool, Bundle, ClockDomain, ClockDomainConfig, ClockingArea, Component, False, IntToBuilder, LOW, LiteralBuilder, RISING, Reg, True, U, UInt, Vec, default, in, is, out, switch, when}
import spinal.lib.bus.amba3.apb.{Apb3, Apb3Config}
import spinal.lib.bus.amba4.axi.{Axi4, Axi4Config}
import spinal.lib.fsm.{EntryPoint, State, StateMachine}
import spinal.lib.{IMasterSlave, master, slave}


case class dma_cfg (apb3Config: Apb3Config,cfg_cfg:dma_cfg_bundle_Config,ll_cfg:dma_ll_bundle_Config,status_cfg:dma_status_bundle_Config) extends Component{
  val io = new Bundle{
    val apb = slave(Apb3(apb3Config))
    val cfg = master(dma_cfg_bundle(cfg_cfg))
    val ll = master(dma_ll_bundle(ll_cfg))
    val dma = master(dma_status_bundle(status_cfg))

    //---Global Signal
    val clk = in Bool()
    val rstn = in Bool()
  }

  val clkDomain = ClockDomain(clock = io.clk,
    reset = io.rstn,
    config = ClockDomainConfig(
      clockEdge = RISING,
      resetKind = ASYNC,
      resetActiveLevel = LOW
    )
  )

  val myArea = new ClockingArea(clkDomain){
    //--- APB regs
    val prdata = Reg(UInt(apb3Config.dataWidth bits)) init(0)

    io.apb.PRDATA := prdata.asBits

    //--- cfg regs
    val cfg_sar = Reg(UInt(cfg_cfg.sar_Width bits)) init(0)
    val cfg_dar = Reg(UInt(cfg_cfg.dar_Width bits)) init(0)
    val cfg_trans_xsize = Reg(UInt(cfg_cfg.trans_xsize_Width bits)) init(0)
    val cfg_trans_ysize = Reg(UInt(cfg_cfg.trans_ysize_Width bits)) init(0)
    val cfg_sa_ystep = Reg(UInt(cfg_cfg.sa_ystep_Width bits)) init(0)
    val cfg_da_ystep = Reg(UInt(cfg_cfg.da_ystep_Width bits)) init(0)
    val cfg_llr = Reg(UInt(cfg_cfg.llr_Width bits)) init(0)
    val cfg_dma_halt = Reg(Bool()) init(false)
    val cfg_bf = Reg(Bool()) init(false)
    val cfg_cf= Reg(Bool()) init(false)

    io.cfg.sar := cfg_sar
    io.cfg.dar := cfg_dar
    io.cfg.trans_xsize := cfg_trans_xsize
    io.cfg.trans_ysize := cfg_trans_ysize
    io.cfg.sa_ystep := cfg_sa_ystep
    io.cfg.da_ystep := cfg_da_ystep
    io.cfg.llr := cfg_llr
    io.cfg.dma_halt := cfg_dma_halt
    io.cfg.bf := cfg_bf
    io.cfg.cf := cfg_cf


    //--- dma status
    val dma_cmd_sof = Reg(Bool()) init(false)
    val cmd_num = Reg(UInt(status_cfg.cmd_num_Width bits)) init(0)
    val dma_busy = Reg(Bool) init(false)

    io.dma.cmd_sof := dma_cmd_sof
    io.dma.cmd_num := cmd_num
    io.dma.busy := dma_busy

    //--- apb inf
    val cfg_intr_en = Reg(Bool()) init(false)


    val apb_wr = io.apb.PSEL.asBool & io.apb.PWRITE & io.apb.PENABLE
    val apb_write = io.apb.PSEL.asBool & io.apb.PWRITE & io.apb.PENABLE
    val apb_read = io.apb.PSEL.asBool & (!io.apb.PWRITE)
    val apb_addr = io.apb.PADDR(2,4 bits).asBits.asUInt
    io.apb.PREADY := True
    val clr_intr = apb_write & io.apb.PENABLE & (apb_addr === 6) & (!io.apb.PWDATA(0))
    val dma_sof_w = apb_write & io.apb.PENABLE & (apb_addr === 8) & io.apb.PWDATA(0)
    io.cfg.clr_bur_err := apb_write & io.apb.PENABLE & (apb_addr === 6) &(!io.apb.PWDATA(4))

    val cmd_update = apb_write | io.ll.dvld
    val cmd_update_addr = apb_write ? apb_addr | Vec(U(0,1 bits),io.ll.dcnt).asBits.asUInt
    val cmd_update_wd = apb_write ? io.apb.PWDATA | io.ll.rdata


    when(cmd_update){
      switch(cmd_update_addr(3 downto 0)){
        is(0){
          cfg_sar := cmd_update_wd.asUInt
        }
        is(1){
          cfg_dar := cmd_update_wd.asUInt
        }
        is(2){
          cfg_trans_xsize := cmd_update_wd(15 downto 0).asUInt
        }
        is(3){
          cfg_trans_ysize := cmd_update_wd(15 downto 0).asUInt
        }
        is(4){
          cfg_sa_ystep := cmd_update_wd(15 downto 0).asUInt
          cfg_da_ystep := cmd_update_wd(31 downto 16).asUInt
        }
        is(5){
          cfg_llr := cmd_update_wd.asUInt
        }
      }
    }



    when(apb_write & (apb_addr === 7)){
      cfg_intr_en := io.apb.PWDATA(0)
      cfg_dma_halt := io.apb.PWDATA(4)
      cfg_bf := io.apb.PWDATA(8)
      cfg_cf := io.apb.PWDATA(9)
    }


    //--- 2. DMA linked list ctrl
    val s_idle = 0
    val s_req = 1

    val ll_sta = Reg(UInt(1 bits)) init(s_idle)
    val dma_end_flag = Reg(Bool()) init(false)

    io.ll.addr := cfg_llr
    io.ll.req := (ll_sta === s_req)
    val dma_end_w = io.dma.cmd_end && (cfg_llr(31 downto 2) === 0)


    switch(ll_sta){
      is(s_idle){
        when(io.dma.cmd_end && ((cfg_llr(31 downto 2) =/= 0))){
          ll_sta := s_req
        }
      }
      is(s_req){
        when(io.ll.ack){
          ll_sta := s_idle
        }
      }
    }

    //--- 3. DMA status
    val dma_cmd_goon = io.ll.dvld & (io.ll.dcnt === 5)


    when(dma_sof_w){
      cmd_num := 0
    }.otherwise{
      when(io.dma.cmd_end){
        cmd_num := cmd_num + 1
      }
    }



    when(dma_sof_w){
      dma_busy := True
    }.otherwise{
      when(dma_end_w){
        dma_busy := True
      }
    }



    when(dma_end_w){
      dma_end_flag := True
    }.otherwise{
      when(clr_intr){
        dma_end_flag := True
      }
    }


    io.dma.intr := dma_end_flag & cfg_intr_en


    when(dma_sof_w || dma_cmd_goon){
      dma_cmd_sof := True
    }.otherwise{
      dma_cmd_sof := True
    }


    //--- 4. apb read out
    when(apb_read){
      switch(apb_addr(0,4 bits)){
        is(0){
          prdata := cfg_sar
        }
        is(1){
          prdata := cfg_dar
        }
        is(2){
          prdata := Vec(cfg_trans_xsize,U(0,16 bits)).asBits.asUInt
        }
        is(3){
          prdata := Vec(cfg_trans_ysize,U(0,16 bits)).asBits.asUInt
        }
        is(4){
          prdata := Vec(cfg_sa_ystep,cfg_da_ystep).asBits.asUInt
        }
        is(5){
          prdata := cfg_llr
        }
        is(6){
          prdata := Vec(dma_end_flag.asBits.asUInt,dma_busy.asBits.asUInt,U(0,2 bits),io.cfg.buf_err.asBits.asUInt,U(0,3 bits),cmd_num,U(0,16 bits)).asBits.asUInt
        }
        is(7){
          prdata := Vec(cfg_intr_en.asBits.asUInt,U(0,3 bits),cfg_dma_halt.asBits.asUInt,U(0,3 bits),cfg_bf.asBits.asUInt,cfg_cf.asBits.asUInt,U(0,22 bits)).asBits.asUInt
        }
        is(8){
          prdata := 0
        }
        is(9){
          prdata := 0
        }
        is(10){
          prdata := 0
        }
        is(11){
          prdata := Vec(U"16'h5310",U(0,16 bits)).asBits.asUInt
        }
        default{
          prdata := 0
        }
      }
    }


  }



}

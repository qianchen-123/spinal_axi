package zqc.DMA

import spinal.core.internals.Operator.Bits
import spinal.core.{Bool, Bundle, Component, False, IntToBuilder, LiteralBuilder, Reg, True, U, UInt, Vec, default, is, switch, when}
import spinal.lib.bus.amba3.apb.Apb3Config
import spinal.lib.bus.amba4.axi.{Axi4, Axi4Config}
import spinal.lib.fsm.{EntryPoint, State, StateMachine}
import spinal.lib.{master, slave}


case class dma_cfg (config: dmaBundleConfig,apb3Config: Apb3Config) extends Component{
  val io = new Bundle{
    val cfg = master(dma_bundle(config,apb3Config))
  }

  //--- APB regs
  val prdata = Reg(UInt(apb3Config.dataWidth bits)) init(0)

  io.cfg.dma_apb.PRDATA := prdata.asBits

  //--- cfg regs
  val cfg_sar = Reg(UInt(config.sar_Width bits)) init(0)
  val cfg_dar = Reg(UInt(config.dar_Width bits)) init(0)
  val cfg_trans_xsize = Reg(UInt(config.trans_xsize_Width bits)) init(0)
  val cfg_trans_ysize = Reg(UInt(config.trans_ysize_Width bits)) init(0)
  val cfg_sa_ystep = Reg(UInt(config.sa_ystep_Width bits)) init(0)
  val cfg_da_ystep = Reg(UInt(config.da_ystep_Width bits)) init(0)
  val cfg_llr = Reg(UInt(config.llr_Width bits)) init(0)
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
  val cmd_num = Reg(UInt(config.cmd_num_Width bits)) init(0)
  val dma_busy = Reg(Bool) init(false)

  io.cfg.dma_cmd_sof := dma_cmd_sof
  io.cfg.cmd_num := cmd_num
  io.cfg.dma_busy := dma_busy

  //--- apb inf
  val cfg_intr_en = Reg(Bool()) init(false)


  val apb_write = io.cfg.dma_apb.PSEL.asBool & io.cfg.dma_apb.PWRITE & io.cfg.dma_apb.PENABLE
  val apb_read = io.cfg.dma_apb.PSEL.asBool & (!io.cfg.dma_apb.PWRITE)
  val apb_addr = io.cfg.dma_apb.PADDR(2,4 bits).asBits.asUInt
  io.cfg.dma_apb.PREADY := True
  val clr_intr = apb_write & io.cfg.dma_apb.PENABLE & (apb_addr === 6) & (!io.cfg.dma_apb.PWDATA(0))
  val dma_sof_w = apb_write & io.cfg.dma_apb.PENABLE & (apb_addr === 8) & io.cfg.dma_apb.PWDATA(0)
  io.cfg.clr_bur_err := apb_write & io.cfg.dma_apb.PENABLE & (apb_addr === 6) &(!io.cfg.dma_apb.PWDATA(4))

  val cmd_update = apb_write | io.cfg.ll_dvld
  val cmd_update_addr = apb_write ? apb_addr | Vec(U(0,1 bits),io.cfg.ll_dcnt).asBits.asUInt
  val cmd_update_wd = apb_write ? io.cfg.dma_apb.PWDATA | io.cfg.ll_rdata

  //--- 1. write to regs
  when(!io.cfg.rstn){
    cfg_sar := 0
    cfg_dar := 0
    cfg_trans_xsize := 0
    cfg_trans_ysize := 0
    cfg_sa_ystep := 0
    cfg_da_ystep := 0
    cfg_llr := 0
  }.otherwise{
    when(cmd_update){
      switch(cmd_update_addr(0,4 bits)){
        is(0){
          cfg_sar := cmd_update_wd.asUInt
        }
        is(1){
          cfg_dar := cmd_update_wd.asUInt
        }
        is(2){
          cfg_trans_xsize := cmd_update_wd(0,16 bits).asUInt
        }
        is(3){
          cfg_trans_ysize := cmd_update_wd(16,16 bits).asUInt
        }
        is(4){
          cfg_sa_ystep := cmd_update_wd(0,16 bits).asUInt
          cfg_da_ystep := cmd_update_wd(16,16 bits).asUInt
        }
        is(5){
          cfg_llr := cmd_update_wd.asUInt
        }
      }
    }
  }

  when(!io.cfg.rstn){
    cfg_dma_halt := False
    cfg_intr_en := False
    cfg_bf := False
    cfg_cf := False
  }.otherwise{
    when(apb_write & (apb_addr === 7)){
      cfg_intr_en := io.cfg.dma_apb.PWDATA(0)
      cfg_dma_halt := io.cfg.dma_apb.PWDATA(4)
      cfg_bf := io.cfg.dma_apb.PWDATA(8)
      cfg_cf := io.cfg.dma_apb.PWDATA(9)
    }
  }

  //--- 2. DMA linked list ctrl
  val dma_end_flag = Reg(Bool()) init(false)

  io.cfg.ll_addr := cfg_llr
  val dma_end_w = io.cfg.dma_cmd_end && (cfg_llr(2,29 bits) === 0)

  io.cfg.ll_req := False

  val fsm = new StateMachine{
    val s_idle : State = new State with EntryPoint{
      whenIsActive{
        io.cfg.ll_req := False
        when(!io.cfg.rstn){
          goto(s_idle)
        }.otherwise{
          when(io.cfg.dma_cmd_end && (cfg_llr(2,29 bits) =/= 0)){
            io.cfg.ll_req := True
            goto(s_req)
          }
        }
      }
    }

    val s_req : State = new State{
      whenIsActive{
        when(!io.cfg.rstn){
          goto(s_idle)
        }.otherwise{
          when(io.cfg.ll_ack){
            goto(s_idle)
          }
        }
      }
    }
  }

  //--- 3. DMA status
  val dma_cmd_goon = io.cfg.ll_dvld & (io.cfg.ll_dcnt === 5)

  when(!io.cfg.rstn){
    cmd_num := 0
  }.otherwise{
    when(dma_sof_w){
      cmd_num := 0
    }.otherwise{
      when(io.cfg.dma_cmd_end){
        cmd_num := cmd_num + 1
      }
    }
  }

  when(!io.cfg.rstn){
    dma_busy := False
  }.otherwise{
    when(dma_sof_w){
      dma_busy := True
    }.otherwise{
      when(dma_end_w){
        dma_busy := True
      }
    }
  }

  when(!io.cfg.rstn){
    dma_end_flag := False
  }.otherwise{
    when(dma_sof_w){
      dma_end_flag := True
    }.otherwise{
      when(dma_end_w){
        dma_end_flag := True
      }
    }
  }

  io.cfg.intr := dma_end_flag & cfg_intr_en

  when(!io.cfg.rstn){
    dma_cmd_sof := False
  }.otherwise{
    when(dma_sof_w || dma_cmd_goon){
      dma_cmd_sof := True
    }.otherwise{
      dma_cmd_sof := True
    }
  }

  //--- 4. apb read out
  when(!io.cfg.rstn){
    io.cfg.dma_apb.PRDATA := 0
  }.otherwise{
    when(apb_read){
      switch(apb_addr(0,4 bits)){
        is(0){
          prdata := cfg_sar
        }
        is(1){
          prdata := cfg_dar
        }
        is(2){
          prdata := Vec(U(0,16 bits),cfg_trans_xsize).asBits.asUInt
        }
        is(3){
          prdata := Vec(U(0,16 bits),cfg_trans_ysize).asBits.asUInt
        }
        is(4){
          prdata := Vec(cfg_da_ystep,cfg_sa_ystep).asBits.asUInt
        }
        is(5){
          prdata := cfg_llr
        }
        is(6){
          prdata := Vec(U(0,16 bits),cmd_num,U(0,3 bits),io.cfg.buf_err.asBits.asUInt,U(0,2 bits),dma_busy.asBits.asUInt,dma_end_flag.asBits.asUInt).asBits.asUInt
        }
        is(7){
          prdata := Vec(U(0,22 bits),cfg_cf.asBits.asUInt,cfg_bf.asBits.asUInt,U(0,3 bits),cfg_dma_halt.asBits.asUInt,U(0,3 bits),cfg_intr_en.asBits.asUInt).asBits.asUInt
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
          prdata := Vec(U(0,16 bits),U"16'h5310").asBits.asUInt
        }
        default{
          prdata := 0
        }
      }
    }
  }

}

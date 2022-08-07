package zqc.AXITest.axi_slave.sram

import spinal.lib._
import spinal.core._
import spinal.lib.bus.amba4.axi.{Axi4, Axi4Config}
import spinal.lib.fsm.{EntryPoint, State, StateMachine}

case class AxiCfgReg(axi4: Axi4,axi4Config: Axi4Config) extends Bundle{
  val AxID = Reg(UInt(axi4Config.idWidth bits)) init(0)
  val AxADDR = Reg(UInt(axi4Config.addressWidth bits)) init(0)
  val AxLEN = Reg(UInt(8 bits)) init(0)
  val AxSIZE = Reg(UInt(3 bits)) init(0)
  val AxBURST = Reg(Bits(2 bits)) init(0)

  val counter = Reg(UInt(4 bits)) init(0)
  val begin =  Reg(Bool()) init(False)
  val in_burst_trans =  Bool()  //Reg(Bool()) init(False)
  val full = Bool() //Reg(Bool()) init(False)
//  val almostFull = Bool()

//  begin := False
  in_burst_trans := False
//  full := False
  // set register with Write addr channel signal
  def regConfigAw() : Unit = {
    AxID := axi4.aw.payload.id
    AxADDR := axi4.aw.payload.addr
    AxLEN := axi4.aw.payload.len
    AxSIZE := axi4.aw.payload.size
    AxBURST := axi4.aw.payload.burst
    counter := 1
    begin := True
    in_burst_trans := False
    full := False
  }

  // reset register with Read addr channel signal
  def regConfigAr() : Unit = {
    AxID := axi4.ar.payload.id
    AxADDR := axi4.ar.payload.addr
    AxLEN := axi4.ar.payload.len
    AxSIZE := axi4.ar.payload.size
    AxBURST := axi4.ar.payload.burst
    counter := 1
    begin := True
    in_burst_trans := True
    full := False
  }

  def rst() : Unit = {
    AxID := 0
    AxADDR := 0
    AxLEN := 0
    AxSIZE := 0
    AxBURST := 0
    counter := 0
    begin := False
    in_burst_trans := False
    full := False
  }

  // Burst transfer number
  when(in_burst_trans){
    when(begin && !full){
      //Address transfer
      switch(AxBURST){
        is(Axi4.burst.FIXED){
          AxADDR := AxADDR
        }
        is(Axi4.burst.INCR){
          AxADDR := AxADDR + (U"1" << AxSIZE)
        }
        is(Axi4.burst.WRAP){
          //TODO WRAP LOGIC
          AxADDR := AxADDR + (U"1" << AxSIZE)
        }
      }
      counter := counter + 1
    }
  }

  full := (counter === AxLEN)
//  almostFull := (counter === AxLEN - 1)

}


//TODO class AXI SRAM CONFIG
case class Axi4SRamCfg(axi4Config: Axi4Config,
                       memWidth : Int,
                       maxBurstSize : Int,
                       baseAddress : Int,
                       memSize : Int) {
  require(memWidth > 0,"SRAM width cannot be 0 ")
  require(maxBurstSize > 0, "SRAM support max burst size cannot be 0")
  require(baseAddress >= 0, "SRam base Address connot be less then 0 ")
  require(memSize > 0, "SRAM address boundary cannot be 0")

  require(axi4Config.dataWidth >= memWidth, "Your bus bandwidth must be greater than the memory bandwidth")
  require(List(1,2,4,8,16,32,64,128) contains maxBurstSize , "Valid maxBurstLen : 1, 2, 4, 8, 16, 32, 64, 128")
  require(maxBurstSize * memWidth == axi4Config.dataWidth, "maxBurstSize * memWidth == Axi bus data width(axi4Config.dataWidth)")
  require(memSize <= 4096 , "your memory address must be smaller than 4kb boundary")
}


//TODO class AXI SLAVE Address mapping
case class axi_slave_address_mapping(base : BigInt, range : BigInt){
  def hit(address : UInt) : Bool = address >= base && address < base+range
}

case class axi_slave_control(axiCfgReg: AxiCfgReg , axi4: Axi4) extends Component {

  val axi4SRamCfg = Axi4SRamCfg(axiCfgReg.axi4Config,8,4,0,4096)
  val mem = Reg
  val mem1 = Mem(Bits(axi4SRamCfg.memWidth bits), wordCount = axi4SRamCfg.memSize)
  val mem2 = Mem(Bits(axi4SRamCfg.memWidth bits), wordCount = axi4SRamCfg.memSize)

  def  write() : Unit = {
    switch(axiCfgReg.AxADDR(12,20 bits)){
      is(0){
        for(x<- 0 to (U"1" << axiCfgReg.AxSIZE).algoInt - 1){
          mem1.write(
            address = axiCfgReg.AxADDR(0,12 bits) + x,
            data = axi4.w.payload.data(0 + x * axi4SRamCfg.memWidth,axi4SRamCfg.memWidth bits),
            enable = True
          )
        }
      }
      is(1){
        for(x<- 0 to (U"1" << axiCfgReg.AxSIZE).algoInt - 1){
          mem2.write(
            address = axiCfgReg.AxADDR(0,12 bits) + x,
            data = axi4.w.payload.data(0 + x * axi4SRamCfg.memWidth,axi4SRamCfg.memWidth bits),
            enable = True
          )
        }
      }
    }
  }

  def read() : Unit = {
    switch(axiCfgReg.AxADDR(12,20 bits)){
      is(0){
        for(x<- 0 to (U"1" << axiCfgReg.AxSIZE).algoInt - 1){
          axi4.r.payload.data(0 + x * axi4SRamCfg.memWidth,axi4SRamCfg.memWidth bits) := mem1.readSync(address = axiCfgReg.AxADDR(0,12 bits) + x,True)
        }
      }
      is(1){
        for(x<- 0 to (U"1" << axiCfgReg.AxSIZE).algoInt - 1){
          axi4.r.payload.data(0 + x * axi4SRamCfg.memWidth,axi4SRamCfg.memWidth bits) := mem2.readSync(address = axiCfgReg.AxADDR(0,12 bits) + x, True)
        }
      }
    }
  }

}

case class axi_slave(axi4Config: Axi4Config) extends Component{
  val io = new Bundle{
    val axi_in = slave(Axi4(axi4Config))
//    val ACLK = in Bool()
//    val RESETn = in Bool()
    //TODO reset logic
  }

  val user = B(0,axi4Config.bUserWidth bits)

  val axiCfgReg = AxiCfgReg(io.axi_in,axi4Config)
//  val axi_slave = axi_slave_control(axiCfgReg,io.axi_in)
  val axi4SRamCfg = Axi4SRamCfg(axiCfgReg.axi4Config,8,4,0,4096)
  val mem1 = Mem(Bits(32 bits), wordCount = axi4SRamCfg.memSize)
  val mem2 = Mem(Bits(32 bits), wordCount = axi4SRamCfg.memSize)

  io.axi_in.aw.ready := False
  io.axi_in.w.ready := False
  io.axi_in.b.valid := False
  io.axi_in.b.payload.id := U(0,axi4Config.idWidth bits)
  io.axi_in.b.payload.resp := B(0,2 bits)
  io.axi_in.b.payload.user := user
  io.axi_in.ar.ready := False
  io.axi_in.r.valid := False
  io.axi_in.r.payload.data := B(0,axi4Config.dataWidth bits)
  io.axi_in.r.payload.id := U(0,axi4Config.idWidth bits)
  io.axi_in.r.payload.resp := B(0,2 bits)
  io.axi_in.r.payload.last := False
  io.axi_in.r.payload.user :=  user



  val fsm = new StateMachine{
    val IDLE = new State with EntryPoint

    // Write transaction channels state
    val W_ADDR = new State
    val W_DATA = new State
    val W_RSP = new State


    // Read transaction channels state
    val R_ADDR = new State
    val R_DATA = new State

    IDLE.whenIsActive{

      axiCfgReg.rst()

      io.axi_in.b.valid := False
      io.axi_in.r.valid := False
      io.axi_in.r.last := False

      when(io.axi_in.aw.valid){
        goto(W_ADDR)
      }elsewhen(io.axi_in.ar.valid){
        goto(R_ADDR)
      }
    }

    W_ADDR.whenIsActive{

      axiCfgReg.regConfigAw()
      io.axi_in.aw.ready := True

      when(io.axi_in.aw.fire){
        goto(W_DATA)
      }
    }

    W_DATA.whenIsActive{
      io.axi_in.aw.ready := False
      io.axi_in.w.ready := False


      when(io.axi_in.w.valid){
        axiCfgReg.in_burst_trans := True
        mem1.write(
          address = axiCfgReg.AxADDR(0,12 bits) ,
          data = io.axi_in.w.payload.data,
          enable = (axiCfgReg.AxADDR(12,20 bits)===0) && io.axi_in.w.fire
        )
        mem2.write(
          address = axiCfgReg.AxADDR(0,12 bits) ,
          data = io.axi_in.w.payload.data,
          enable = (axiCfgReg.AxADDR(12,20 bits)===1) && io.axi_in.w.fire
        )
        io.axi_in.w.ready := True
      }

      when(io.axi_in.w.fire){
        when(axiCfgReg.full){
          axiCfgReg.in_burst_trans := False
          goto(W_RSP)
        }otherwise{
          goto(W_DATA)
        }
      }otherwise{
        axiCfgReg.in_burst_trans := False
        goto(W_DATA)
      }

    }

    W_RSP.whenIsActive{
      io.axi_in.w.ready := False

      io.axi_in.b.payload.id := axiCfgReg.AxID
      io.axi_in.b.payload.resp := Axi4.resp.OKAY
      io.axi_in.b.payload.user := user

      io.axi_in.b.valid := True

      when(io.axi_in.b.fire){
        goto(IDLE)
      }
    }

    R_ADDR.whenIsActive{

      axiCfgReg.regConfigAr()
      io.axi_in.ar.ready := True

      when(io.axi_in.ar.fire){

//        io.axi_in.r.payload.data := mem1.readSync(address = axiCfgReg.AxADDR(0,12 bits),enable = (axiCfgReg.AxADDR(12,20 bits)===0) && io.axi_in.r.valid)
        goto(R_DATA)
      }
    }


    R_DATA.whenIsActive{
      io.axi_in.ar.ready := False


      io.axi_in.r.payload.data := mem1.readAsync(address = axiCfgReg.AxADDR(0,12 bits))//,enable = (axiCfgReg.AxADDR(12,20 bits)===0) && io.axi_in.r.valid )
//      io.axi_in.r.payload.data := mem2.readSync(address = axiCfgReg.AxADDR(0,12 bits),enable = (axiCfgReg.AxADDR(12,20 bits)===1))

      io.axi_in.r.payload.id := axiCfgReg.AxID
      io.axi_in.r.payload.user := user
      io.axi_in.r.payload.resp := Axi4.resp.OKAY

      io.axi_in.r.valid := True

      when(io.axi_in.r.fire){
        when(axiCfgReg.full){
          io.axi_in.r.payload.last := True
          axiCfgReg.in_burst_trans := False
          goto(IDLE)
        }otherwise{
          io.axi_in.r.payload.last := False
          axiCfgReg.in_burst_trans := True
          goto(R_DATA)
        }
      }otherwise{
        axiCfgReg.in_burst_trans := False
        goto(R_DATA)
      }
    }
  }

}







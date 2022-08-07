package zqc.DMA

import spinal.core.in.Bits
import spinal.core.{Bits, _}
import spinal.core.internals.Operator
import spinal.lib._

case class strict_round_arbt() extends Component{
  val io = new Bundle{
    val req0,req1,req2,req3 = in(Bool())
    val gnt0,gnt1,gnt2,gnt3 = out(Reg(Bool())) init(False)

    val gnt_id = out(UInt(2 bits))

    val rstn = in(Bool())

  }

//  val gnt0,gnt1,gnt2,gnt3 = Reg(Bool()) init(False)
//  io.gnt0 := gnt0
//  io.gnt1 := gnt1
//  io.gnt2 := gnt2
//  io.gnt3 := gnt3


  val arbt_time_d = Reg(Bool()) init(False)

  val cur_pri = Reg(UInt(8 bits)) init(0)//bit[1:0]: highest priority ID; bit[7:6] : lowest priority ID
  val gnt_id_w = Reg(UInt(2 bits)) init(0)// 0~3 : real win request ID
  val gnt_id_fix = Reg(UInt(2 bits)) init(0)// 0~3 : win ID as fixed arbt stage

  val fix_req0,fix_req1,fix_req2,fix_req3 = Reg(Bool()) init(False)

  val arbt_time = (!arbt_time_d) & (io.req0 | io.req1 | io.req2 | io.req3)

  switch(cur_pri(0,2 bits)){
    is(0){
      fix_req0 := io.req0
    }
    is(1){
      fix_req0 := io.req1
    }
    is(2){
      fix_req0 := io.req2
    }
    is(3){
      fix_req0 := io.req3
    }
  }

  switch(cur_pri(2,2 bits)){
    is(0){
      fix_req1 := io.req0
    }
    is(1){
      fix_req1 := io.req1
    }
    is(2){
      fix_req1 := io.req2
    }
    is(3){
      fix_req1 := io.req3
    }
  }

  switch(cur_pri(4,2 bits)){
    is(0){
      fix_req2 := io.req0
    }
    is(1){
      fix_req2 := io.req1
    }
    is(2){
      fix_req2 := io.req2
    }
    is(3){
      fix_req2 := io.req3
    }
  }

  switch(cur_pri(6,2 bits)){
    is(0){
      fix_req3 := io.req0
    }
    is(1){
      fix_req3 := io.req1
    }
    is(2){
      fix_req3 := io.req2
    }
    is(3){
      fix_req3 := io.req3
    }
  }

  when(fix_req0){
    gnt_id_fix := 0
  }otherwise{
    when(fix_req1){
      gnt_id_fix := 1
    }otherwise{
      when(fix_req2){
        gnt_id_fix := 2
      }otherwise{
        when(fix_req3){
          gnt_id_fix := 3
        }
      }
    }
  }

  switch(gnt_id_fix){
    is(0){
      gnt_id_w := cur_pri(0,2 bits)
    }
    is(1){
      gnt_id_w := cur_pri(2,2 bits)
    }
    is(2){
      gnt_id_w := cur_pri(4,2 bits)
    }
    is(3){
      gnt_id_w := cur_pri(6,2 bits)
    }
  }

  when(!io.rstn){
    io.gnt0 := False
    io.gnt1 := False
    io.gnt2 := False
    io.gnt3 := False
  }otherwise{
    when(arbt_time){
      switch(gnt_id_w){
        is(0){
          io.gnt0 := True
        }
        is(1){
          io.gnt1 := True
        }
        is(2){
          io.gnt2 := True
        }
        is(3){
          io.gnt3 := True
        }
      }
    }otherwise{
      when(arbt_time_d){
        io.gnt0 := False
        io.gnt1 := False
        io.gnt2 := False
        io.gnt3 := False
      }
    }
  }

  io.gnt_id := 0
  when(!io.rstn){
    io.gnt_id := 0
  }otherwise{
    when(arbt_time){
      io.gnt_id := gnt_id_w
    }
  }

  when(!io.rstn){
    cur_pri := Vec(U(3,2 bits),U(2,2 bits),U(1,2 bits),U(0,2 bits)).asBits.asUInt
  }otherwise{
    when(arbt_time){
      switch(gnt_id_fix){
        is(0){
          cur_pri := Vec(cur_pri(2,6 bits),cur_pri(0,2 bits)).asBits.asUInt
        }
        is(1){
          cur_pri := Vec(cur_pri(0,2 bits),cur_pri(4,4 bits),cur_pri(2,2 bits)).asBits.asUInt
        }
        is(2){
          cur_pri := Vec(cur_pri(0,4 bits),cur_pri(6,2 bits),cur_pri(4,2 bits)).asBits.asUInt
        }
        is(3){
          cur_pri := Vec(cur_pri(6,2 bits), cur_pri(0,6 bits)).asBits.asUInt
        }
      }
    }
  }

  when(!io.rstn){
    arbt_time_d := False
  }otherwise{
    arbt_time_d := arbt_time
  }

}

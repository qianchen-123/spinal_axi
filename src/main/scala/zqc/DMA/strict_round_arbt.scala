package zqc.DMA

import spinal.core.in.Bits
import spinal.core.{Bits, _}
import spinal.core.internals.Operator
import spinal.lib._

case class strict_round_arbt() extends Component{
  val io = new Bundle{
    val req0,req1,req2,req3 = in Bool()
    val gnt0,gnt1,gnt2,gnt3 = out Bool()

    val gnt_id = out(UInt(2 bits))

    //--- Global Signal
    val clk = in Bool()
    val rstn = in Bool()

  }

//  val gnt0,gnt1,gnt2,gnt3 = Reg(Bool()) init(False)
//  io.gnt0 := gnt0
//  io.gnt1 := gnt1
//  io.gnt2 := gnt2
//  io.gnt3 := gnt3
  val clkDomain = ClockDomain(clock = io.clk,
    reset = io.rstn,
    config = ClockDomainConfig(
      clockEdge = RISING,
      resetKind = ASYNC,
      resetActiveLevel = LOW
    )
  )

  val myArea = new ClockingArea(clkDomain) {


    val arbt_time_d = Reg(Bool()) init (False)

    val cur_pri = Reg(UInt(8 bits)) init (Vec(U(0, 2 bits),U(1, 2 bits), U(2, 2 bits), U(3, 2 bits)).asBits.asUInt) //bit[1:0]: highest priority ID; bit[7:6] : lowest priority ID
    val gnt_id_w = UInt(2 bits) // 0~3 : real win request ID
    val gnt_id_fix = UInt(2 bits) // 0~3 : win ID as fixed arbt stage
    gnt_id_fix := 0

    val fix_req0, fix_req1, fix_req2, fix_req3 = Bool()

    val arbt_time = (!arbt_time_d) & (io.req0 | io.req1 | io.req2 | io.req3)

    switch(cur_pri(0, 2 bits)) {
      is(0) {
        fix_req0 := io.req0
      }
      is(1) {
        fix_req0 := io.req1
      }
      is(2) {
        fix_req0 := io.req2
      }
      is(3) {
        fix_req0 := io.req3
      }
    }

    switch(cur_pri(2, 2 bits)) {
      is(0) {
        fix_req1 := io.req0
      }
      is(1) {
        fix_req1 := io.req1
      }
      is(2) {
        fix_req1 := io.req2
      }
      is(3) {
        fix_req1 := io.req3
      }
    }

    switch(cur_pri(4, 2 bits)) {
      is(0) {
        fix_req2 := io.req0
      }
      is(1) {
        fix_req2 := io.req1
      }
      is(2) {
        fix_req2 := io.req2
      }
      is(3) {
        fix_req2 := io.req3
      }
    }

    switch(cur_pri(6, 2 bits)) {
      is(0) {
        fix_req3 := io.req0
      }
      is(1) {
        fix_req3 := io.req1
      }
      is(2) {
        fix_req3 := io.req2
      }
      is(3) {
        fix_req3 := io.req3
      }
    }

    when(fix_req0) {
      gnt_id_fix := 0
    } otherwise {
      when(fix_req1) {
        gnt_id_fix := 1
      } otherwise {
        when(fix_req2) {
          gnt_id_fix := 2
        } otherwise {
          when(fix_req3) {
            gnt_id_fix := 3
          }
        }
      }
    }

    switch(gnt_id_fix) {
      is(0) {
        gnt_id_w := cur_pri(0, 2 bits)
      }
      is(1) {
        gnt_id_w := cur_pri(2, 2 bits)
      }
      is(2) {
        gnt_id_w := cur_pri(4, 2 bits)
      }
      is(3) {
        gnt_id_w := cur_pri(6, 2 bits)
      }
    }

    val gnt0,gnt1,gnt2,gnt3 = Reg(Bool()) init(False)
    io.gnt0 := gnt0
    io.gnt1 := gnt1
    io.gnt2 := gnt2
    io.gnt3 := gnt3

    when(arbt_time) {
      switch(gnt_id_w) {
        is(0) {
          gnt0 := True
        }
        is(1) {
          gnt1 := True
        }
        is(2) {
          gnt2 := True
        }
        is(3) {
          gnt3 := True
        }
      }
    } otherwise {
      when(arbt_time_d) {
        gnt0 := False
        gnt1 := False
        gnt2 := False
        gnt3 := False
      }
    }


    val gnt_id = Reg(UInt(2 bits)) init(0)
    io.gnt_id := gnt_id

    when(arbt_time) {
      gnt_id := gnt_id_w
    }



    when(arbt_time) {
      switch(gnt_id_fix) {
        is(0) {
          cur_pri := Vec(cur_pri(7 downto 2), cur_pri(1 downto 0)).asBits.asUInt
        }
        is(1) {
          cur_pri := Vec(cur_pri(1 downto 0), cur_pri(7 downto 4), cur_pri(3 downto 2)).asBits.asUInt
        }
        is(2) {
          cur_pri := Vec(cur_pri(3 downto 0), cur_pri(7 downto 6), cur_pri(5 downto 4)).asBits.asUInt
        }
        is(3) {
          cur_pri := Vec(cur_pri(5 downto 0), cur_pri(7 downto 6)).asBits.asUInt
        }
      }
    }



    arbt_time_d := arbt_time

  }

}

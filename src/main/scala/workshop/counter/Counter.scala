package workshop.counter

import spinal.core._

case class Counter(width: Int) extends Component {
  val io = new Bundle {
    val clk = in Bool()
    val rstn = in Bool()
    val clear    = in  Bool()
    val value    = out UInt(width bits)
    val full     = out Bool()
  }

  val myClockDomain = ClockDomain(
    clock = io.clk,
    reset = io.rstn,
    config = ClockDomainConfig(
      clockEdge = RISING,
      resetKind = ASYNC,
      resetActiveLevel = LOW
    )
  )

  val myArea = new ClockingArea(myClockDomain){
    //TODO define the logic
    val counter = Reg(UInt(width bits)) init(0)
    val counter1 = UInt(width bits)
    counter1 := 0
    counter := counter + 1
    when(io.clear){
      counter := 0
    }

    when(io.clear){
      counter1 := counter + 1
    }

    io.value := counter
    io.full := counter === (U"1" << width) - 1
  }


}

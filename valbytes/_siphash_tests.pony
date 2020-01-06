use "ponytest"
use "ponycheck"

primitive SiphashTests is TestList
  fun tag tests(test: PonyTest) =>
    test(Property1UnitTest[String](_SipHash24Property))
    test(Property1UnitTest[Array[U8]](_SipHash24StreamingProperty))
    test(Property1UnitTest[Array[U8]](_HalfSipHash24StreamingProperty))

class iso _SipHash24Property is Property1[String]
  """checks conformance with stdlib implementation."""

  fun name(): String => "siphash24/property"

  fun gen(): Generator[String] =>
    Generators.byte_string(
      Generators.u8(),
      0,
      100000
    )

  fun property(sample: String, h: PropertyHelper) =>
    let my_siphash =
      ifdef ilp32 then
        HalfSipHash24.apply[String](sample).usize()
      else
        SipHash24.apply[String](sample).usize()
      end
    h.assert_eq[USize](my_siphash, sample.hash())

class iso _SipHash24StreamingProperty is Property1[Array[U8]]
  fun name(): String => "siphash24/streaming/property"

  fun gen(): Generator[Array[U8]] =>
    let sizeGen = Generators.usize(where min=0, max=100)
    sizeGen.flat_map[Array[U8]]({(size: USize) =>
      let arr_size = size * 8
      Generators.array_of[U8](Generators.u8() where min = arr_size, max = arr_size)
    })

  fun property(sample: Array[U8], h: PropertyHelper) ? =>
    var i: USize = 0
    let endi = sample.size() - (sample.size() % 8)
    let sip = SipHash24Streaming.create()

    while i < endi do
      let m = sample.read_u64(i)?
      sip.update(m)
      i = i + 8
    end
    let streaming_hash = sip.finish()
    let array_hash = SipHash24.apply[Array[U8]](sample)
    h.assert_eq[U64](array_hash, streaming_hash)


class iso _HalfSipHash24StreamingProperty is Property1[Array[U8]]
  fun name(): String => "halfsiphash24/streaming/property"

  fun gen(): Generator[Array[U8]] =>
    let sizeGen = Generators.usize(where min=0, max=100)
    sizeGen.flat_map[Array[U8]]({(size: USize) =>
      let arr_size = size * 4
      Generators.array_of[U8](Generators.u8() where min = arr_size, max = arr_size)
    })

  fun property(sample: Array[U8], h: PropertyHelper) ? =>
    var i: USize = 0
    let endi = sample.size() - (sample.size() % 4)
    h.log("size: " + sample.size().string())
    let sip = HalfSipHash24Streaming.create()

    while i < endi do
      let m = sample.read_u32(i)?
      sip.update(m)
      i = i + 4
    end
    let streaming_hash = sip.finish()
    let array_hash = HalfSipHash24.apply[Array[U8]](sample)
    h.assert_eq[U32](array_hash, streaming_hash)


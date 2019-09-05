use "ponytest"
use "ponycheck"

primitive SiphashTests is TestList
  fun tag tests(test: PonyTest) =>
    test(Property1UnitTest[String](_SipHash24Property))

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
        _HalfSipHash24.apply[String](sample).usize()
      else
        _SipHash24.apply[String](sample).usize()
      end
    h.assert_eq[USize](my_siphash, sample.hash())


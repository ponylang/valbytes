use ".."
use "ponytest"

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  fun tag tests(test: PonyTest) =>
    test(NumericReadableTest)
    SiphashTests.tests(test)


class iso NumericReadableTest is UnitTest
  fun name(): String => "valbytes/numeric-readable"
  fun apply(h: TestHelper) =>
    let arr: Array[U8] val = [as U8: 1; 2; 3; 4]
    let nr: ReadAsNumerics = arr

    let ba = ByteArrays([as U8: 1; 2; 3], [as U8: 4])


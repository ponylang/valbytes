use "collections" // for getting Hashable

interface val Trimmable[T]
  fun val trim(from: USize, to: USize): Array[T] val

interface CopyToable[T]
  fun copy_to(
    dst: Array[this->T!],
    src_idx: USize,
    dst_idx: USize,
    len: USize)

interface val ReadAsNumerics
  fun read_u8[B: U8 = U8](offset: USize): U8 ?
  fun read_u16[B: U8 = U8](offset: USize): U16 ?
  fun read_u32[B: U8 = U8](offset: USize): U32 ?
  fun read_u64[B: U8 = U8](offset: USize): U64 ?
  fun read_u128[B: U8 = U8](offset: USize): U128 ?

interface val ValBytes is (ReadSeq[U8] & Trimmable[U8] & CopyToable[U8] & ReadAsNumerics)
  """
  Tries to catch both Array[U8] val and ByteArrays in order to define
  ByteArrays as possibly recursive tree structure.
  """

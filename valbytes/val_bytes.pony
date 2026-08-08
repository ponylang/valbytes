use "collections" // for getting Hashable

interface val Trimmable[T]
  """
  Supports extracting a sub-range as an immutable
  array.
  """

  fun val trim(from: USize, to: USize): Array[T] val
    """
    Return elements from `from` up to but not
    including `to`.
    """

interface CopyToable[T]
  """
  Supports copying a range of elements into a
  destination array.
  """

  fun copy_to(
    dst: Array[this->T!],
    src_idx: USize,
    dst_idx: USize,
    len: USize)
    """
    Copy `len` elements starting at `src_idx` into
    `dst` at `dst_idx`.
    """

interface val ReadAsNumerics
  """
  Read multi-byte unsigned integers at a byte offset.
  """

  fun read_u8[B: U8 = U8](offset: USize): U8 ?
    """
    Read a U8 at the given byte offset.
    """

  fun read_u16[B: U8 = U8](offset: USize): U16 ?
    """
    Read a little-endian U16 at the given byte
    offset.
    """

  fun read_u32[B: U8 = U8](offset: USize): U32 ?
    """
    Read a little-endian U32 at the given byte
    offset.
    """

  fun read_u64[B: U8 = U8](offset: USize): U64 ?
    """
    Read a little-endian U64 at the given byte
    offset.
    """

  fun read_u128[B: U8 = U8](offset: USize): U128 ?
    """
    Read a little-endian U128 at the given byte
    offset.
    """

interface val ValBytes is
  (ReadSeq[U8] & Trimmable[U8] & CopyToable[U8]
    & ReadAsNumerics)
  """
  Tries to catch both Array[U8] val and ByteArrays
  in order to define ByteArrays as possibly recursive
  tree structure.
  """

primitive EmptyValBytes is ValBytes
  """
  A zero-length ValBytes that errors on any element
  access.
  """

  fun val trim(
    from: USize,
    to: USize)
    : Array[U8] val
  =>
    recover val Array[U8](0) end

  fun copy_to(
    dst: Array[U8],
    src_idx: USize,
    dst_idx: USize,
    len: USize)
  =>
    None

  fun read_u8[B: U8 = U8](
    offset: USize): U8 ?
  =>
    error

  fun read_u16[B: U8 = U8](
    offset: USize): U16 ?
  =>
    error

  fun read_u32[B: U8 = U8](
    offset: USize): U32 ?
  =>
    error

  fun read_u64[B: U8 = U8](
    offset: USize): U64 ?
  =>
    error

  fun read_u128[B: U8 = U8](
    offset: USize): U128 ?
  =>
    error

  fun size(): USize => 0
  fun apply(i: USize): U8 ? => error

  fun values(): Iterator[U8] ref^ =>
    object ref is Iterator[U8]
      fun has_next(): Bool => false
      fun next(): U8 ? => error
    end

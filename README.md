# valbytes

Library for dealing with concatenated byte arrays as if it was a single byte array.

Example usage:

```pony
var ba = ByteArrays
ba = ba + "foo" + " " + "bar"

ba.string(0, 3)        // "foo"
ba.take(3).string()    // "foo"
ba.drop(4).string()    // "bar"

for elem in ba.arrays().values() do
  env.out.print(elem)  // "foo", " ", "bar"
end
```

## Status

pony-valbytes is pre-alpha software.

## Installation

* Add valbytes to your build dependencies using [corral](https://github.com/ponylang/corral):

```
corral add github.com/ponylang/valbytes
```

* Execute `corral fetch` to fetch your dependencies.
* Include this package by adding `use "valbytes" to your pony sources.

* Exeute `corral run -- ponyc` to compile your application.

# pony-valbytes

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

[![CircleCI](https://circleci.com/gh/mfelsche/pony-valbytes.svg?style=svg)](https://circleci.com/gh/mfelsche/pony-valbytes)

pony-valbytes is pre-alpha software.

## Installation

* Install [pony-stable](https://github.com/ponylang/pony-stable)
* Update your `bundle.json`

```json
{
  "type": "github",
  "repo": "mfelsche/pony-valbytes"
}
```

* `stable fetch` to fetch your dependencies
* `use "valbytes"` to include this package
* `stable env ponyc` to compile your application

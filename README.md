<p align="center">Write any value to file.</p>

<p align="center"><img src="./pencil.png" width="150" alt="pencil_logo" /></p>

<p align="center"><img src="https://img.shields.io/badge/Platform-iOS-blue.svg" alt="platform-ios" /> <img src="https://img.shields.io/badge/Carthage-compatible-brightgreen.svg" alt="carthage-compatible" /> <img src="https://img.shields.io/badge/Swift-3.0-orange.svg" alt="swift-3.0" /> <img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="MIT" /></p>

Use of value types is recommended and we define standard values, simple structured data, application state and etc. as struct. 
Pencil makes us store these values more easily.

## Installation

__Carthage__

```
github "naru-jpn/Pencil"
```

## Usage

### Standard values: write to file / read from file path

#### Int

```swift
let num: Int = 2016

// create stored url
guard let storedURL = Directory.Documents?.append(path: "int.data") else {
  return
}
// write
num.write(to: storedURL)

...

// read
let stored: Int? = Int.value(from: storedURL)
```

#### String

```swift
let text: String = "Pencil store value easily."

guard let storedURL = Directory.Documents?.append(path: "text.data") else {
  return
}
text.write(to: storedURL)

...

let stored: String? = String.value(from: storedURL)
```

#### Array (containing writable values)

```swift
let nums: [Int] = [2016, 11, 28]

guard let storedURL = Directory.Documents?.append(path: "nums.data") else {
  return
}
nums.write(to: storedURL)

...

let stored: [Int]? = [Int].value(from: storedURL)
```

#### Dictionary (contaning writable values and string key)

```swift
let dictionary: [String: Int] = ["year": 2016, "month": 11, "day": 28]

guard let storedURL = Directory.Documents?.append(path: "dictionary.data") else {
  return
}
dictionary.write(to: url)

...

let stored: [String: Int]? = [String: Int].value(from: url)
```

Other standard writable and readable values are `Float`, `Double`, `Int8`, `Int16`, `Int32`, `Int64`, `UInt`, `UInt8`, `UInt16`, `UInt32` and `UInt64` .


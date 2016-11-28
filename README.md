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

// ...

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

// ...

let stored: String? = String.value(from: storedURL)
```

#### Array (containing writable values)

```swift
let nums: [Int] = [2016, 11, 28]

guard let storedURL = Directory.Documents?.append(path: "nums.data") else {
  return
}
nums.write(to: storedURL)

// ...

let stored: [Int]? = [Int].value(from: storedURL)
```

#### Dictionary (contaning writable values with string key)

```swift
let dictionary: [String: Int] = ["year": 2016, "month": 11, "day": 28]

guard let storedURL = Directory.Documents?.append(path: "dictionary.data") else {
  return
}
dictionary.write(to: storedURL)

// ...

let stored: [String: Int]? = [String: Int].value(from: url)
```

Other standard writable and readable values are `Float`, `Double`, `Int8`, `Int16`, `Int32`, `Int64`, `UInt`, `UInt8`, `UInt16`, `UInt32` and `UInt64`.

### Custom struct: write to file / read from file path

#### Define writable and readable custom struct

1. Define custom struct (named `Sample` in this case).
1. Conform protocol `CustomReadWriteElement`.
1. Implement `read` for function returning `Sample?` from `Components`.
  - Currying init function.
  - Apply each parameters with parameter name.

```swift
struct Sample: CustomReadWriteElement {
    
  let dictionary: [String: Int]
  let array: [Int]?
  let identifier: String
    
  static var read: (Components) -> Sample? = { components in
    do {
      return try Sample.init
        =<> components.component(for: "dictionary")
        -<> components.component(for: "array")
        -<> components.component(for: "identifier")
    } catch {
      return nil
    }
  }
}
```

#### write to file / read from file path

Read and write values by the same way with standard values.

```swift
let sample: Sample = Sample(dictionary: ["one": 2, "two": 5], array: [2, 3], identifier: "abc123")

guard let storedURL = Directory.Documents?.append(path: "sample.data") else {
  return
}
sample.write(to: storedURL)

// ...

let stored: Sample? = Sample.value(from: url)
```

#### Complex values containing custom struct

You can now write and read complex value containing custom struct.

```swift
let sample: Sample = Sample(dictionary: ["one": 2, "two": 5], array: [2, 3], identifier: "abc123")
let samples: [Samples] = [sample, sample, sample]

guard let storedURL = Directory.Documents?.append(path: "samples.data") else {
  return
}
samples.write(to: storedURL)

// ...

let stored: [Sample]? = [Sample].value(from: url)
```

#### Read struct with default parameters

Define writable and readable custom struct with default values. You need not to `try` if all properties have default values or optional.

```swift
struct Sample: CustomReadWriteElement {
    
    let dictionary: [String: Int]
    let array: [Int]?
    let identifier: String
    
    static var read: (Components) -> Sample? = { components in      
        return Sample.init
            =<> components.component(for: "dictionary", defaultValue: ["default":100])
            -<> components.component(for: "array")
            -<> components.component(for: "identifier", defaultValue: "default")
    }
}
```

### Create stored file path

Pencil support to create file path using class `Directory`.

```swift
// Create path ~/Documents/pencil.data
let url: URL? = Directory.Documents?.append(path: "pencil.data")
```

Other directories are `Applications`, `Demos`, `Documentation`, `Documents`, `AutosavedInformation`, `Caches` and `Downloads`.

## Example

[PencilExample](https://github.com/naru-jpn/pencil/tree/master/Example)

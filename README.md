<!--# Pencil-->

<p align="center"><img src="./pencil.png" width="170" alt="pencil_logo" /></p>

<p align="center"><img src="https://img.shields.io/badge/Platform-iOS-blue.svg" alt="platform-ios" /> <img src="https://img.shields.io/badge/Carthage-compatible-brightgreen.svg" alt="carthage-compatible" /> <img src="https://img.shields.io/badge/Pod-0.0.7-blue.svg" alt="cocoapods-compatible" /> <img src="https://img.shields.io/badge/Swift-3.0-orange.svg" alt="swift-3.0" /> <img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="MIT" /></p>

<!--
<p align="center">Write any value to file.</p>

<p align="center"><img src="./pencil.png" width="150" alt="pencil_logo" /></p>

<p align="center"><img src="https://img.shields.io/badge/Platform-iOS-blue.svg" alt="platform-ios" /> <img src="https://img.shields.io/badge/Carthage-compatible-brightgreen.svg" alt="carthage-compatible" /> <img src="https://img.shields.io/badge/Pod-0.0.7-blue.svg" alt="cocoapods-compatible" /> <img src="https://img.shields.io/badge/Swift-3.0-orange.svg" alt="swift-3.0" /> <img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="MIT" /></p>
-->

Use of value types is recommended and we define standard values, simple structured data, application state and etc. as struct. 
Pencil makes us store these values more easily.

## Installation

__Carthage__

```
github "naru-jpn/Pencil"
```

__CocoaPods__

```
pod 'pencil'
```

__Swift Package Manager__

Compatible.

__Manually__

Copy all `*.swift` files contained in `Sources` directory into your project. 

## Example of read/write data

- __Application state such as tab index application selected at last time.__
  - You can write `Int` value into file on device and read it.
- __Recently user inserted textfield value.__
  - You can write `String` value into file named for each textfield and read it.
- __Structured data without any DB system.__
  - You can write struct values into file on device and read it.

## Usage

### Standard values: write to file / read from file path

#### Int

```swift
// (create stored url)
guard let storedURL = Directory.Documents?.append(path: "int.data") else {
  return
}

let num: Int = 2016

// write
num.write(to: storedURL)

// ...

// read
let stored: Int? = Int.value(from: storedURL)
```

#### String

```swift
let text: String = "Pencil store value easily."
text.write(to: storedURL)

// ...

let stored: String? = String.value(from: storedURL)
```

#### Array (containing writable values)

```swift
let nums: [Int] = [2016, 11, 28]
nums.write(to: storedURL)

// ...

let stored: [Int]? = [Int].value(from: storedURL)
```

#### Dictionary (contaning writable values with string key)

```swift
let dictionary: [String: Int] = ["year": 2016, "month": 11, "day": 28]
dictionary.write(to: storedURL)

// ...

let stored: [String: Int]? = [String: Int].value(from: url)
```

Other standard writable and readable values are `Float`, `Double`, `Int8`, `Int16`, `Int32`, `Int64`, `UInt`, `UInt8`, `UInt16`, `UInt32` and `UInt64`.

### Custom struct: write to file / read from file path

#### Define writable and readable custom struct

1. Define custom struct (named `Sample` in this case).
1. Conform protocol `CustomReadWriteElement`.
1. Implement `static var read` for function returning `Sample?` from `Components`.
  - Currying init function.
  - Apply each parameters with parameter name.

```swift
struct Sample: CustomReadWriteElement {
    
  let dictionary: [String: Int]
  let array: [Int]?
  let identifier: String
    
  static var read: (Components) -> Sample? = { components in
    do {
      return try Sample(
        dictionary: components.component(for: "dictionary"),
        array:      components.component(for: "array"),
        identifier: components.component(for: "identifier")
      )
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
sample.write(to: storedURL)

// ...

let stored: Sample? = Sample.value(from: url)
```

#### Complex values containing custom struct

You can now write and read complex values containing custom struct.

```swift
let sample: Sample = Sample(dictionary: ["one": 2, "two": 5], array: [2, 3], identifier: "abc123")
let samples: [Samples] = [sample, sample, sample]
samples.write(to: storedURL)

// ...

let stored: [Sample]? = [Sample].value(from: url)
```

#### Read struct with default parameters

Define custom struct with default parameters. You need not to `try` if all properties have default values or optional.

```swift
struct Sample: CustomReadWriteElement {
    
    let dictionary: [String: Int]
    let array: [Int]?
    let identifier: String
    
    static var read: (Components) -> Sample? = { components in      
        return Sample(
            dictionary: components.component(for: "dictionary", defaultValue: ["default": 100]),
            array:      components.component(for: "array"),
            identifier: components.component(for: "identifier", defaultValue: "default")
        )
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

## License

Pencil is released under the MIT license. See LICENSE for details.

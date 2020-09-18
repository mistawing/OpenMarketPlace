![Placeholder](https://user-images.githubusercontent.com/13930558/28310017-c3f8c296-6bb3-11e7-9572-83f99515149e.png)

[![Build Status](https://travis-ci.org/incetro/Transformer.svg?branch=master)](https://travis-ci.org/incetro/Transformer)
[![CocoaPods](https://img.shields.io/cocoapods/v/Transformer.svg)](https://img.shields.io/cocoapods/v/Transformer.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/incetro/Transformer/master/LICENSE.md)
[![Platforms](https://img.shields.io/cocoapods/p/Transformer.svg)](https://cocoapods.org/pods/Transformer)

Transformer is a framework written in Swift that makes it easy for you to convert your database models to plain objects. 

- [Features](#features)
- [Usage](#usage)
- [Requirements](#requirements)
- [Communication](#communication)
- [Installation](#installation)
- [Author](#author)
- [License](#license)

# Features:
- [x] Mapping database models to plain objects
- [x] Nested Objects (stand alone, in arrays or in dictionaries)
- [x] Struct support

## Supported frameworks
- [x] CoreData
- [ ] Realm

# Usage
To support mapping, a class or struct just needs to implement the ```Mappable``` protocol which includes the following functions:

```swift
init(with resolver: Resolver) throws
```
### CoreData:

```swift

class CategoryPlainObject: Mappable {
    
    let id: Int64
    let name: String
    
    var positions: [PositionPlainObject] = [] // Array of objects
    
    required init(with resolver: Resolver) throws {
        
        self.id        = try resolver.value("id")
        self.name      = try resolver.value("name")
        self.positions = try resolver.value("positions")
    }
}

class PositionPlainObject: Mappable {
    
    let id: Int64
    let name: String
    let price: Double
    
    var category: CategoryPlainObject? = nil // Nested object
    
    required init(with resolver: Resolver) throws {
        
        self.id       = try  resolver.value("id")
        self.name     = try  resolver.value("name")
        self.price    = try  resolver.value("price")
        self.category = try? resolver.value("category")
    }
}

struct User: Mappable {
    
    let id: Int64
    let name: String
    
    init(with resolver: Resolver) throws {
        
        self.id   = try resolver.value("id")
        self.name = try resolver.value("name")
    }
}

```

### Example - mapping from CoreData objects

```swift
/// A simple protocol for a nice exmaple

protocol Storable: class {
    
    static var entityName: String { get }
}

extension Storable where Self: NSManagedObject {
    
    static var entityName: String {
        
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
    
    init(in context: NSManagedObjectContext) {
        
        guard let entity = NSEntityDescription.entity(forEntityName: Self.entityName, in: context) else {
            
            fatalError("Cannot create entity for entity name: \(self.entityName)")
        }
        
        self.init(entity: entity, insertInto: context)
    }
}

class CategoryModelObject: NSManagedObject, Storable {
    
    @NSManaged var id: Int64
    @NSManaged var name: String
    @NSManaged var positions: NSSet
}

class PositionModelObject: NSManagedObject, Storable {
    
    @NSManaged var id: Int64
    @NSManaged var name: String
    @NSManaged var price: Double
    @NSManaged var category: CategoryModelObject
}

let categoryModelObject = CategoryModelObject(in: context)
let positionModelObject = PositionModelObject(in: context)

/// Fill some data to categoryModelObject & positionModelObject

...

/// And mapping from CoreData objects

let transformer = Transformer(from: .coredata)

let categoryPlainObject: CategoryPlainObject = try transformer.transform(from: categoryModelObject)
let positionPlainObject: PositionPlainObject = try transformer.transform(from: positionModelObject)

```

## Requirements
- iOS 8.0+ / macOS 10.9+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 8.1, 8.2, 8.3, and 9.0
- Swift 3.0, 3.1, 3.2, and 4.0

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate Transformer into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
use_frameworks!

target "<Your Target Name>" do
    pod "Transformer"
end
```

Then, run the following command:

```bash
$ pod install
```

### Manually

If you prefer not to use any dependency managers, you can integrate Transformer into your project manually.

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

  ```bash
  $ git init
  ```

- Add Transformer as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

  ```bash
  $ git submodule add https://github.com/incetro/Transformer.git
  ```

- Open the new `Transformer` folder, and drag the `Transformer.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `Transformer.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- You will see two different `Transformer.xcodeproj` folders each with two different versions of the `Transformer.framework` nested inside a `Products` folder.

    > It does not matter which `Products` folder you choose from, but it does matter whether you choose the top or bottom `Transformer.framework`.

- Select the top `Transformer.framework` for iOS and the bottom one for OS X.

    > You can verify which one you selected by inspecting the build log for your project. The build target for `Transformer` will be listed as either `Transformer iOS`, `Transformer macOS`, `Transformer tvOS` or `Transformer watchOS`.

- And that's it!

  > The `Transformer.framework` is automagically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.
  
## Author

incetro, incetro@ya.ru

## License

Transformer is available under the MIT license. See the LICENSE file for more info.

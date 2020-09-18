![Placeholder](https://user-images.githubusercontent.com/13930558/28310017-c3f8c296-6bb3-11e7-9572-83f99515149e.png)

[![Build Status](https://travis-ci.org/incetro/Reflex.svg?branch=master)](https://travis-ci.org/incetro/Reflex)
[![CocoaPods](https://img.shields.io/cocoapods/v/Reflex.svg)](https://img.shields.io/cocoapods/v/Reflex.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/incetro/Reflex/master/LICENSE.md)
[![Platforms](https://img.shields.io/cocoapods/p/Reflex.svg)](https://cocoapods.org/pods/Reflex)

Reflex is a framework written in Swift that makes it easy for you to reflect your swift objects

- [Features](#features)
- [Usage](#usage)
- [Requirements](#requirements)
- [Communication](#communication)
- [Installation](#installation)
- [Author](#author)
- [License](#license)

## Features
- [x] Reflection from the given object
- [x] Reflection with necessary ancestors properties
- [x] Reflection with all ancestors properties
- [x] Type checking
- [ ] Deep type checking
- [ ] Instant mapping for structures

## Usage

### Example hierarchy:
```swift
// MARK: - Human
 
class Human {
        
    let name: String
    let age: Int
        
    init(name: String, age: Int) {
            
        self.name = name
        self.age  = age
    }
}
    
// MARK: - Post
    
enum Post {
        
    case manager
    case programmer
    case designer
}
    
// MARK: - Project
    
struct Project {
        
    let name: String
}
    
// MARK: - Employee
    
class Employee: Human {
        
    let post: Post
        
    init(name: String, age: Int, post: Post) {
            
        self.post = post
            
        super.init(name: name, age: age)
    }
}
    
// MARK: - Manager
    
class Manager: Employee {
        
    let projects: [Project]
        
    init(name: String, age: Int, projects: Project...) {
            
        self.projects = projects
            
        super.init(name: name, age: age, post: .manager)
    }
}    
```
  
### Get information about the class
```swift
let project = Project(name: "Reflex")
let manager = Manager(name: "Joe", age: 21, projects: project)
    
let reflection = Reflector.reflect(from: manager)
  
reflection.isArray      // false
        
reflection.isClass      // true
        
reflection.isStruct     // false
        
reflection.isSet        // false
        
reflection.isOptional   // false
        
reflection.isDictionary // false
        
reflection.isEnum       // false
  
reflection.name         // ReflectorTests.Manager
      
reflection.shortName    // Manager
  
reflection.valueType == .class(named: "Manager") // true
  
reflection.valueType == .array(of: .int) // false
```
  
### Get information about children with ancestors options:
```swift
// MARK: - AncestorsRequirements

public enum AncestorsRequirements {
    
    case disabled
    
    case all
    
    case level(of: Int)
}  
```
  
#### Use ```.all```
  
```swift
let project = Project(name: "Reflex")
let manager = Manager(name: "Joe", age: 21, projects: project)
  
/// Reflector collects all properties from all hierarchy (Manager -> Employee -> Human)
let reflection = Reflector.reflect(from: manager, withAncestorsRequirements: .all)
  
reflection.childrenCount // 4
        
reflection.names  // ["projects", "post", "name", "age"]
        
reflection.values // ["name": "Joe", "projects": [Project(name: "Reflex")], "post": Post.manager, "age": 21]
  
reflection.types  // ["Array<custom<Project>>", "enum<Post>", "String", "Int"]
```
  
#### Use ```.level(of: Int)```
  
```swift
let project = Project(name: "Reflex")
let manager = Manager(name: "Joe", age: 21, projects: project)
  
/// Reflector collects all properties from 2 classes (Manager -> Employee)
let reflection = Reflector.reflect(from: manager, withAncestorsRequirements: .level(of: 2))
  
reflection.childrenCount // 2
        
reflection.names  // ["projects", "post"]

reflection.values // [[Project(name: "Reflex")], Post.manager]
  
reflection.types  // ["Array<custom<Project>>", "enum<Post>"]
```
  
#### Use ```.disabled```
  
```swift
let project = Project(name: "Reflex")
let manager = Manager(name: "Joe", age: 21, projects: project)
  
/// Reflector collects all properties from the given class (Manager)
let reflection = Reflector.reflect(from: manager) // .disabled by default
  
reflection.childrenCount // 1
        
reflection.names  // ["projects"]
        
reflection.values // [[Project(name: "Reflex")]]
  
reflection.types  // ["Array<custom<Project>>"]
```
  
### You can use subscript to get values:
```swift
let project = Project(name: "Reflex")
let manager = Manager(name: "Joe", age: 21, projects: project)
  
let reflection = Reflector.reflect(from: manager, withAncestorsRequirements: .all)
  
reflection["name"] // "Joe"
reflection["age"]  // 21
```
  
### You can use children reflections by name as a Reflection
```swift
let project = Project(name: "Reflex")
let manager = Manager(name: "Joe", age: 21, projects: project)
  
let reflection = Reflector.reflect(from: manager, withAncestorsRequirements: .all)
  
guard let enumReflection = reflection.children("post") else {
            
    return // if cannot get children with name "post"
}
  
enumReflection.isEnum // true
enumReflection.valueType == .enum(named: "Post") // true
```

### Reflect your arrays:
```swift
let array = [[0, 1, 2], [3, 4, 5]]
        
let reflection = Reflector.reflect(from: array)

reflection.isArray // true
reflection.type    // Array<Array<Int>>

reflection.valueType == .array(of: .array(of: .int)) // true
```

### Or dictionaries:
```swift
let dictionary: [String: Manager] = ["Andrew" : manager]
        
let reflection = Reflector.reflect(from: dictionary)
        
reflection.isDictionary // true
reflection.type         // Dictionary<String, class<Manager>>

reflection.valueType == .dictionary(key: .string, value: .class(named: "Manager")) // true
```

### Or sets:
```swift
let set: Set<Int> = [0, 1, 2, 3, 4]
        
let reflection = Reflector.reflect(from: set)
        
reflection.isSet // true
reflection.type  // Set<Int>

reflection.valueType == .set(of: .int) // true
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

To integrate Reflex into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
use_frameworks!

target "<Your Target Name>" do
    pod "Reflex"
end
```

Then, run the following command:

```bash
$ pod install
```

### Manually

If you prefer not to use any dependency managers, you can integrate Reflex into your project manually.

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

  ```bash
  $ git init
  ```

- Add Reflex as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

  ```bash
  $ git submodule add https://github.com/incetro/Reflex.git
  ```

- Open the new `Reflex` folder, and drag the `Reflex.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `Reflex.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- You will see two different `Reflex.xcodeproj` folders each with two different versions of the `Reflex.framework` nested inside a `Products` folder.

    > It does not matter which `Products` folder you choose from, but it does matter whether you choose the top or bottom `Reflex.framework`.

- Select the top `Reflex.framework` for iOS and the bottom one for OS X.

    > You can verify which one you selected by inspecting the build log for your project. The build target for `Reflex` will be listed as either `Reflex iOS`, `Reflex macOS`, `Reflex tvOS` or `Reflex watchOS`.

- And that's it!

  > The `Reflex.framework` is automagically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.
  
## Author

incetro, incetro@ya.ru

## License

Reflex is available under the MIT license. See the LICENSE file for more info.

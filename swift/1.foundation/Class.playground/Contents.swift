//: Playground - noun: a place where people can play

import UIKit
class Person {
    //以及值为可选 String 的 name 。 name 属性会被自动赋予一个默认值 nil
    var name : String = ""
    var age  = 0
    
}


struct Position {
    var x = 13
    var y = 0
}

var position1 = Position ()
print(position1.x)

var position2 = position1
print(position1.x)
print(position2.x)

position2.x = 14
print(position1.x)
print(position2.x)

let jack = Person()
jack.age = 18
jack.name = "jack"

print(jack.age)
print(jack.name)


//let bobo = Person(name:"bobo",age:15)
//print(bobo.age)
//print(bobo.name)

//与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝

let bobo = jack
print(bobo.age)
print(bobo.name)

bobo.age = 16

print(bobo.age)
print(bobo.name)
print(jack.age)
print(jack.name)
//**恒等运算符
//"==="表示两个类类型(class type)的常量或者变量引用同一个类实例。
if bobo === jack {
    print("等于")
}

//结构体实例总是通过值传递，类实例总是通过引用传递
//Swift 中，许多基本类型，诸如 String ， Array 和 Dictionary 类型均以结构体的形式实现。这意味着被赋值给 新的常量或变量，或者被传入函数或方法中时，它们的值会被拷贝。
//Objective-C 中 NSString ， NSArray 和 NSDictionary 类型均以类的形式实现，而并非结构体。它们在被赋值或 者被传入函数或方法时，不会发生值拷贝，而是传递现有实例的引用。


struct FixedLengthRange {
    var firstValue:Int
    var length:Int
}

var rangeOFThreeItems = FixedLengthRange(firstValue: 0, length: 3)

//**属性

//必须将延迟存储属性声明成变量(使用 var 关键字)，因为属性的初始值可能在实例构造完成之后才会得 到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延迟属性。
class DataImporter {
    var fileName = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    var  data  = [String]()
}

let manager = DataManager ()
print(manager.data)

//计算属性

struct Point {
    var x = 0.0
    var y = 0.0
}

struct Size {
    var width = 0.0
    var height = 0.0
}

struct Rect {
    var origin = Point ()
    var size = Size()
    var center:Point {
        get {
            let centerX = origin.x + size.width/2
            let centerY = origin.y + size.height/2
            return Point(x:centerX,y:centerY)
        }
        //如果计算属性的 setter 没有定义表示新值的参数名，则可以使用默认名称 newValue
        set {
            origin.x = newValue.x - size.width/2
            origin.y = newValue.y - size.height/2
        }
        
    }
}


var square = Rect(origin: Point(x:0.0,y:0.0), size: Size(width:10.0,height:10.0))
print(square)
var initialCenter = square.center
print(initialCenter)
square.center = Point(x:0.0,y:0.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")

print(square.center)
//只读计算属性的声明可以去掉   关键字和花括号:

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}




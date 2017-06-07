//
//  main.swift
//  Protocol
//
//  Created by wyy on 2017/6/2.
//  Copyright © 2017年 wyy. All rights reserved.
//

import Foundation

protocol SomeProtocol {
 //属性要求 它只指定属性的名称和类型 此外，协议还指定属性是可读的还是可读可写的
    var mustBeSetAndGet: Int { get set }
//    var doNotNeedBeSet: Int { get }
    init(someParameter:String)
}

//FullyNamed 协议除了要求遵循协议的类型提供 fullName 属性外，并没有其他特别的要求
//这个协议表示，任 何遵循 FullyNamed 的类型，都必须有一个可读的 String 类型的实例属性 fullName
protocol FullyName {
    var fullName: String { get }
}

protocol RandomNumberGenerator {
    func random() -> Double
}

class SomePeople:FullyName,SomeProtocol {
    

    var fullName: String
    //使用 required 修饰符可以确保所有子类也必须提供此构造器实现，从而也能符合协议。
    //如果类已经被标记为 final ，那么不需要在协议构造器的实现中使用 required 修饰符，因为 final 类不 能有子类。关于 final 修饰符的更多内容，请参见防止重写 (页 0)。
    required init(someParameter: String) {
        self.fullName = someParameter
    }
    
    init(name:String) {
        self.fullName = name
    }
    
    var mustBeSetAndGet: Int {
        set {
            
        }
        
        get {
            return 3
        }
    }
}

//方法要求
class linearCongruent:RandomNumberGenerator {
    func random() -> Double {
        print("....")
        return 3.0
    }
}

//Mutating 方法要求
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
     }
    }
}


//构造器要求
protocol P_A {
    init()
}

class class_A {
    required init() {
        
    }
}

//class class_subA: class_A, P_A{
//    required override init() {
//        
//    }
//}

//协议作为类型
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int,generator:RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
         return Int(generator.random() * Double(sides)) + 1
    }
}


var joy = SomePeople(name: "jay")
var liner = linearCongruent()

let result = liner.random()
print(result)

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()


var d6 = Dice(sides: 6, generator: linearCongruent())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

print(lightSwitch)
print("Hello, World!")


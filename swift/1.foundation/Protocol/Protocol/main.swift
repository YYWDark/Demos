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

var joy = SomePeople(name: "jay")
var liner = linearCongruent()

let result = liner.random()
print(result)
print("Hello, World!")


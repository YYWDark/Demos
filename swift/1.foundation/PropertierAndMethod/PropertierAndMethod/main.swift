//
//  main.swift
//  PropertierAndMethod
//
//  Created by wyy on 2017/5/31.
//  Copyright © 2017年 wyy. All rights reserved.
//

import Foundation
class StepCounter {
    var totalSteps :Int = 0 {
        willSet {
          print("About to set totalSteps to \(newValue)")
        }
        //didSet没有为旧值提供自定义名称，所以默认值oldValue表示旧值的参数名
        didSet {
            if totalSteps > oldValue {
            print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

class Counter{
    var count = 0
    func ins() {
       self.count += 1
    }
    func des(){
       count -= 1
    }
     func reset() {
       count = 0
    }
}

class SubCounter: Counter {
    class func reset() {
        print("custom ")
    }
}


class Vehicle {
    var currentSpeed = 0.0
    var hour:Double
    init() {
        currentSpeed = 2.0
        hour = 1.0;
    }
    
    init(_ speed:Double,_ time:Double) {
        currentSpeed = speed
        hour = time
    }
    var description:String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() -> Void {
        // 什么也不做-因为车辆不一定会有噪音
        print("Vehicle do nothing")
    }
}

class Bicycle: Vehicle {
    var hasBasket = false
    override func makeNoise() {
//        super.currentSpeed 
        print(super.currentSpeed)
        super.makeNoise()
        print("Bicycle do nothing")
    }
}

class Car:Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

class Construction {
    let text:String
    var response:String?
     init(text:String) {
        self.text = text
    }
    func ask (){
        print(text)
    }
}

let coun = Counter ()
//当被设置新值的时候它的willSet 和didSet同时也会被调用。

print("Hello, World!")
var stepCounter = StepCounter()
print(stepCounter.totalSteps)
stepCounter.totalSteps = 100
print(stepCounter.totalSteps)
stepCounter.totalSteps = 100

//类型的每一个实例都有一个隐含属性叫做 self ， self 完全等同于该实例本身
var counter = SubCounter()
counter.ins()
print(counter.count)
counter.ins()
print(counter.count)
counter.des()
print(counter.count)
counter.reset()
print(counter.count)

let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")
someVehicle .makeNoise()


let bike = Bicycle()
bike.currentSpeed = 15.0
print("bike: \(bike.description)")
bike .makeNoise()

let car = Car()
car.currentSpeed = 10.0
print(car.description)
//如果你创建了 Car 的实例并且设置了它的 gear 和 currentSpeed 属性，你可以看到它的 description 返回了 Car 中的自定义描述:


//*构造
//如果你不希望为构造器的某个参数提供外部名字，你可以使用下划线( _ )来显式描述它的外部名，以此重写上面 所说的默认行为。
let veh = Vehicle(3.0,3.0)
print("this spped is \(veh.currentSpeed) time is \(veh.hour)")

let cheeseQuestion = Construction(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."
//你可以在构造过程中的任意时间点给常量属性指定一个值，只要在构造过程结束时是一个确定的值。一旦常量属性被赋值，它将永远不可更改。






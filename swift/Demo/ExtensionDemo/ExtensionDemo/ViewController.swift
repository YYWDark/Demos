//
//  ViewController.swift
//  ExtensionDemo
//
//  Created by wyy on 2017/6/2.
//  Copyright © 2017年 wyy. All rights reserved.
//

import UIKit
//1.1扩展可以添加新计算属性, 但是不能添加存储属性(也不可以添加属性观察).
extension Double {
    var km: Double {return self * 1000.0}
}

//1.2构造器
class myClass {
    var a: Int
    init() {
        a = 10
    }
    
}

extension myClass {
    convenience init (parm:Int) {
        self.init()
        print("便利构造器")
    }
}

//1.3方法
extension Int {
    func repetitions(task:() -> Void) -> Void {
        for _ in 0..<self {
            task()
        }
    }
    
    mutating func square() {
        self = self * self
    }
    
    func findTheNumberByIndex(index:Int) -> Int {
        var decimalBase = 1
        for _ in 0..<index {
            decimalBase *= 10
        }
        return (self/decimalBase)%10
    }
}
//1.4可变实例方法
/*
 通过扩展添加的实例方法也可以修改该实例本身
 结构体和枚举类型中修改 self 或其属性的方法必须将该实例 方法标注为 mutating ，正如来自原始实现的可变方法一样。
 */

//1.4嵌套类型

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let km = 0.3
        print(km.km)
        
        print(myClass.init(parm: 5))
        let count = 2
        count.repetitions{
            print(".....")
        }
        print(count)
        print(type(of:count))
        var someInt = 3
        someInt.square()
        print(someInt)
        
        let result = 12345.findTheNumberByIndex(index: 6)
        print(result)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}








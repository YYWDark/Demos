//
//  main.swift
//  ARC
//
//  Created by wyy on 2017/6/1.
//  Copyright © 2017年 wyy. All rights reserved.
//

import Foundation

class Person {
    var name:String
    //apartment 属性是可选的，因为一个人并不总是拥有公寓
    var apartment:Apartment?
    init (name:String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}


class Apartment {
    let unit:String
    //因为一栋公寓并不总是有居民
    weak var tenant:Person?
    init(unit:String) {
        self.unit = unit
    }
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

class Customer {
    let name : String
    //不是每个人都有信用卡
    var card:CreditCard?
    init(name:String) {
        self.name = name
    }
     deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number : UInt64
    //每张卡绑定一个用户
    unowned var person:Customer
    init(number:UInt64, person:Customer) {
        self.number = number
        self.person = person
    }
     deinit { print("Card #\(number) is being deinitialized") }
}

class Country {
    let name: String
    //将 Country 的 capitalCity 属性声明为隐 式解析可选类型的属性。这意味着像其他可选类型一样， capitalCity 属性的默认值为 nil 但是不需要展开它 的值就能访问它
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

class HTMLElement {
    let name : String
    let text : String?
    //asHTML 声明为 lazy 属性，因为只有当元素确实需要被处理为 HTML 输出的字符串时，才需要使用 asHTML也
    //就是说，在默认的闭包中可以使用 self ，因为只有当初始化完成以及 self 确实存在后，才能访问 lazy 属性
    lazy var asHTML:(Void) -> String = {
        [weak self] in
        //下面是函数体
        if let text = self?.text {
            print("aaa")
             return "<\(self!.name)>\(text)</\(self!.name)>"
        }else {
            print("bbb")
            return "<\(self!.name) />"
        }
    }
    init (name:String,text:String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

/*
var reference1:Person?
var reference2:Person?
var reference3:Person?

reference1 = Person(name:"wyy")
reference2 = reference1
reference3 = reference1

//只有强指针不再指向它的时候 就销毁了
reference1 = nil
reference2 = nil
reference3 = nil

 */

//**循环引用
/*
var john:Person?
var unit4A:Apartment?

john = Person(name:"john")
unit4A = Apartment(unit:"4A")
//注意感叹号是用来展开和访 问可选变量 john 和 unit4A 中的实例，这样实例的属性才能被赋值
john!.apartment = unit4A
unit4A!.tenant = john

john = nil
unit4A = nil


 */
/*
 解决方案：弱引用 无主引用
 */

/*
var john:Customer?
john = Customer(name:"john")
john!.card = CreditCard(number: 1234_5678_9012_3456, person: john!)

john = nil
*/


/*
 闭包引起的循环强引用
 */
var heading = HTMLElement(name: "h1")
let defaultText = "some text"
heading.asHTML = {
     return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())

var paragraph: HTMLElement? = HTMLElement(name: "paragraph", text: "hello, world")
print(paragraph!.asHTML())
//上面的 paragraph 变量定义为可选类型的 HTMLElement ，因此我们可以赋值 nil 给它来演示循环强引用。
paragraph = nil
//不幸的是，上面写的 HTMLElement 类产生了类实例和作为 asHTML 默认值的闭包之间的循环强引用
print("Hello, World!")








//: Playground - noun: a place where people can play

import UIKit
//https://hran.me/archives/swift-closure-1.html
//http://www.runoob.com/swift/swift-closures.html

//let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
//
//names.sorted()
//names.sorted(by: >)
//names.sorted { (str1, str2) -> Bool in
//    return str1 > str2
//}


//names.sorted(by: <#T##(String, String) -> Bool#>)

//var reversedNames = names.sorted(by: { (str1, str2) -> Bool in
//    return str1 > str2
//})
//
//print(reversedNames)



//func square(n:Int) -> Int {
//    return n * n
//}
//
//let squareExpression = { (n: Int) -> Int in
//    return n * n
//}
//
//squareExpression(2)


let studentName = {
    print("swift 闭包实例")
}

studentName()

let square = { (value1:Int,value2:Int) -> Int in
    return value1 * value2
}

let result = square(100,100)

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

let backwardFunc = {(str1:String, str2:String) -> Bool in
    return str1 > str2
}

names.sorted(by: backwardFunc)
names.sorted(by: >)
//Swift 自动为内联函数提供了参数名称缩写功能，您可以直接通过$0,$1,$2来顺序调用闭包的参数。
print(names.sorted(by:{$0>$1}))

//**尾随闭包
names.sorted(){
    return $0>$1
}

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
type(of:digitNames)
let numbers = [16,58,510]
//局部变量 number 的值由闭包中的 number 参数获得，因此可以在闭包函数体内对其进行修改
let strings = numbers.map {
    (number : Int) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    
    return output
}

print(strings)

//**值捕获
//markIncrementer的返回的类型为 () -> Int函数
func markIncrementer(amout:Int) -> () -> Int {
   
    var runningTotal = 0
    func incrementer() -> Int {
         //incrementer() 函数并没有任何参数，但是在函数体内访问了 runningTotal 和 amount 变量。这是因为它从 外围函数捕获了 runningTotal 和 amount 变量的引用
        runningTotal += amout
        return  runningTotal
    }
    return incrementer
}
let incrementByTen = markIncrementer(amout: 3)
incrementByTen()
incrementByTen()
incrementByTen()
//如果你创建了另一个 incrementor ，它会有属于自己的引用，指向一个全新、独立的 runningTotal 变量:
let incrementByTen1 = markIncrementer(amout: 4)
incrementByTen1()
incrementByTen1()
incrementByTen1()

incrementByTen()


//**闭包是引用类型
//两个值都会指向同一个闭包:
let incrementByTen2 = incrementByTen
incrementByTen2()
incrementByTen()



//**逃逸闭包
var completionHandlers:[()->Void] = []
type(of:completionHandlers)
func someFunctionWithEscapingClosure(completionHandler:@escaping() -> Void) {
    completionHandlers.append(completionHandler)
}




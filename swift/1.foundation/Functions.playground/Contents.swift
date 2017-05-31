//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func greet(person:String) -> String {
   let greeting = "hello" + " " + person
   return greeting
}

greet(person:"wyy")

func sayHello(){
    print("empty returm value")
}

sayHello()

func greet(person:String,isSure:Bool) -> String {
    if isSure {
        return "哈哈";
    } else {
        return person;
    }
}

greet(person: "wyy", isSure: false)
greet(person: "bobo", isSure: true)

func findMaxValueInArray(sourceArray:Array<Double>) -> Double {
    var maxValue = 0.0;
    for value in sourceArray {
        if maxValue < value {
            maxValue = value
        }
    }
    return maxValue
}


findMaxValueInArray(sourceArray: [1.2,1.3,1.4,1])

//函数返回一个包含两个值的元组
func findMinAndMaxInArray(sourceArray:[Double]) -> (Double,Double) {
    var maxValue = 0.0
    var minValue = 0.0
    for value in sourceArray {
        if maxValue < value {
            maxValue = value
        }
        
        if minValue > value {
            minValue = value
        }
    }
    return (minValue,maxValue)
}

let value = findMinAndMaxInArray(sourceArray: [1.1,1.2,1.3,1.32,1.22,-12])
type(of:value)
print(value)


findMinAndMaxInArray(sourceArray: [])

//函数参数标签和参数名称
func someFunction(firstParameterName:Int,secondParameterName:Int) {
    
}

someFunction(firstParameterName: 1, secondParameterName: 2)


//指定参数标签
func someFuc (mark firstParameterName:Int) {
    
}
someFuc(mark: 3)

//可变参数 一个函数最多只能拥有一个可变参数。
func mutableParameters(numbers:Double...) -> Double{
    var total = 0.0
    for value in numbers {
        total += value
    }
    return total
}

mutableParameters(numbers: 1.0,1.2,1.3)

//在参数定义前加 inout 关键字。一个输入输出参数有传入函数的值，这个值被函数 修改，然后被传出函数，替换原来的值
//Swift是安全的语言，不允许两个不同类型互换值
func swapTwoValues(a:inout Int,b:inout Int) {
    let temA = b
    b = a
    a = temA
}

var a = 3
var b = 4

swapTwoValues(a: &a, b: &b)
print("\(a) \(b)")
print(a,b)

//泛型
//这个函数主体、功能跟上面的例子类似，用来交换两个同样类型的值，但是这个函数用 T 占位符来代替实际的类型。并没有指定具体的类型 但是传入的a ,b 必须是同一类型T
func swapTwoValueByGenericity<T>(a:inout T, b:inout T) -> Void {
    let tem = a
    a = b
    b = tem
}

var doubleA = 3.0
var doubleB = 4.0
swapTwoValueByGenericity(a: &doubleA, b: &doubleB)
print("\(doubleA) \(doubleB)")
//这个例子用泛型完美的解决了上述的问题，只需要定义一个泛型函数，只要保证 传入的两个参数是同一个类型，就不用根据传入参数的类型不同而写不同的方法。

var stringA = "A"
var stringB = "B"
swapTwoValueByGenericity(a: &stringA, b: &stringB)
print("\(stringA) \(stringB)")




func mul (_ m:Int, _ n:Int) -> Int {
    return m * n
}

mul(3,4)







//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var myName = "wyy"
var hours = 21
var Pi = 3.14
var isSure = true
var me = ("wyy",11,"dd")

me.0
me.1
me.2

Pi = 22.2

var number = 22.0


if number == 22.0 {
    print("正确的")
}

number += 20;

var x:Int
var s:String

Int.min
Int.max
Int16.min
INT32_MAX

var yourName:String;
var rowHeight : Double;
rowHeight =  (true ? 40 : 20)



var floatNumber:Float = 1/3;
var doubleNumber:Double = 1/3;

type(of:floatNumber)
type(of:doubleNumber)

Pi = doubleNumber + Double(hours);

for index in (1...2) {
    print("\(index)")
}

//字符串
let cafe = "Caf\u{00e9}"
var cafee = "Caf\u{0065}\u{0301}"
cafe.characters.count
cafee.characters.count

cafe.utf8.count
cafee.utf8.count

cafe == cafee


let begin = cafee.startIndex
//let end = cafee.endIndex
let end = cafee.index(begin, offsetBy: 1)
cafee[begin ..< end]

String(cafee.characters.prefix(3))
String(cafee.characters.dropLast())
cafee = String(cafee.characters.dropLast());
print(cafee)


var mixStr = "swift很有趣"

for (index,value) in mixStr.characters.enumerated() {
    print("\(index)\(value)")
}

let name = ["wyy","bobo","tanke","tuwei","xiaowei"]
type(of:name)
let count = name.count;
for index in 0..<count {
    print("第\(index+1)个人叫\(name[index])")
}



if let index = mixStr.characters.index(of: "很") {
    print("haha")
}


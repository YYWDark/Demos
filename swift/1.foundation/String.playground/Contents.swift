//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var emptyStr = ""
var anootherEmptyString = String()

if emptyStr.isEmpty{
    print("empty string")
}

if anootherEmptyString.isEmpty{
    print("empty string")
}

var variableString = "this is"
variableString += " my horse"

for character in variableString.characters {
    print("\(character)")
}

//字符
let exclamationMark : Character
exclamationMark = "!"
print(exclamationMark)

var string1 = "this "
var string2 = "is"
var welcome = string1 + string2

welcome.append(exclamationMark)

//字符串的插入
let multiplier = 3
let number = 2.5;
// multiplier 作为 \(multiplier) 被插入到一个字符串常量量中
let message = "\(multiplier) times \(number) is \(Double(multiplier) * number)"

//访问和修改字符串

//使用 属性可以获取一个的第一个的索引 使用属性可以获取最后一个 C 的后一个位置的索引
let greeting = "kobe my star!"
greeting[greeting.startIndex]
let end = greeting.endIndex
greeting[greeting.index(after:greeting.startIndex)]
greeting[greeting.index(before: end)]

let index = greeting.index(greeting.startIndex, offsetBy: 2)

for cha in greeting.characters {
    print(" \(cha)")
}

//插入和删除
var welcomeStr = "welcome"
welcomeStr.insert("!", at: welcomeStr.endIndex)
welcomeStr.insert(contentsOf: "!!".characters, at: welcomeStr.endIndex)

var char =  welcomeStr.remove(at: welcomeStr.index(welcomeStr.startIndex, offsetBy: 2))
print(welcomeStr)

welcomeStr .remove(at: welcomeStr.index(welcomeStr.startIndex, offsetBy: 3))
let range = welcomeStr.index(welcomeStr.startIndex, offsetBy: 3)..<welcomeStr.endIndex
//welcome.removeSubrange(range)
print(welcomeStr)


//比较字符串
let quot = "We're a lot alike, you and I."
let sameQuot = "We're a lot alike, you and I."
if quot == sameQuot {
    print("他妈的一样")
}

//前缀/后缀相等
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var count = 0
for scene in romeoAndJuliet {
    print(type(of:scene))
    if scene.hasPrefix("Act 1") {
       count += 1
    }
}

print(count)

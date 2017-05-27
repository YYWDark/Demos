//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var someInts = [Int]()
print("some is of type [Int] with \(someInts.count) items")

someInts.append(3)
print("some is of type [Int] with \(someInts.count) items")

someInts = []

var threeDoubles  = Array(repeatElement(0.0, count: 3))
type(of:threeDoubles)

var  shoplist:[String] = ["wyy","bobo"]

if shoplist.isEmpty == false {
    print("不是空的 大兄弟")
}

shoplist.append("kobe")

//访问
let name = shoplist[0]
shoplist[0] = "wangyayun"
print(shoplist)

shoplist[0...1] = ["tanke","xiaowei"]
print(shoplist)

shoplist.insert("zhu", at: 0)
shoplist.remove(at: 0)
print(shoplist)

for item in shoplist {
    print(item)
}


for (index, value) in shoplist.enumerated() {
    print("\(index) \(value)")
}

//集合
//集合类型的哈希值 一个类型为了存储在集合中，该类型必须是可哈希化的--也就是说，该类型必须提供一个方法来计算它的哈希 值。一个哈希值是 Int 类型的，相等的对象哈希值必须相同，比如 a==b ,因此必须 a.hashValue == b.hashValue。

var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")
letters.insert("a")
print(letters)

letters = []

var favoriteGenres:Set<String> = ["wyy","bobo","chenda"]
type(of:favoriteGenres)
let count = favoriteGenres.count
if favoriteGenres.isEmpty {
    print("空的")
}

favoriteGenres.insert("pengtao")
print(favoriteGenres)

let removeStr1 =  favoriteGenres.remove("pengtao")
let removeStr2 =  favoriteGenres.remove("pengtao1")

for (index, value) in favoriteGenres.enumerated() {
    print("\(index)\(value)")
}

for name in favoriteGenres {
    print(name)
}

favoriteGenres .removeAll()


let oldDigits = [1,3,5,7,9]
let evenDigits = [0,2,4,6,8]
let singleDigitPrimeNumber:Set = [2,3,5,7]

//字典

var dic:Dictionary<String,String> = ["3":"3"]
dic["key"] = "value"
print(dic)

dic.updateValue("4", forKey: "3")
print(dic)

dic .removeValue(forKey: "3")
print(dic)

print("遍历")
for (key,value) in dic {
    print("\(key)  \(value)")
}







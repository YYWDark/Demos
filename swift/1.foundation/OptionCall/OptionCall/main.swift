//
//  main.swift
//  OptionCall
//
//  Created by wyy on 2017/6/1.
//  Copyright © 2017年 wyy. All rights reserved.
//

import Foundation
/*
 可选链式调用是一种可以在当前值可能为 nil 的可选值上请求和调用属性、方法及下标的方法。如果可选值有 值，那么调用就会成功;如果可选值是 nil ，那么调用将返回 nil 。多个调用可以连接在一起形成一个调用 链，如果其中任何一个节点为 nil ，整个调用链都会失败，即返回 nil 。
 
 
 */

//**使用可选链式调用代替强制展开
/*
 通过在想调用的属性、方法、或下标的可选值后面放一个问号( ? )，可以定义一个可选链。这一点很像在可选 值后面放一个叹号( ! )来强制展开它的值。它们的主要区别在于当可选值为空时可选链式调用只会调用失 败，然而强制展开将会触发运行时错误。
 */

class Person {
    var residence:Residence?
}

class Residence {
    var numberOfRoom = 1
    var rooms = [Room]()
    var numberOfRooms:Int {
        return rooms.count
    }
    
    subscript(index:Int) -> Room {
        get {
            return rooms[index]
        }
        
        set {
            rooms[index] = newValue
        }
    }
    
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    
    var address:Address?
}

class Room {
    let name : String
    init(name:String){
        self.name = name
    }
}

class Address {
    var bulidingName:String?
    var bulidingNumber:String?
    var street:String?
    func bulidingLdentifier() -> String? {
        if bulidingName != nil {
            return bulidingName
        } else if bulidingNumber != nil && street != nil {
            return "\(bulidingNumber) \(street)"
        }else {
            return nil
        }
    }
}
/*
let john = Person()
let roomCount1 = john.residence?.numberOfRoom
//let roomCount2 = john.residence!.numberOfRoom
//如果使用叹号( ! )强制展开获得这个 john 的 residence 属性中的 numberOfRooms 值，会触发运行时错误，因为 这时 residence 没有可以展开的值

if let roomCount3 = john.residence?.numberOfRoom {
      print("John's residence has \(roomCount3) room(s).")
}else {
      print("Unable to retrieve the number of rooms.")
}
print(type(of:roomCount1))
//在 residence 后面添加问号之后，Swift 就会在 residence 不为 nil 的情况下访问 numberOfRooms 。

john.residence = Residence()


if let roomCount4 = john.residence?.numberOfRoom {
    print("John's residence has \(roomCount4) room(s).")
}else {
    print("Unable to retrieve the number of rooms.")
}

*/
//**为可选链式调用定义模型类
let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

func creatAddress() -> Address {
    print("Function was called.")
    let someAddress = Address()
    someAddress.bulidingNumber = "29"
    someAddress.street = "Acacia Road"
    return someAddress
}

//let someAddress = Address()
//someAddress.bulidingNumber = "29"
//someAddress.street = "Acacia Road"
//john.residence?.address = someAddress
john.residence?.address = creatAddress()
print(type(of:john.residence?.printNumberOfRooms()))

let re = Residence()
print(type(of:re.printNumberOfRooms()))


if john.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

//**通过可选链式调用访问下标
if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

john.residence?[0] = Room(name: "Bathroom")

let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name:"wyy"))
johnsHouse.rooms.append(Room(name:"kitten"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
print("Hello, World!")

//**访问可选类型的下标
var testScore = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScore["Dave"]?[0] = 91
testScore["Bev"]?[0] += 1
testScore["Brian"]?[0] = 72

//**连接多层可选链式调用

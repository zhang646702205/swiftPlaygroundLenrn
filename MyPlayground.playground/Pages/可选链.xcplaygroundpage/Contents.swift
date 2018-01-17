//: [可选链](@可选链)

import Foundation
import UIKit
//: 可选链调用是一种可以在当前可能为nil的可选值上请求和调用属性、方法及下标的方法。若可选值有值，那么调用会成功；若可选值是nil，那么调用返回nil。 多个调用可以连接在一起形成一个调用链，若其中任何一个几点为nil，整个调用链都会失败，则返回nil。
//: ```
//: 注意
//: swift的可选链调用和 Objective-C中向nil发送消息有些像，但swift 的可选链调用可以应用于任意类型，并能检查调用是否成功。

//: #### 使用可选链式调用代替强制展开
//: 通过在想调用的属性、方法、或下标的可选值后面放一个问号(?),可以定义一个可选链。这点向在可选值后面放一个叹号(!)强制展开它的值。 主要区别在于当可选值为空时可选链调用只会调用失败，而强制展开会触发运行时错误。
//: 为了反应可选链调用可以在空值 上调用的，不论这个调用的属性、方法及下标返回的值是不是可选值，其返回结果都是一个可选值。可以根据返回值来判断可选链调用是否成功，如果调用有返回值说明调用成功，返回nil 则说明调用失败。
//: 可选链式调用的返回结果与原本的返回结果具有相同的类型，但是被包装为一个可选值。如： 使用可选链访问属性，当可选调用成功时，若属性原本返回值是 Int 类型，则会变为 Int？ 类型。

// 下面代码解释可选链式调用和强制展开的不同

class Person {
    var  residence: Residence?
    
}
class Residence  {
    var numberOfRooms = 1
    
}
// 创建person 实例class
let john = Person()
// 若强制使用 叹号 展开residence 属性中numberOfRooms 值，触发运行报错，
//let roomCount = john.residence!.numberOfRooms // 引发运行时错误
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms")
}//Unable to retrieve the number of rooms
//: 因为访问numberOfRooms有可能失败，可选链式调用会返回Int?类型，或称为“可选的 Int”。如上所示，当residence为nil的时候，可选的Int将会为nil，表明无法访问numberOfRooms。访问成功时，可选的Int值会通过可选绑定展开，并赋值给非可选类型的roomCount常量。
//: ```
//: 注意
//: 即使numberOfRooms 是非可选的Int。只要使用可选链调用就意味着numberOfRooms 会返回一个 Int? 而不是 Int

// 赋值
john.residence = Residence()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms")
}//John's residence has 1 room(s)
//: ####  可选链式调用定义模型类
//: 使用可选链式调用可以调用多层属性、方法和下标。这样可以在复杂模型中向下访问各种子属性，并判断能否访问子属性的属性、下标或方法。
class Person1 {
    var  residence: Residence1?
    
}
class Residence1  {
    var rooms  = [Room]()
    var numberOfRooms:Int {
        return rooms.count
    }
    subscript(i: Int) -> Room{
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
    
}
class Room {
    let name : String
    init(name: String) {
        self.name = name
    }
}
class Address  {
    var buildingName : String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil  {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        }else {
            return nil
        }
    }
}
//: #### 通过可选链式调用访问属性
let john1 = Person1()
if let roomCount = john1.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms.")
}
//Unable to retrieve the number of rooms.

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john1.residence?.address = someAddress
// 这里 通过john1.residence 来设定 address 属性也会失败，因为 john1.residence 当前为nil 。

// 为了验证等号右边的代码是否被执行 添加下面函数
func createAddress()-> Address {
    print("Function was called.")
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    return someAddress
}
john1.residence?.address = createAddress() // 此处没有打印，说明 等号右侧代码 没有打印

//: #### 通过可选链式调用方法
//: 可通过可选链式 调用来调用方法，并判断是否调用成功，即使没有返回值。如：Residence 中的 printNumberOfRooms() 方法， 该方法没有返回值，没有返回值的方法具有隐式的返回值，Void
//: 若在可选值上通过可选链式调用来调用这个方法，方法的返回值会是 void？, 而不是 void。因为通过可选链式调用的得到的返回值都是可选的。因此，可以使用if 来判断能够成功调用printNumberOfRooms() 方法。
if john1.residence?.printNumberOfRooms() != nil  {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}//It was not possible to print the number of rooms.
//: 同样可以通过判断可选链式调用为属性赋值是否成功，如下：
if (john1.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address ")
}// It was not possible to set the address

//: #### 通过可选链式 调用下标
//: ```
//: 注意
//: 通过可选链式调用访问可选的下标，应该将问号放在下标的前面而不是后面。可选链式调用的问号一般直接跟在可选表达式的后面。

if let firstRoomName = john1.residence?[0].name {
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retreve the first room name")
}//Unable to retreve the first room name
//: 通过下标 赋值
john1.residence?[0] = Room(name:"Bathroom")// 赋值会失败，因为 residence 为nil

let johnsHouse = Residence1()
johnsHouse.rooms.append(Room(name:"Living Room"))
johnsHouse.rooms.append(Room(name:"Kitchen"))
john1.residence = johnsHouse

if let firstRoomName = john1.residence?[0].name {
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retreve the first room name")
}//The first room name is Living Room

//: #### 访问可选类型的下标
//: 如果下标返回可选类型，如 swift中Dictionary 类型的健的下标，可以在 下标的结尾括号后面放一个问号来在其可选返回值上进行可选链式调用。
var testScore = ["Dave" :[86,82,84],"Bev":[79,94,81]]
testScore["Dave"]?[0] = 91
testScore["Bev"]?[0] += 1
testScore["Brian"]?[0] = 72
print(testScore) // ["Bev": [80, 94, 81], "Dave": [91, 82, 84]]

//: #### 连接多层可选链式调用
//: 可以通过连接多个可选链式调用在更深的模型层级中访问属性、方法及下表。及：
//: > 如果你访问的值不是可选的，可选链式调用将会返回可选值。
//: > 如果你访问的值就是可选的，可选链式调用不会让可选返回值变得“更可选”。
//:  因此
//: > 通过可选链式调用访问一个Int值，将会返回Int?，无论使用了多少层可选链式调用。
//: > 类似的，通过可选链式调用访问Int?值，依旧会返回Int?值，并不会返回Int??。
if let johnsStreet = john1.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}//Unable to retrieve the address.

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john1.residence?.address = johnsAddress

if let johnsStreet = john1.residence?.address?.street {
    print("John's street name is \(johnsStreet)")
} else {
    print("Unable to retrieve the address")
}//John's street name is Laurel Street

//: #### 在方法的可选返回值上进行可选链式调用
//: 可以在一个可选值上通过可选链式调用来调用方法，并且可以根据需要继续在方法的可选返回值上进行可选链式调用。如：
if let buildingIdentifier = john1.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}//John's building identifier is The Larches.
if let beginsWithThe =
    john1.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}//John's building identifier begins with "The".
//: ```
//: 注意
//: 上述例子中，在方法的圆括号上加上问号是因为 要在buildingIdentifier() 方法的可选返回值上进行可选链调用，而不是方法本省。


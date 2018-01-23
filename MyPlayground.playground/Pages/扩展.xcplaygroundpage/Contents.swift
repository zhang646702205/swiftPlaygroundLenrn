//: [扩展](@扩展)

import Foundation
import UIKit
//: 扩展 即是 为一个已有的 类、结构体或者协议类型添加新功能。包括在没有权限获取原始代码的情况下扩展类型的能力（即 逆向建模）. 扩展和Objective-C 的分类类似。(与 Objective-C不同的是，swift的扩展没有名字)
//: Swift 中的扩展可以：
//: > 添加计算类型属性和计算型类型属性
//: > 定义实例方法和类型方法
//: > 提供新的构造器
//: > 定义下标
//: > 定义和使用新的嵌套类型
//: > 使一个已有类型符合某个协议
//: swift 中，甚至可以对协议进行扩展，提供协议要求的实现，或者添加额外的功能，而可以让符合协议类型的类型拥有功能。
//: ```
//: 注意
//: 扩展可以为一个类型添加新的功能，但是不能重写已有的功能。

//: #### 扩展语法
//: 使用关键字 extension 来声明扩展:

//: ```
//: extension SomeType{
//:    // 为 someType 添加的新功能
//: }

//: 通过扩展来扩展一个已有类型，使其采纳一个或多个协议。这样，无论是类还是结构体，协议名字的书写方式完全一样：

//: ```
//: extension SomeType : SomeProtocol, AnotherProtocol {
//:    // 协议实现
//: }

//: ```
//: 注意
//: 若通过扩展为一个已有类型添加新功能，那么新功能对该类型的所有实例都是可用的，即时是在这个扩展定义之前创建的。

//: #### 计算型属性
//: 扩展可以为已有类型添加计算型实例属性和计算型类型属性。如下例：
extension Double {
    var km : Double {return self * 1_000.0}
    var m: Double {return self}
    var cm : Double {return self/100.0}
    var mm:Double {return self / 1_000.0}
    var ft: Double  {return self / 3.28084}
}
let oneInch = 25.4.mm
print("one Inch is \(oneInch) meters")//one Inch is 0.0254 meters
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")//Three feet is 0.914399970739201 meters
//: 上述属性是只读属性，为了简洁，省略类 get 关键字。返回值都是 Double ，并且可以用于所有接受 Double 值的数学计算中。
let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long ")//A marathon is 42195.0 meters long
//:```
//: 注意
//: 扩展可以添加新的计算型属性，但不可以添加 存储型属性，也不可以为已有属性添加属性观察器。

//: #### 构造器
//: 扩展可以为已有类型添加新的构造器。可以扩展其他类型，将自己定制类型作为其构造器，或者提供该类的原始实现中未提供的额外初始化选项。扩展能为类添加新的便利构造器，但是不能为类添加新的指定构造器或析构器。 指定构造器和析构器必须总是由原始类实现来提供。

//: ```
//: 注意
//: 若使用扩展为一个值类型添加构造器，该值类型的原始实现中未定义任何定制的构造器且所有存储属性提供默认值。可以在扩展中的构造器里调用默认的构造器和足以成员构造器。

struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}
struct  Rect {
    var  origin = Point()
    var size = Size()
}
//: 结构体 Rect 未提供定制的构造器，因此它会获得一个逐一成员构造器。又因为它为所有存储型属性提供了默认值，
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x:2.0, y : 2.0),size: Size(width: 5.0, height :5.0))


extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height/2)
        
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let centerRect = Rect(center: Point(x:4.0, y: 4.0), size: Size(width:3.0, height: 3.0))
// centerRect 原点是 (2.5,2.5) 大小 (3.0,3.0)
//: ```
//: 注意
//: 如果使用扩展提供新的构造器，有责任确保构造过程能构让实例完全初始化。

//: #### 方法
//: 扩展可以为已有类添加新的实例方法和类型方法。如下例：
extension Int {
    func repetitions(task: ()-> Void) {
        for _ in 0..<self {
            task()
        }
    }
}
//: repetitions(task:) 方法接受一个 ()-> void 类型的单参数，表示没有参数且没有返回值的函数。

3.repetitions { 
    print("Hello!")
}
//Hello!
//Hello!
//Hello!

//: #### 可变实例方法
//: 通过扩展 添加实例方法也可以修改该实例本身。结构体和枚举类型中修改 self 或其属性的方法必须将该实例方法标注 为 mutating ，与原始实现的可变方法一样。
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt  = 3
someInt.square()
print(someInt)// someInt 现在是 9

//: #### 下标
//: 扩展可以为已有类型添加新下标。下例为 Int 添加了一个整型下标。该下标[n] 返回十进制数字从右向左的 第 N 个数字。如：
//: > 123456789[0] 返回 9
//: > 123456789[1] 返回 8 
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
print(746381295[0])//5
print(746381295[1])//9
//: 若该 Int 值没有足够的维数，即越界，那么上述下标会返回 0，与在数字左边自动补0:
print(746381295[9])//0 即等同于：0746381295[9]

//: #### 嵌套类型
//: 扩展可以为 已有的类、结构体和枚举添加新的嵌套类型。
extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}
//: 该例子为 Int 添加了嵌套枚举。kind 枚举表示特定的整数类型。可以如下面使用：
func printIntegerKinds(_ numbers: [Int]){
    for number in numbers {
        switch number.kind {
        case .Negative:
            print("- ", terminator: "")
        case .Zero:
            print("0 ", terminator: "")
        case .Positive:
            print("+ ", terminator: "")
            
        }
    }
    print("")
}
printIntegerKinds([3,19,-27,0,-6,0,7])//+ + - 0 - 0 +

//: ```
//: 注意
//: 由于已知 number.kind 是 Int.Kind 类型，因此在 switch 语句中，Int.Kind 中的所有成员值都可以使用简写形式，例如使用 . Negative 而不是 Int.Kind.Negative。

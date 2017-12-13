//: [枚举](@枚举)

import Foundation
import UIKit
//: 枚举为一组相关的值 定义了一个共同的类型，可以在代码中以类型安全的方式使用这些址。Swift 中的枚举更加灵活，不必给每一个枚举成员提供一个值。如果给枚举成员提供一个值（称为“原始”值），则该值的类型可以是字符串，字符，或是一个整型值或浮点数。
//: 在 Swift 中，枚举类型是一等（first-class）类型。采用了很多在传统上只被类（class）所支持的特性，例如计算属性（computed properties），用于提供枚举值的附加信息，实例方法（instance methods），用于提供和枚举值相关联的功能。枚举也可以定义构造函数（initializers）来提供一个初始值；可以在原始实现的基础上扩展它们的功能；还可以遵循协议（protocols）来提供标准的功能。

//: #### 枚举语法
enum SomeEnumeration {
    // 枚举定义放在这里
}
// 例子:可以使用case关键字来定义一个新的枚举成员值。
enum CompassPoint {
    case north
    case south
    case east
    case west
}
//: (@注意)
//: 与 C 和 Objective-C 不同，Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。在上面的CompassPoint例子中，north，south，east和west不会被隐式地赋值为0，1，2和3。相反，这些枚举成员本身就是完备的值，这些值的类型是已经明确定义好的CompassPoint类型。
//: 多个成员值可以出现在同一行上，用逗号隔开：
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}
var directionToHead = CompassPoint.west
// directionToHead被声明为CompassPoint类型，你可以使用更简短的点语法将其设置为另一个CompassPoint的值：
directionToHead = .east

//: #### 使用 switch 语句匹配枚举值
//: 判断一个枚举类型的值时，switch语句必须穷举所有情况.强制穷举确保了枚举成员不会被意外遗漏。
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rise")
case .west:
    print("Where the skies are blue")

}//Watch out for penguins
//: 不需要匹配每个枚举成员的时候，你可以提供一个default分支来涵盖所有未明确处理的枚举成员：
let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}// Mostly harmless
//: #### 关联值
//: 如存储条形码和二维码
enum Barcode{
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
var  productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
//: 可以使用一个 switch 语句来检查不同的条形码类型。然而，这一次，关联值可以被提取出来作为 switch 语句的一部分。可以在switch的 case 分支代码中提取每个关联值作为一个常量（用let前缀）或者作为一个变量（用var前缀）来使用
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC:\(numberSystem),\(manufacturer),\(product),\(check)")
case .qrCode(let productCode):
    print("QR code:\(productCode).")
}// QR code: ABCDEFGHIJKLMNOP.

//: 原始值
//: 上述条形码例子中，演示了如何声明存储不同类型关联值的枚举成员。作为关联值的替代选择，枚举成员可以被默认值（称为原始值）预填充，这些原始值的类型必须相同。每个原始值在枚举声明中必须是唯一的如：使用 ASCII 码作为原始值的枚举：
enum ASCIIControlCharacter: Character {// : 冒号后的可以看作是 原始值类型
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
//: - (@注意)
//: 原始值和关联值是不同的。原始值是在定义枚举时被预先填充的值，像上述三个 ASCII 码。对于一个特定的枚举成员，它的原始值始终不变。关联值是创建一个基于枚举成员的常量或变量时才设置的值，枚举成员的关联值可以变化。
//: #### 原始值的隐式赋值
//: 使用原始值为整数或者字符串类型的枚举时，不需要显式地为每一个枚举成员设置原始值，Swift 将会自动为你赋值。使用整数作为原始值时，隐式赋值的值依次递增1。如果第一个枚举成员没有设置原始值，其原始值将为0。如：
enum Planet1: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus , neptune
}//该例中，Plant.mercury的显式原始值为1，Planet.venus的隐式原始值为2，依次类推。
//: 使用字符串作为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称。
enum CompassPoint1: String {
    case north, south, ease ,west
}
// 使用枚举成员的 rawValue 属性可以访问该枚举成员的原始值
let earchsOrder = Planet1.earth.rawValue //3
let sunsetDirection = CompassPoint1.west.rawValue // "west"
//: #### 使用原始值初始化枚举实例
//: 如果在定义枚举类型的时候使用了原始值，那么将会自动获得一个初始化方法，这个方法接收一个叫做rawValue的参数，参数类型即为原始值类型，返回值则是枚举成员或nil。
let possiblePlanet = Planet1(rawValue: 7)// uranus
//: 然而，并非所有Int值都可以找到一个匹配的Planet1。因此，原始值构造器总是返回一个可选的枚举成员。在上面的例子中，possiblePlanet是Planet?类型，或者说“可选的Planet”。

//: 注意(@注意)
//: 原始值构造器是一个可失败构造器，因为并不是每一个原始值都有与之对应的枚举成员。
let positionToFine = 11
if let somePlanet = Planet1(rawValue: positionToFine) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
}else {
    print("There is not a planet at position \(positionToFine)")
}// There isn't a planet at position 11
//: #### 递归枚举
//: 递归枚举是一种枚举类型，它有一个或多个枚举成员使用该枚举类型的实例作为关联值。使用递归枚举时，编译器会插入一个间接层。枚举成员前加上indirect来表示该成员可递归。
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplucation(ArithmeticExpression, ArithmeticExpression)
}
//: 枚举类型开头加上indirect关键字来表明它的所有成员都是可递归的：
indirect enum ArithmeticExpression1 {
    case number(Int)
    case addition(ArithmeticExpression1, ArithmeticExpression1)
    case multiplucation(ArithmeticExpression1, ArithmeticExpression1)
}
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplucation(sum, ArithmeticExpression.number(2))
//: 要操作具有递归性质的数据结构，使用递归函数是一种直截了当的方式。
func evaluate(_ expression: ArithmeticExpression)-> Int {
    switch expression {
    case .number(let value):
        return value
    case .addition(let left,let right):
        return evaluate(left) + evaluate(right)
    case .multiplucation(let left ,let right):
        return evaluate(left) * evaluate(right)
    }
}
print(evaluate(product))// 18
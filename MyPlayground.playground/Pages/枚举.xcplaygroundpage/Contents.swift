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
enum Plant {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}
var directionToHead = CompassPoint.west
// directionToHead被声明为CompassPoint类型，你可以使用更简短的点语法将其设置为另一个CompassPoint的值：
directionToHead = .east

//: #### 使用 switch 语句匹配枚举值
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
		

//: [高级运算符](@高级运算符)

import Foundation
import UIKit
//: 除了之前所说的 基本运算符，swift 中还有可以对数值进行复杂运算的高级运算符。这些高级运算符包含了在 C 和 Objective-C 中的位运算符和移位运算符。
//: 与C语言的算术运算符不同的是，Swift 中的算术运算符是不会默认溢出的。所有溢出行为都会被捕获并且报错。若想让系统允许溢出行为，可选择 swift 中另外的允许溢出的运算符，如 溢出加运算符 &+。 所有这些溢出运算符都是 以 & 开头的。
//: 自定义结构体、类和枚举时，若为他们提供标准swift 运算符的实现，会很有用。swift 中自定义运算符 非常简单，运算符也针对不同类型使用对应实现。
//: swfit 中可以自由地定义中缀、前缀、后缀和赋值运算符，以及相应的优先级与结合性。

//: #### 位运算符
//: 位运算符可以操作数据结构中每个独立的比特位。通常被用在底层开发中，如图形编程和创建设备驱动。位运算符在处理外部资源的原始数据也很有用，如自定义 通信协议的传输的数据进行编码和解码。

//: #### 按位取反运算符
//: 按位取反运算符(~)可以对一个数值的全部比特位进行取反。是一个前缀运算符，需要放在运算的数之前，且之间不能添加任何空格。
let initialBits : UInt8 = 0b00001111
let invertedBits = ~initialBits // 0b11110000 相当于 十进制的 240

//: #### 按位与运算符
//: 按位与运算符(&) 可以对两个数的比特位进行合并。返回一个 新数，只有两个数的对应位都是 1 时，新数对应位才为1.
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8 = 0b00111111
let middleFourBits = firstSixBits & lastSixBits // 00111100 相当于 60

//: #### 按位或运算符
//: 按位或运算符(|)可以对两个数的比特位进行比较。返回一个新数，只要两个数对应的位中任意一个位1，新数的对应位就是1.
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b11111110
let combineBits = someBits | moreBits // 11111110
//: #### 按位异或运算符
//: 按位异或运算符(^)可以对两个数的比特位进行比较。返回一个新数，两个数的对应位不相同时，新数的对应位就是1
let firstBits : UInt8 = 0b00010100
let otherBits : UInt8 = 0b00000101
let outputBIts = firstSixBits ^ otherBits // 00010001

//: #### 按位左移、右移运算符
//: 按位左移运算符(<<) 和按位右移运算符(>>) 可以对一个数的所有位进行指定位数的左移和右移，但有如下规则：
//: 对一个数进行按位左移或按位右移，相当于对这个数乘以2 或除以 2的元素按。将一个整数左移一位，等价于将这个数乘以 2，同样地，将一个整数右移一位，等价于将这个数除以 2。
//: ## 无符号整数的移位运算
//: 无符号整数进行移位运算的规则：
//: > 已经存在的按指定的位数进行左移和右移
//: > 任何因移动而超出整形存储范围的位都被丢弃。
//: > 用 0 来填充移位后产生的空白位。

// 例子
let shiftBits: UInt8 = 4 // 及 00000100
shiftBits << 1 // 00001000  8
shiftBits << 2 // 00010000  16
shiftBits << 5 // 10000000  128

shiftBits >> 2 // 00000001  1

//: 可以使用移位运算对其他数据类型进行编码和解码
let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16 // redComponent 是 0xCC，即 204
let greenComponent = (pink & 0x00FF00)>>8  // greenComponent 是 0x66， 即 102
let blueComponent = (pink & 0x0000FF)      // blueComponent 是 0x99，即 153

//: ## 有符号整数的移位运算
//: 对比无符号整数，有符号的移位运算相对复杂，复杂性源于 有符号整数 的二进制表现形式(以下的示例都是基于 8 比特位的有符号整数的，但是其中的原理对任何位数的有符号整数都是通用的)。
//: 有符号整数使用第 1 个比特位（通常被称为符号位）来表示这个数的正负。符号位为 0 代表正数，为 1 代表负数。其余的比特位（通常被称为数值位）存储了实际的值。
//: ## 溢出运算符
//: 默认情况，当向一个整数赋予超过它容量的值时，swift 会报错，而不是生成一个无效的数。该行为为我们运算过大或过小的数的时候提供额外的安全性。
//: 例子： Int16 整数能容纳有符号整数范围是 -32768 ~ 32767, 当超过这个范围时会报错
var potentialOverflow = Int16.max // 最大 整数
//potentialOverflow += 1 // 报错 溢出

//: 为过大或过小的数值提供错误处理，可以方便我们在处理边界值时更加灵活。
//: 也可以让系统在数值溢出时采取截断处理，而非报错。swift 提供了 三个 溢出运算符来让系统支持整数溢出运算。这些运算符都是以 & 开头：
//: > 溢出加法 &+
//: > 溢出减法 &-
//: > 溢出乘法 &*

//: ## 数值溢出
//: 数值可能出现 上溢或者 下溢。 如下例所示无符号的操作：
var  unsingedOverflow = UInt8.max //
unsingedOverflow = unsingedOverflow &+ 1 // 此时 unsingedOverflow 为0

unsingedOverflow = UInt8.min
unsingedOverflow = unsingedOverflow &- 1 // 255
//: 溢出也会发生在有符号整型数值上。在对有符号整型数值进行溢出加法或溢出减法运算时，符号位也需要参与计算，对于无符号与有符号整型数值来说，当出现上溢时，它们会从数值所能容纳的最大数变成最小的数。同样地，当发生下溢时，它们会从所能容纳的最小数变成最大的数。
var signedOverflow = Int8.min // 此时 是最小值 -128
signedOverflow = signedOverflow &- 1 // 现在是 127

//: ## 优先级和结合性
//: 运算符的优先级使得 一些运算符优先于其他运算符，高优先级的运算符会先被计算。
//: 结合性 定义了 相同优先级的运算符是如何结合的，即与左边结合为一组还是与右边结合为一组。
//: 复合表达式运算顺序中，运算符的优先级和结合性是很重要的。与 C 语言类似，swift 中，乘法运算符(*) 与 取余运算符(%)的优先级高于加法运算符。

//: ```
//: 注意
//: 相对于 C 语言和 Objective-C 来说，swift的运算符优先级和结合性规则更加简洁和可预测。也就是说它相较于 C 语言及其衍生语言并不是完全一致的。

//: #### 运算符函数
//: 类和结构体可以为现有的运算符提供自定义的实现，成为 运算符重载。
//: 下例中 展示了如何为自定义的结构体实现加法运算符(+).加法运算符是一个双目运算符，因为它可以对两个值进行运算，同时还是中缀运算符，因为它在两个值中间。
struct Vector2D{
    var  x = 0.0, y  = 0.0
}

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D{
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}
//: 该运算符函数被定义为 Vector2D 上的一个类方法，并且函数的名字与它要进行重载的 + 名字一致。因为加法运算并不是一个向量必需的功能，所以这个类方法被定义在 Vector2D 的一个扩展中，而不是 Vector2D 结构体声明内。

let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combineVector = vector + anotherVector
print(combineVector)//Vector2D(x: 5.0, y: 5.0)

//: #### 前缀和后缀运算符
//: 上例说明一个 双目运算符的自定义实现。类与结构体也能提供标准单目运算符的实现。单目运算符出现在值前时，他就是前缀(!b)，出现在值后时，他就是后缀(b!).
//: 要实现前缀或者后缀运算符，需要在声明运算符的时候在func 关键字前制定 prefix 或者 postfix 修饰符

extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}
//: 该代码 实现了单目负号运算符，因为是前缀运算符，所以该函数要加上 prefix 修饰符。

let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
print(negative)//Vector2D(x: -3.0, y: -4.0)
let alsoPositive = -negative
print(alsoPositive)//Vector2D(x: 3.0, y: 4.0)

//: #### 复合赋值运算符
//: 复合赋值运算符将赋值运算符(=)与其他运算符结合。如：将加法与赋值结合成加法赋值运算符(+=).在实现的时候，需要把运算符的左参数设置为 inout 类型。因为这个参数的值会在运算符函数内直接被修改掉。
extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}
var  original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 2.0, y: 4.0)
original += vectorToAdd
print( original) //Vector2D(x: 3.0, y: 6.0)

//: ```
//: 注意
//: 不能对默认的赋值运算符(=)进行重载。只有组合赋值运算符可以被重载，同样，也无法对 三目条件运算符(a?b:c)进行重载。

//: #### 等价运算符
//: 自定义的类和结构体没有对 等价运算符进行默认实现，等价运算符通常被称为"相等"运算符(==)与"不等"运算符(!=).对于自定义类型，swift 无法判断是否"相等"，因为“相等”的含义取决于自定义类型在代码中所扮演的角色。下例实现等价运算符：
extension Vector2D {
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
    static func != (left: Vector2D, right: Vector2D)-> Bool {
        return !(left == right)
    }
}
//: 代码实现了“相等”运算符（==）来判断两个 Vector2D 实例是否相等。对于 Vector2D 类型来说，“相等”意味着“两个实例的 x 属性和 y 属性都相等”，这也是代码中用来进行判等的逻辑。

let twoThree = Vector2D(x: 2.0, y: 3.0 )
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
    print("These two vectors are equivalent")
}//These two vectors are equivalent
//: #### 自定义运算符
//: 除了标准运算符，在swift 中还可以声明和实现自定义运算符。新的运算符要使用 operator 关键字在全局作用域内进行定义，同时还要指定 prefix、infix、或者postfix 修饰符。
prefix operator +++
//: 上面定义了一个 +++ 的前缀运算符。对于这个运算符，在 Swift 中并没有意义，因此我们针对 Vector2D 的实例来定义它的意义。对这个示例来讲，+++ 被实现为“前缀双自增”运算符。它使用了前面定义的复合加法运算符来让矩阵对自身进行相加，从而让 Vector2D 实例的 x 属性和 y 属性的值翻倍。实现 +++ 运算符的方式如下：
extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}

var toBeDouble = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDouble
print(afterDoubling)//Vector2D(x: 2.0, y: 8.0)

//: #### 自定义中缀运算符的优先级
//: 自定义中缀运算符都属于某个优先级组。该优先级组指定了这个运算符和其他中缀运算符的优先级和优先性。
//: 没有明确放入优先级组的自定义中缀运算符会放到一个默认的优先级组内，其优先级高于三元运算符。

infix operator +-: AdditionPrecedence
extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D)-> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}
let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector
print(plusMinusVector)//Vector2D(x: 4.0, y: -2.0)
//: 上述运算符把两个向量的 x 值相加，同时用第一个向量的 y 值减去第二个向量的 y 值。因为它本质上是属于“相加型”运算符，所以将它放置 + 和 - 等默认的中缀“相加型”运算符相同的优先级组中。关于 Swift 标准库提供的运算符，以及完整的运算符优先级组和结合性设置

//: ```
//: 注意
//: 当定义前缀与后缀运算符的时候，并没有指定优先级。但是，若对同一个值同时使用前缀和后缀运算符，则后缀运算符会优先参与运算。


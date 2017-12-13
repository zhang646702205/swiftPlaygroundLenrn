//: [类和结构体](@类和结构体)
//: 类和结构体是人们构建代码所用的一种通用且灵活的构造体。我们可以使用完全相同的语法规则来为类和结构体定义属性（常量、变量）和添加方法，从而扩展类和结构体的功能。
import Foundation
import UIKit
//: #### 类和结构体对比
//: 类和结构体的共同点：
//:     > 定义属性用于存储值
//:     > 定义方法用于提供功能
//:     > 定义下标操作使的可以通过下标语法来访问实例所包含的值
//:     > 定义构造器用于生成初始化值
//:     > 通过扩展以增加默认实现的功能
//:     > 实现协议以提供增加默认实现的效果
//:     > 实现协议以提供某种标准功能

//: 与结构体比较，类还有如下附加功能: 即不同点：
//:     > 继承允许一个类继承另一个类的特征
//:     > 类型转换允许在运行时检查和解释一个类实例的类型
//:     > 析构器允许一个类实例释放任何其所被分配的资源
//:     > 引用计数允许对一个类的多次引用

//: 注意(@注意)
//: 结构体总是通过被复制的方式在代码中传递，不使用引用计数。

//: #### 定义语法
//: 类和结构体有着类似的定义方式。通过关键字 class 和 struct 来表示类和结构体，并在一对大括号中定义他们的具体内容：
class SomeClass {
    // 这里定义类
}
struct SomeStructure {
    // 这里定义结构体
}

//: 注意(@注意)
//: 在你每次定义一个新类或者结构体的时候，实际上你是定义了一个新的 Swift 类型。因此请使用UpperCamelCase这种方式来命名（如SomeClass和SomeStructure等），以便符合标准 Swift 类型的大写命名风格（如String，Int和Bool）。相反的，请使用lowerCamelCase这种方式为属性和方法命名（如framerate和incrementCount），以便和类型名区分。
// 类和结构体的示例
struct Resolution {
    var  width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
//: #### 类和结构体实例
//: Resolution结构体和VideoMode类的定义仅描述了什么是Resolution和VideoMode。它们并没有描述一个特定的分辨率（resolution）或者视频模式（video mode）。为了描述一个特定的分辨率或者视频模式，我们需要生成一个它们的实例。
let someResolution = Resolution()
let someVideoMode = VideoMode()
//: 结构体和类都使用构造器语法来生成新的实例。构造器语法的最简单形式是在结构体或者类的类型名称后跟随一对空括号，如Resolution()或VideoMode()。
//: #### 属性访问
//: 通过使用点语法，你可以访问实例的属性。其语法规则是，实例名后面紧跟属性名，两者通过点号(.)连接：
print("The width of someResolution is \(someResolution.width)")//The width of someResolution is 0
//: 也可以使用点语法变量 为变量属性数值
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")//The width of someVideoMode is now 1280
//: [注意](@注意)
//: 与 Objective-C 语言不同的是，Swift 允许直接设置结构体属性的子属性。上面的最后一个例子，就是直接设置了someVideoMode中resolution属性的width这个子属性，以上操作并不需要重新为整个resolution属性设置新值。
//: #### 结构体类型的成员注意构造器
//: 结构体都有一个自动生成的成员逐一构造器，用于初始化新结构体实例中成员的属性。与结构体不同，类实例没有默认的成员逐一构造器
let vga = Resolution(width: 640, height: 480)
//: #### 结构体和枚举是值类型
//: 值类型被赋予给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝。
//: 在 Swift 中，所有的基本类型：整数（Integer）、浮点数（floating-point）、布尔值（Boolean）、字符串（string)、数组（array）和字典（dictionary），都是值类型，并且在底层都是以结构体的形式所实现。
//: 值类型 意味着它们的实例以及实例中所包含的任何类型属性，在代码中传递的时候都会被复制。
let hd = Resolution(width: 1920, height: 1080)
var  cinema = hd
cinema.width = 2048
 print("cinema is now \(cinema.width) pixels wide")//cinema is now 2048 pixels wide
print( "hd is still \(hd.width) pixels wide")//hd is still 1920 pixels wide
//: 枚举 例子
enum CompassPoint {
    case North, South, East, West
}
var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    print("The remembered direction is still .West")
}//The remembered direction is still .West
//: 类是引用类型
//: 与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝。因此，引用的是已存在的实例本身而不是其拷贝。
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")//The frameRate property of tenEighty is now 30.0
//: [注意](@注意)需要注意的是tenEighty和alsoTenEighty被声明为常量而不是变量。然而你依然可以改变tenEighty.frameRate和alsoTenEighty.frameRate，因为tenEighty和alsoTenEighty这两个常量的值并未改变。它们并不“存储”这个VideoMode实例，而仅仅是对VideoMode实例的引用。所以，改变的是被引用的VideoMode的frameRate属性，而不是引用VideoMode的常量的值。
//: #### 恒等运算符
//: 类是引用类型，有可能有多个常量和变量在幕后同时引用同一个类实例。（对于结构体和枚举来说，这并不成立。因为它们作为值类型，在被赋予到常量、变量或者传递到函数时，其值总是会被拷贝。）
//:     > 等价与(===)
//:     > 不等价于 (!==)
//: 这两个运算符检测两个常量或者变量是否引用同一个实例：
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same Resolution instance")
}//tenEighty and alsoTenEighty refer to the same Resolution instance

//: [注意](@注意)
//: '等价于'('===') 与 '等于'('==') 的不同是：
//:     1. 等价于 表示两个类类型（calss type）的常量或者变量引用同一个类实例
//:     2. 等于 表示两个实例的值‘相等’或'相同'，判定是要遵照设计者定义的评判标准，因此相对于‘相等’来说，这是一种更加合适的叫法。
//: 当你在定义你的自定义类和结构体的时候，你有义务来决定判定两个实例“相等”的标准。

//: #### 指针
//: 一个引用某个引用类型实例的 Swift 常量或者变量，与 C 语言中的指针类似，但是并不直接指向某个内存地址，也不要求你使用星号（*）来表明你在创建一个引用。Swift 中的这些引用与其它的常量或变量的定义方式相同。

//: #### 类和结构体的选择
//: 按照通用的准则，当符合一条或多条以下条件时，请考虑构建结构体：
//: > 该数据结构的主要目的是用来封装少量相关简单数据值。
//: > 有理由预计该数据结构的实例在被赋值或传递时，封装的数据将会被拷贝而不是被引用。
//: > 该数据结构中存储的值类型属性，也应该被拷贝，而不是被引用。
//: > 该数据结构不需要去继承另一个即有类型的属性或者行为。
//: 例如：
//: > 几何形状的大小，封装一个width属性和height属性，两者均为Double类型。
//: > 一定范围内的路径，封装一个start属性和length属性，两者均为Int类型。
//: > 三维坐标系内的一点，封装x, y, z 属性，三者均为 Double。

//: #### 字符串、数组、和字典类型的赋值与复制行为
//: Swift 中，许多基本类型，诸如String，Array和Dictionary类型均以结构体的形式实现。这意味着被赋值给新的常量或变量，或者被传入函数或方法中时，它们的值会被拷贝。

//: 注意(@注意)
//: 以上是对字符串、数组、字典的“拷贝”行为的描述。在你的代码中，拷贝行为看起来似乎总会发生。然而，Swift 在幕后只在绝对必要时才执行实际的拷贝。Swift 管理所有的值拷贝以确保性能最优化，所以你没必要去回避赋值来保证性能最优化。

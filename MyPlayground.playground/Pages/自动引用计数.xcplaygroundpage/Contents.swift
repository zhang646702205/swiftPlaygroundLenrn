//: [自动引用计数](@自动引用计数)

import Foundation
import UIKit
//: swift 使用自动引用计数(ARC)机制来跟踪和管理应用的内存。ARC 会在类的实例不再被使用时，自动释放其占用的内存。
//: 少数情况下，为了帮你管理内存，ARC需要更多代码之间关系的信息。swift 使用ARC 与在Objective-C中使用ARC类似。
//: ```
//: 注意
//: 引用计数仅仅用于类的实例。结构体和枚举类型是值类型，不是引用类型，也不通过引用的方式存储和传递。

//: #### 自动引用计数的工作机制
//: 每次创建类的实例的时候，ARC会分配一块内存来存储该实例的信息。内存中包含实例的类型信息，以及这个实例所有相关的存储型属性的值。
//: 当实例不再被使用时，ARC释放实例所占用内存，并让释放的内存能作他用。确保了不再被使用的实例，不会一直占用内存空间。
//: 当ARC收回和释放了正在被使用的实例，该实例的属性和方法将不能在被访问和调用。若试图访问这个实例，应用程序很可能崩溃。
//: 为了确保使用中的实例不会被销毁，ARC会跟踪和计算每个实例正在被多少属性，常量和变量所引用。就算实例的引用数为1，ARC都不会销毁这个实例。
//: 为了实现上述可能，无论将实例赋值给属性、变量或常量，都会创建次实例的强引用。之所以为"强"引用，是因为会牢牢的保持住，只要强引用还在，实例不允许被销毁。

//: #### 自动引用计数实践
//: 工作机制：
class Person {
    let name : String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1:Person?
var reference2:Person?
var reference3:Person?
reference1 = Person(name: "John Appleseed")
//John Appleseed is being initialized
reference2 = reference1
reference3 = reference1
//: 此时有三个 强引用
reference1 = nil
reference2 = nil

reference3 = nil
//John Appleseed is being deinitialized

//: #### 类实例之间的循环引用
//: 显示中可能会写出一个类实例的强引用数永远不能变成 0 的代码。 如果两个类实例 互相持有对方的强引用，因而每个实例都让对方一直存在，这种情况就是所谓的 循环强引用。
//: 可以通过 定义类之间的关系为 弱引用或无主引用，以代替强引用，从而解决 循环强引用的问题。下例说明 其产生的原理：
class Person1 {
    let name:String
    init(name: String) {
        self.name = name
    }
    var  department : Apartment?
    deinit {
        print("\(name) is being deinitialized")
    }
}
class Apartment {
    let unit : String
    init(unit: String) {
        self.unit = unit
    }
    var tenant:Person1?
    deinit {
        print("Apartment \(unit) is being beinitialized")
    }
}

//: 代码示例
var john :Person1?
var unit4A:Apartment?

john = Person1(name: "John Appleseed")
unit4A = Apartment(unit: "4A")
//: 此时 分别有强引用
john?.department = unit4A
unit4A?.tenant = john
//: 此时两个实例关联后 回产生一个 循环强引用。参考图 见官网？
john = nil
unit4A = nil
//: ```
//: 注意
//: 当把这两个变量设为nil 时，没有任何一个析构函数被调用。循环强引用会一直阻止 阻止person 和apartment 实例的销毁，这就造成了内存泄漏。

//: #### 解决实例之间的循环强引用
//: Swift 提供了两种办法来解决使用类的属性时所遇到的循环强引用问题。 弱引用(weak reference) 和无主引用(unowned reference).
//: 弱引用和无主引用允许循环引用中的一个实例引用另外一个实例 不保持强引用。这样实例能够互相引用而不产生循环强引用。
//: 当其他的实例有更短的生命周期时，使用弱引用；相反，当其他实例有相同或者更长的生命周期时，请使用无主引用。
//: #### 弱引用
//:  弱引用不会对其引用的实例保持强引用，因而不会阻止ARC销毁被引用的实例。这个特性阻止了 引用变为循环强引用。生命属性或者变量时，在前面加上weak 关键字表明这是个弱引用。
//: 由于弱引用不会保持所引用的实例，即使引用存在，实例也有可能被销毁。ARC会在引用的实例被销毁后自动将其赋值为 nil。并且因为弱引用 可以允许它们的值在运行时被赋值为nil，所以它们会被定义为可选变量类型，而不是常量。
//: ```
//: 注意
//: 当ARC设置为nil 时，属性观察不会被触发。

//: 如下例的：
class Person2 {
    let name:String
    init(name: String) {
        self.name = name
    }
    var  department : Apartment1?
    deinit {
        print("---\(name) is being deinitialized")
    }
}
class Apartment1 {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    weak var tenant: Person2?
    deinit {
        print("---Apartment \(unit) is being deinitialized")
    }
}

var john1: Person2?
var unit4A2: Apartment1?

john1 = Person2(name: "John Appleseed")
unit4A2 = Apartment1(unit: "4A")

john1?.department = unit4A2
unit4A2?.tenant = john1

john1 = nil //---John Appleseed is being deinitialized
unit4A2 = nil //---Apartment 4A is being deinitialized
//: 上述两个变量被赋值为nil 后，实例的析构函数都打印了“销毁”的信息。证明引用循环被打破了。
//: ```
//: 注意
//: 在使用垃圾收集的系统里，弱引用有时用来实现简单的缓冲机制，因为没有强引用的对象只会在内存压力触发垃圾收集时才会被销毁。但在arc中，一旦值的最后一个强引用被移除，就会被立即销毁，这导致弱引用并不适合上面的用途。

//: #### 无主引用
//: 和弱引用类似，无主引用不会牢牢保持主引用的实例。和弱引用不同的是，无主引用在其他实例有相同或者更长的生命周期时使。 可以在生命属性或变量时，在前面加上关键字 unowned 表示一个无主引用。
//: 无主引用通尝被期望有值。不过 ARC 无法实现在被销毁后将无主引用设为nil，因为非可选类型的变量不允许被赋值为nil。
//: ```
//: 注意
//: 使用无主引用，必须 确保引用始终指向一个未销毁的实例。如果试图在实例被销毁后，访问该实例的无主引用，会触发运行错误。
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}
//: ```
//: 注意
//: CreditCard 类的number 属性被定义为UInt64 类型而不是Int 类型，以确保number属性的存储量在32位和64位系统上都能足够容纳16位的卡号。

var john2: Customer?

john2 = Customer(name: "John Appleseed")
john2!.card = CreditCard(number: 1234_5678_9012_3456, customer : john2!)
john2 = nil

//Card #1234567890123456 is being deinitialized
// John Appleseed is being deinitialized
//: ```
//: 注意
//: 上面展示了如何使用安全的无主引用。对于需要禁用运行时的安全检查情况（如：由于性能方面的原因），swift 还提供了不安全的无主引用。与所有不安全操作一样，需要检查代码以确保其安全行。可以通过 unowned(unsafe) 来声明不安全的无主引用。如果试图在实例销毁后，访问该实例的不安全无主引用，你的程序会尝试访问该实例之前所在的内存，这是一个不安全操作。

//: #### 无主引用以及隐士解析可选属性
//: 上面弱引用和无主引用的例子涵盖了两种常用的需要打破循环引用的场景。
//: 如果两个属性的值都可以为nil，并会潜在的产生循环强引用。这种场景适合用弱引用来解决。
//: 如果一个属性的值允许为nil，而另一个属性的值不允许为nil，这也可能产生循环强引用，这种场景适合无主引用来解决。
//: 最后一个场景，两个属性都必须有值，并且初始化后永远不会为nil。这样，需要一个类使用无主引用，另外一个类使用隐士解析可选类型。
class Country {
    let name:String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}
class City {
    let name :String
    unowned let country : Country
    init(name: String, country:Country) {
        self.name = name
        self.country = country
    }
}

//: #### 闭包引起的循环强引用
//: 循环强引用除了会发生在上述两个类实例属性相互保持对对方的强引用而产生，使用弱引用和无主引用来打破循环强引用。
//: 循环强引用还会发生在将一个闭包赋值给类实例的某个属性，并且这个闭包体中使用了这个类实例是。这个闭包体中可能访问了实例的某个属性。如 self.someProperty  ,或者闭包中调用了实例的某个方法，如 self.someMethod().这两种情况都导致闭包 捕获 self,而产生循环强引用。
//: 循环强引用的产生，是因为闭包和类相似，都是引用类型。讲一个闭包赋值给某个属性时，是将闭包的引用赋值给属性。跟之前一样的是 两个强引用让批次一直有效，但和两个类实例不同，这次是一个实例，一个是闭包。
//: swift 提供一种优雅的方法来解决这个问题， 称为 闭包捕获列表(closure capture list).先看一下此种循环强引用是如何产生的
class HTMLElement {
    let name:String
    let text:String?
    
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    init(name:String , text: String) {
        self.name = name
        self.text = text
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading = HTMLElement(name: "h1", text: "hello，world")
//let defaultText = "some default text"
//heading.asHTML = {
////    return "<\(heading.name)>\(heading.text ?? defaultText) </\(heading.text)>"
//}
print(heading.asHTML()) // <h1>hello，world</h1>
//: ```
//: 注意
//: asHTML 声明为lazy 属性，只有当元素确实需要被处理为 HTML 输出的字符串时，才需要使用 HTML。也就是说，在默认的闭包中可以使用self，只有当初始化完成以及self 确实存在后，才能访问 lazy属性。

var parahraph : HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(parahraph!.asHTML())//<p>hello, world</p>

//: ```
//: 注意
//: paragraph 定义为可选类型，可以赋值nil 来演示循环强引用

//: 实例中 asHTML 属性持有闭包的强引用，闭包在其闭包体内使用了 self(self.name 和 self.text),因此闭包捕获了 self，意味着闭包反过来持有 HTMLElement 实例的强引用，这样就产生了循环强引用。

//: ```
//: 注意
//: 虽然闭包多次使用了 self， 只捕获了HTMLElement实例的一个强引用。
parahraph = nil
//: 此时 析构函数中的消息并没有被打破，说明 HTMLElment 实例并没有被销毁。
//: #### 解决闭包引起的循环强引用
//: 定义闭包时同时定义捕获列表作为闭包的一部分，这种方式可以作为解决闭包和实例之间的循环强引用。捕获列表定义了闭包体内捕获一个或者多个引用类型的规则。与解决两个类实例间的循环强引用一样，声明每个捕获的引用为弱引用或无主引用，而不是强引用。
//: ```
//: 注意
//: swift 中有如下要求，只要在闭包内使用 self 的成员，就要用 self.someProperty 或者self.someMethod()(而不是 someProperty 或 someMethod()).提醒你可能会不小心捕获了self。

//: #### 定义捕获列表
//: 捕获列表中的每一项都由一对元素组成，一个是 weak 或 unowned 关键字，另一个是类实例的引用(如self)或初始化过的变量(如 delegate = self.delegate!).在方括号中用逗号分开。如下：
//: ```
//: lazy var someClosure: (Int, String) -> String = {
//:     [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
//:     // 闭包函数体
//: }

//: 如果闭包没有指明参数列表或喝者返回类型，会根据上下文推断，可以把捕获列表和关键字 in 放在闭包最开是地方：
//: ```
//: lazy var someClosure: () -> String = {
//:     [unowned self, weak delegate = self.delegate!] Int
//:     // 函数体
//: }

//: #### 弱引用和无主引用
//: 闭包和捕获的实例总是相互引用并且总是同时销毁，将闭包内的捕获定义 为 无主引用。

//: 在捕获的引用可能会变为nil，将闭包内的捕获定义为 弱引用。弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为nil。
//: 无主引用是正确的解决循环强引用的方法
class HTMLElement1 {
    let name:String
    let text:String?
    
    lazy var asHTML: () -> String = { // 捕获列表 将self 捕获为 无主引用而不是强引用
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    init(name:String , text: String? = nil ) {
        self.name = name
        self.text = text
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var paragraph1: HTMLElement1? = HTMLElement1(name: "p", text: "hello, world")
print(paragraph1?.asHTML())// Optional("<p>hello, world</p>")
//: 此处 无主引用的形式捕获self。 并不会持有HTMLElement1 实例的强引用。如果将paragraph1 置为nil，实例将被销毁，可以看到 析构函数 打印。
paragraph1 = nil //p is being deinitialized


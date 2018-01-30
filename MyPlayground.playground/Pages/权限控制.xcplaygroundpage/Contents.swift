//: [权限控制](@权限控制)

import Foundation
import UIKit
//: 权限控制 限制部分文件或模版代码中的部分权限。这个特性允许你隐藏代码的实现细节，并且控制代码应该如何访问和被使用。
//: 可以添加具体的访问级别在自定义的类型上(类、结构体和枚举)，也可以为这些类型的 属性、方法，构造器和下标添加访问控制。协议可以限制为确定的上下文，像全局常量、变量和方法。
//: 除了显示指定访问控制之外，swift 提供默认的访问控制级别来减少来减少指定访问级别的需要。实际上，如果你是单视图的app，不需要指定显示的访问级别控制。
//:```
//: 注意
//: 代码的各个方面可以对它们进行访问控制（属性、类型、函数等）在下文中称为“实体”，以表示简洁。

//: #### 插件和源文件
//: swift 的权限控制是基于 插件和源文件的概念。
//: 模块 是一个单独的分发单元 - 如一个 frameword 或者 一个 application 被编译和打包成的单独的单元。可以被其他模块通过 import 关键字引入。
//: 在Xcode中，每个生成目标（如一个应用程序或框架）被视为一个单独的模块。如果将应用程序代码的各个部分组合成一个独立的框架，也许可以在多个应用程序中封装和重用这些代码，那么在该框架中定义的所有内容都将是单独模块的一部分，当它被导入并在应用程序中使用时，或者当它在另一个框架中使用时。
//: 源文件是一个单独的swift 文件在一个模块中（实际上是一个app或模块的代码）。单个文件定义单个类型很常见，一个源文件可以定义多个类型、函数等。
//: #### 权限级别
//: Swift 为实体提供5 种不同的权限级别。这些访问级别与定义一个实体的源文件相关联，并且与源文件属于的模块相关。
//: > open 和 public 权限允许实体可以在任何的源文件中使用，也可以在倒入模块的任意文件中使用。在指定框架的公共接口时，使用 open 或public。两者的不同将在下面描述。
//: > internal 权限允许实体被模块中的任意文件访问，但是不允许模块之外的文件访问。当在定义 一个 app 或 框架的内部架构时使用 internal 权限。
//: > File-private 访问限制了实体对其自己定义源文件的使用。当文件在整个文件中使用时，使用文件私有访问隐藏特定功能的实现细节。
//: > private 限制了实体对封闭声明的使用，以及对同一文件中声明的扩展。当这些细节仅在一个声明中使用时，使用私有访问隐藏特定功能的实现细节。

//: open 权限有最高(限制最小)的级别，private 又有最低(限制性最大)的级别。
//: open 权限 仅对class 和 class members， 与 public 的不同如下：
//: > 公共(public)访问类(class)，或任何限制性的访问级别，只能在他们定义的模块内子类化 。
//: > 具有公共(public)访问权限的类成员(class members)，或任何更严格的访问级别，只能在定义它们的模块内由子类重写。
//: > 开放(open)类可以在定义他们的模块内，或者在任何引入他们的模块，子类化。
//: > 开放(open)类成员 可以被在他们定义的模块内，或者任意引入他们的模块内的子类重写。
//: 标记一个类开放明确表明你考虑从其他模块使用的类作为一个父类代码的影响，那你设计你的类的相应代码。

//: #### 权限控制设计原则
//: 权限控制有个通用的准则：No entity can be defined in terms of another entity that has a lower (more restrictive) access level.(任何实体都不能从新定义一个具有更低（更严格的）访问级别的另一个实体。)
//: > A public variable can’t be defined as having an internal, file-private, or private type, because the type might not be available everywhere that the public variable is used.
//: > A function can’t have a higher access level than its parameter types and return type, because the function could be used in situations where its constituent types are unavailable to the surrounding code.

//: #### 默认访问权限
//: 如果没有指定显式访问级别，则代码中的所有实体（如本章后面所述的一些特定异常）具有默认的内部(internal )访问级别。因此，在许多情况下，您不需要在代码中指定显式访问级别。

//: #### 单应用的权限控制
//: 在写单工程的应用时，代码多是工程中用的，不需要在模块外访问。默认的（internal）也可以满足这个需求。因此，不需要具体声明权限控制。

//: #### 框架的权限控制
//: 在开发框架时，将接口标记为public 或 open，以便与其他框架使用或查看，就像引入引入框架一样。这个面向公众的接口是框架的应用程序编程接口（或API）。
//: ```
//: 框架的任何内部实现细节仍然可以使用内部的默认访问级别(internal)，或者如果您想将其隐藏在框架内部代码的其他部分中，则可以将其标记为私有或文件私有。只有当您希望它成为框架API的一部分时，才需要将实体标记为公开的或公开的。

//: #### 单元测试访问权限
//: 当使用一个单元测试目标编写应用程序时，应用程序中的代码需要被提供给该模块以便测试。默认情况下，只有标记为公开或公开的实体才能访问其他模块。但是，如果您将产品模块的导入声明标记为@testable 属性，并通过测试启用该产品模块，则单元测试目标可以访问任何内部实体。

//: #### 权限控制语句
//: 通过对一个实体前添加open，public，internal，fileprivate，或者private来添加权限控制
public class SomePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivateCalss {}

public var somePublicVariabl = 0
internal let someInternalConstant = 0
//fileprivate func someFilePrivateFunction(){} // 这里加上会报错？
private func someFilePrivateFunction(){}

//: 默认的权限控制是 internal，除非添加其他权限符。这就是说 像someInternalClass 和 someInternalConstant 可以添加权限控制，依然有默认的权限控制 (internal).

class SomeInternalClass2{}
let someInternalConstant2 = 0

//: #### 自定义类型
//: 如果想为自定义类型添加权限控制，在定义类型时添加。新类型可以用在任何他权限允许的地方。如：如果定义一个 file-private 类，这个类只能在其定义的地方 被用作 property，function paramter，或者 返回值类型。
//: 权限的级别也会影响其类型成员的默认权限（如：properties，methods，initializers，subscripts）。如 :如果定义一个private 或 file-private 类型，其成员的默认权限也会是 private 或 file-private。如果定义一个 internal （或默认权限），他的成员默认的权限是 internal。

//: ```
//: 重要
//: 公共类型默认为内部成员，而不是公共成员。如果希望类型成员公开，则必须显式地将其标记。这要求确保公开面向类型的API是要发布的内容，并避免错误地将类型的内部工作公开为公共API。

public class SomePublicClass1 { //explicitly public class
    public var somePublicPropert = 0 //explicitly public class member
    var someInternalProperty = 0 //implicitly internal class member
    fileprivate func someFilePrivateFunction() {} // explicitly file-private class member
    private func somePrivateMethod() {} // explicitly private class member
}

class SomeInternalClass1 { // implicitly internal class
    var someInternalProperty = 0 // implicitly internal class member
    fileprivate func someFilePrivateFunction(){} // explicitly file-private class member
    private func somePrivateMethod() {} // explicitly private class member
}

fileprivate class SomeFilePrivateClass1 { // explicitly file-private class
    func  someFilePrivateFunction()  {} //implicitly file-private class member
    private func somePrivateMethod(){}  // explicitly private class member
}

private class SomePrivateCalss1{    //explicitly private class
    func  somePrivateMethod() {}    //implicitly private class member
}

//: #### 元组类型
//: 元组类型的访问级别是该元组中使用的所有类型的限制最大的访问级别。如，如果是两个不同类型组成一个元组，一个具有内部访问，另一个具有私有访问权限，那么该复合元组类型的访问级别将是私有的。
//: ```
//: 注意
//: 元组类型不像类、结构、枚举的方法一样拥有一个独立的定义和功能。元组类型使用时自动推导出元组类型的访问级别，不能显式指定。

//: #### 方法类型
//: 方法类型的访问级别是该方法的参数类型和返回类型中使用的所有类型的限制最大的访问级别。如果函数的访问级别与上下文默认值不匹配，则必须显式指定访问级别作为函数定义的一部分。
//: 下例展示了定义一个没有提供明显权限控制的方法 someFunction() 的全局函数，你可能希望该方法有默认(internal)的访问权限，但事实并非如此。事实上，somefunction()不会编译为写在下面：
//: ```
//: func someFunction() -> (SomeInternalClass , SomePrivateCalss) {
//:    // function implementation goes here
//: }
// 这里报错 function must be declared private or fileprivate because its result uses a private type

//: 方法的返回类型是由上述自定义类类型组成的元组类型，一个是internal类型，另一个是private。因此，复合元组类型的总体访问级别是私有的（元组的组成类型的最小访问级别）。

//: 因为上述someFunction()方法的返回值类型是private，因此，该方法必须需要总体访问级别 为 private 的修饰符来修饰。
private func someFunction() -> (SomeInternalClass , SomePrivateCalss) {
    // function implementation goes here
    return (SomeInternalClass(),SomePrivateCalss())
}
//: 用public或内部(internal)修饰符标记somefunction()是无效的，或者使用内部默认设置，因为公开(public)或内部(internal)用户的功能可能没有适当的访问用于函数的返回类型的私人权限。

//: #### 枚举类型
//: 枚举的单个实例自动接收与它们所属枚举相同的访问级别。不能为单个枚举情况指定不同的访问级别。
//: 下例中的 CompassPoint 枚举 有public 的权限修饰符。枚举常量 north，south, east, west 也拥有相同的权限修饰符(public)。
public enum CompassPoint {
    case north
    case south
    case east
    case west
}

//: #### 原始值和关联值
//: 用于枚举定义中的任何原始值或相关值的类型必须具有至少与枚举的访问级别一样高的访问级别。例如,不能将私有(private)类型用作具有内部(internal)访问级别的枚举的原始值类型。

//: #### 嵌套类型(Nested Types)
//: 在私有类型(private)中定义的嵌套类型自动具有私有的访问级别。在文件私有(file-private)类型中定义的嵌套类型自动具有文件私有的访问级别。在公共类型(public)或内部类型(internal)中定义的嵌套类型自动具有内部(internal)的访问级别。如果希望公共类型中的嵌套类型公开可用，则必须显式声明嵌套类型为public。

//: #### 子类型
//: 可以在当前访问上下文中访问任何类的子类。子类不能比父类的访问级别高。例如:你不能写一个内部类公共类。
//: 此外，可以覆盖在某个访问上下文中可见的任何类成员（方法、属性、初始化器或下标）。
//: 重写继承的类成员可以比父类的权限容易(？)。在下例中，类A是有私有的方法someMethod()的公共类文件。B类是A类的一个内部访问级别降低的子类。然而，B类提供了someMethod()覆写与接入层面的“内部(internal)”访问权限，这是高于someMethod()原有实现的权限：
public class A {
    fileprivate func someMethod(){}
}
internal class B : A {
    override internal func someMethod() {}
}
//: 如果父类拥有比子类低的访问权限，只要调用父类的成员在允许的访问级别下，子类调用父类的成员会更有效(即在同一源文件作为一个文件调用父类的私有成员，或同一个模块作为一个内部成员调用父类)。(百度：这是更有效的一类成员的调用超类的成员，类的成员访问权限较低，只要调用父类的成员在一个允许的访问级别的背景下发生的（即在同一源文件作为一个文件调用父类的私有成员，或同一个模块作为一个内部成员调用父类)

public class AA {
    fileprivate func someMethod(){}
}
internal class BB: AA {
    override func someMethod() {
        super.someMethod()
    }
}
//: 上例中，因为 父类 AA 和 子类BB 定义在同一个源文件中，在B 的实现中 调用super.someMethod() 是有效的。

//: #### 常量，变量，属性及下标
//: 常数、变量或属性不能比其类型更公开。例如，用私有类型编写公共属性是无效的。类似地，下标不能比它的索引类型或返回类型更公开。如果常量、变量、属性或下标使用私有类型，则常量、变量、属性或下标也必须标记为私有：
private var privateInstance = SomePrivateCalss()

//: #### getters 和 setters 属性方法
//: getters 和 setters 拥有与他所属的常量、变量、属性和下边相同的权限。可以为 setter 一个低级别的访问权限比他相关的getter，来限制 所属常量、属性或下标的读写权限。你可以定义一个低级别的访问权限通过在var 或 sunscript前添加 fileprivate(set)、private(set), 或者internal(set)

//```
//: 注意
//: 此规则适用于存储的属性以及计算的属性。即使你没有为存储属性编写显示的 setter和 getter，swift 仍然会提供一个一个以后会死的getter和setter，以提供对存储属性的存储访问。使用 fileprivate(set), private(set), internal(set)来更改该 setter 的权限，这种合成的访问级别为计算属性的显式设置。

//: 例子
struct TrackString {
    private(set) var numberOfEdits = 0 // 存储属性
    var  value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}
//: 上例中的结构体 *TrackString* 和 value 属性没有提供明显的访问控制权限，因此，他们有默认的权限(internal)。但是numberOfEdits 属性被标记为 private(set),来声明该属性的getter 仍然是默认的权限 *internal*, 但是该属性的设置属性 只能在 该结构体中赋值。这样 TrackedString 结构体可以在内部更改 internal，但是对外面来说 该属性是 read-only. 例子：

var stringToEdit = TrackString()
stringToEdit.value = "This string will be tracked"
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")//The number of edits is 3

//: 虽然你可以在另一个源文件查询的numberofedits属性的当前值，但是不能从另一个源文件修改该属性的值。这一限制保护的trackedstring实施细节编辑跟踪功能，同时还提供了方便的功能。
//: 注意： 如果需要，你可以同时为 getter 和 setter 添加显示的权限控制。下例中，展示了的结构体中定义了一个显示的权限控制 pullic。该结构体的成员(包含 numberOfEdits) 因此拥有一个默认的 inernal 权限。可以将结构体的 numberOfEdits 属性设置为 public，且其 setter 为 private，通过结合 public 和 private(set)来添加权限。

public struct TrackedString1{
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet{
            numberOfEdits += 1
        }
    }
    public init(){}
}
//: #### 构造方法
//: 自定义的构造方法可以有一个小于或等于设计的构造方法的权限。唯一的例外是必要构造器（定义为 Required Initializers）。一个必要构造器必须有和类定义相同的权限修饰符。
//: 与函数和方法参数一样，初始化器参数的类型不能比初始化器自身的访问级别更为私有。

//: #### 默认构造器
//: 如之前所属默认构造器所示，如果自身没有提供任何构造器，swift 为任何结构体和基本类默认提供一个默认的无参数的构造器，属性设置为默认值。
//: 默认初始化器具有与它初始化的类型相同的访问级别，除非该类型被定义为公共的(public)。对于定义为公共(public)的类型，默认初始化器被认为是内部(internal)的。如果你想要一个公共类型是一个无参数的初始化初始化时使用另一个模块中，您必须显式提供一个公共的无参数初始化自己的类型定义的一部分。

//: #### 结构类型的成员初始话构造器
//: 如果结构体的存储属性是私有的，那么这个结构体的默认逐个成员初始化方法认为是私有的。同样，如果任何结构的存储属性都是文件私有(file-private)的，则初始化器是文件私有的。否则，初始化器具有内部访问级别。
//: 与上面的默认初始化，如果想有一个公共的结构体类型有逐个成员初始化方法时使用另一个模块中，您必须提供一个公共的逐个成员初始化方法在类型定义的一部分。
//: #### 协议
//: 如果想显示为一个协议定义添加权限控制，那么在定义的时候就要加上。这使得可以定义在特定上下文中使用的协议。协议定义中的每个需求的访问级别将自动设置为与协议相同的访问级别。您不能将协议要求设置为不同的访问级别，而不是它支持的协议。这样可以确保所有协议的需求在采用该协议的任何类型上都是可见的。
//: ```
//: 注意
//: 如果定义一个 public 协议，那么协议的实现需要是public。协议这种行为不同于其他类型，其中公共类型定义意味着该类型成员的内部访问级别。

//: #### 协议继承
//: 如果一个协议继承自另一个协议，新协议可以最多有和其继承的协议相同的访问级别。例如，你不能定义一个 public 的协议，而其父类是 internal。

//: #### 协议的一致性(Protocol Conformance)
//: 一个类型可以实现一个访问级别比它地的协议类型。例如：定义一个可以在其他module 中使用的public 类型，但是该类型实现一个 internal 的协议，但是其只能在定义模块中使用。
//: 类型符合特定协议的上下文是类型访问级别和协议访问级别的最小值。如果一个类型是公共的，但是它遵循的协议是内部的，那么类型与该协议的一致性也是内部的。
//: 当编写或扩展一个类型来遵从一个协议时，您必须确保每个协议的类型的实现至少具有与该协议类型一致的相同访问级别。例如，如果一个公共类型符合一个内部协议，那么每种协议的类型的实现必须至少是“内部的”。
//: ```
//: 注意
//: 在Swift中，就像在Objective-C中一样，协议一致性是全局的，在同一个程序中，一个类型不可能以两种不同的方式遵守协议。

//: #### 扩展
//: 在任何访问上下文中扩展类、结构或枚举，其中可以使用类、结构或枚举。在扩展中添加的任何类型成员都具有与被扩展的原始类型中声明的类型成员相同的默认访问级别。如果您扩展了一个公共或内部类型，那么您添加的任何新类型成员都有一个默认的内部访问级别。如果扩展了文件-私有类型，那么添加的任何新类型成员都具有默认的文件私有访问级别。如果您扩展了一个私有类型，您添加的任何新类型成员都有一个私有的默认访问级别。
//: 可以使用显式的访问级修饰符(例如，private)标记一个扩展，以便为扩展中定义的所有成员设置一个新的默认访问级别。对于单个类型的成员，这个新的默认值仍然可以被覆盖。

//: #### 扩展中的私有成员
//: 扩展的扩展与类、结构或枚举的扩展行为类似，就像扩展中的代码被编写为原始类型的声明的一部分一样。例如：
//: > 在原始声明中声明一个私有成员，并从同一文件中的扩展中访问该成员。
//: > 在一个扩展中声明一个私有成员，并在同一个文件中从另一个扩展中访问该成员。
//: > 在扩展中声明一个私有成员，并从同一文件中的原始声明中访问该成员。
//: 如下例

protocol SomeProtocol {
    func  doSomething()
}

struct SomeStruct {
    private var privateVariable = 12
}

extension SomeStruct : SomeProtocol {
    func doSomething() {
        print(privateVariable)
    }
}
var s = SomeStruct()
s.doSomething()

//: #### 泛型
//: 泛型类型或泛型函数的访问级别是泛型类型或函数本身的访问级别，以及其类型参数的任何类型约束的访问级别。

//: #### 类型别名
//: 您所定义的任何类型别名都作为访问控制的目的被视为不同类型。类型别名可以拥有小于或等于它别名的访问级别的访问级别。例如，私有类型的别名可以别名私有、文件-私有、内部、公共或开放类型，但是公共类型的别名不能别名内部、文件-私有或私有类型。
//:```
//: 注意
//: 该规则还适用于用于满足协议的关联类型的类型别名。


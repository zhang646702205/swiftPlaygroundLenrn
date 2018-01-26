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
//: 


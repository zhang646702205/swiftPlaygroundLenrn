//: [继承](@继承)

import Foundation
import UIKit
//: 一个类可以继承另一个类的方法，属性和其它特性。当一个类继承其它类时，继承类叫子类，被继承的类叫超类（或父类）。*swift中，继承是区分[类]与其它类型的一个基本特征。*
//: swift 中，类可以调用和访问超类的方法，属性和下标，并且可以重写这些方法，属性和下标来优化或修改它的行为。swift会检查重写定义在超类中是否有匹配的定义，以确保重写行为是正确的。可以为类中继承来的属性添加属性观察器，这样一来，当属性值改变时，类就会被通知到。可以为任何属性添加属性观察器，无论它原本被定义为存储型属性还是计算型属性。
//: #### 定义一个基类
//: 不继承于其它类的类，称之为 *基类*。
//: ```
//: 注意
//: swift 中的类不是从一个通用的基类继承。若你没有为你定义的类指定一个超类，这个类就自动成为基类。
// 下面例子
class Vehicle {
    var currentSpeed = 0.0
    var description:String {
        return "traviling at \(currentSpeed) miles per hour"
    }
    func makeNoise()  {
        // 什么也不做-因为一辆车不一定有噪音
    }
}
//初始化语法：类名后面跟一个空括号
let someVehicle = Vehicle()
print("Vehicle:\(someVehicle.description)")//Vehicle:traviling at 0.0 miles per hour
//: #### 子类的生成
//: *子类* 指的是在一个已有类的基础上创建一个新的类。子类继承超类的特性，可以进一步完善。可以添加新的特性：
//: ```
//: class SomeClass:SomeSupeClass {
//:    // 这里是子类的定义
//: }
// 下面的例子，定义一个bycle 的子类，继承自父类
class Bicycle : Vehicle{
    var hasBasket = false
}
// 使用
let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle:\(bicycle.description)")//Bicycle:traviling at 15.0 miles per hour
// 子类还可以继续被继承
class Tandem : Bicycle {
    var  currentNumberOfPassengers  = 0
}
// 使用
 let tandem = Tandem()
tandem.hasBasket = true
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem : \(tandem.description)")//Tandem : traviling at 22.0 miles per hour
//: #### 重写
//: 子类可以为继承来的实例方法，类方法，属性，或下标提供自己定制的实现，这种行为叫做*重写*。
//: 若要重写某个特性，需要在重写定义的前面加上override 关键字。表明你是想提供一共一个重写的版本，而不是错误的提供一个相同的定义。缺少voverride 关键字的重写都会在编译时被诊断为错误。override 关键字会提醒swift 编译器去检查该类的超类（或其中一个父类）是否有匹配的版本声明。
//: #### 访问超类的方法，属性及下标
//: 在子类中重写超类的方法，属性或下标时，有时在你的重写版本中使用已经存在的超类实现会大有裨益。
//: 在合适的地方，可以使用*super* 前缀来访问超类版本中的方法，属性或下标：
//: - 在方法中重*someMethod()*写实现，可以通过*super.someMethod()*来调用超类中的someMethod()方法。
//: - 在属性*someProperty()*的getter或setter重写实现中，可以通过*super.someProperty()*来访问超类的*somePrpperty*属性。
//: - 在下标的重写实现中，可以通过 super[someIndex]来访问超类版本中的相同下标。
//: #### 重写方法
//: 在子类中，可以重写继承的实例方法或类方法，提供一个定制或代替方法的实现。如：
class Train : Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}
// 创建Train的新实现，并调用他的 makeNoise 方法
let train = Train()
train.makeNoise()//Choo Choo
//: #### 重写属性
//: 可以重写继承的实例属性或类型属性，提供自己的getter和setter，或添加属性观察器使重写的属性可以观察属性值发生改变的时间。
//: ###### 重写属性的Getters和Setters
//: 可以提供定制的 getter（或 setter）来重写任意继承来的属性，无论继承来的属性是存储型的还是计算型的属性。子类并不知道继承来的属性是存储型的还是计算型的，它只知道继承来的属性会有一个名字和类型。你在重写一个属性时，必需将它的名字和类型都写出来。才能使编译器去检查你重写的属性是与超类中同名同类型的属性相匹配的。可以将继承来的只读属性重写为一个读写属性，只需要在重写版本的属性里提供 getter 和 setter 即可。但是不可以将一个继承来的读写属性重写为一个只读属性。
//: ```
//: 注意
//: 如果在重写属性中提供了 setter，那么你也一定要提供 getter。如果不想在重写版本中的 getter 里修改继承来的属性值，你可以直接通过super.someProperty来返回继承来的值，其中someProperty是你要重写的属性的名字。
// 下例中 重写Vehicle 的description 属性
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}
// 使用
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car:\(car.description)")//Car:traviling at 25.0 miles per hour in gear 3
//: ###### 重写属性观察器
//: 通过重写属性为一个继承来的属性添加属性观察器。这样一来，当继承来的属性值发生改变时，你就会被通知到，无论那个属性原本是如何实现的。
//: ```
//: 注意
//: 不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器。这些属性的值是不可以被设置的，所以，为它们提供willSet或didSet实现是不恰当。还要注意，不可以同时提供重写的 setter 和重写的属性观察器。如果你想观察属性值的变化，并且你已经为那个属性提供了定制的 setter，那么你在 setter 中就可以观察到任何值变化了。
//
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
// 设置AutomaticCar的currentSpeed属性，属性的didSet观察器就会自动地设置gear属性，为新的速度选择一个合适的挡位。具体来说就是，属性观察器将新的速度值除以10，然后向下取得最接近的整数值，最后加1来得到档位gear的值。例如，速度为35.0时，挡位为4
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")//AutomaticCar: traviling at 35.0 miles per hour in gear 4
//: #### 防止重写
//: 可以通过把方法，属性或下标标记为 *final* 来防止它们被重写，只需在声明关键字前加*final*修饰符即可（例如：final var , final func, final class func , 以及final subscript）
//: 如果重写了带有final 标记的方法，属性或下标，在编译时会报错。在类扩展中的方法，属性或下标也可以在扩展的定义里标记为final。
//: 可以通过在关键字class 前添加final修饰符（final class）来将整个类标记为final。这样的类是不能被继承的。试图继承这样的类回编译报错。




//: [构造过程](@构造过程)

import Foundation
import UIKit
//: *构造过程*是类、结构体或枚举类型的实例之前的准备过程。新实例可用之前必须执行这个过程，具体包括设置实例中的每个存储型属性和执行其他必须设置或初始化工作。定义构造器来实现构造过程，可以看作是用来构建特定类型新实例的特殊方法。与oc不同的是，swift构造器无需返回值，主要任务是保证新实例在第一次使用前完成正确的初始化。
//: #### 存储属性的初始赋值
//: 类和结构体在创建实例时，必须为所有的存储型属性设置合适的初始值。其值不能处于未知状态。可以在构造器中为存储型属性赋初值，也可以在定义时为其设置默认值。
//: ```
//: 注意
//: 当为存储型属性设置默认值或在构造器中为其赋值时，它们的值是被直接设置的，不会触发任何属性观察者。

//: #### 构造器
//: 构造器在构造某个新类型的实例
//: ```
//: init(){
//:    // 在此处执行构造过程
//: }

// 下例中展示如何使用
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
//print("The default temperature is \(f.temperature)° Fahrehiet")//The default temperature is 32.0° Fahrehiet

//: #### 默认属性值
//: 可以在构造器中为存储型属性设置初始值，同样也可以在属性声明时设置默认值。
//: ```
//: 注意
//: 若一个属性总是使用相同的初始值，那么为它设置一个默认值比每次在构造器中赋值好。效果是一样的，不过使用默认值让属性初始化和声明结合更紧密。使用默认值让构造器更简洁、清晰，且能自动推导出属性的类型。同时也能充分利用默认构造器、构造器继承等特性。
struct Fahrenheit1 {
    var temperature = 32.0
}
//: #### 自定义构造过程
//: 可以通过输入参数和可选类型的属性来自定义构造过程，也可以在构造过程中修改常量属性。
//: #### 构造参数
//: 自定义构造过程时，可以在定义中提供构造参数，指定所需值的类型和名字。构造参数的功能和语法跟函数和方法的参数相同。 如下例：
struct Celsius {
    var temperatureInCelsius:Double
    init(fromFahrenheit fahrenheit:Double) {
        temperatureInCelsius = (fahrenheit - 32.0)/1.8
    }
    init(fromKelvin kelvin:Double) {
        temperatureInCelsius = kelvin - 237.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212)
print("boilingPointOfWater.temperatureInCelsius \(boilingPointOfWater.temperatureInCelsius)")//boilingPointOfWater.temperatureInCelsius 100.0
let freezingPointOfWater = Celsius(fromKelvin: 237.15)
print("freezingPointOfWater.temperatureInCelsius \(freezingPointOfWater.temperatureInCelsius)")//freezingPointOfWater.temperatureInCelsius 0.0
//: #### 参数的内部名称和外部名称
//: 与函数和方法参数相同，构造参数也拥有一个在构造器内部使用的参数名字和一个在调用构造器时使用的外部参数名字。构造器并不像函数和方法那样在括号前有一个可辨别的名字。因此在调用构造器时，主要通过构造器中的参数名和类型来确定应该被调用的构造器。正因为参数如此重要，如果在定义构造器时没有提供参数的外部名字，Swift 会为构造器的每个参数自动生成一个跟内部名字相同的外部名。
struct Color {
    let red, green, blue:Double
    init(red:Double, green:Double, blue:Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halgGray = Color(white: 0.5)

//: ```
//: 注意，如果不通过外部参数名字传值，你是没法调用这个构造器的。只要构造器定义了某个外部参数名，你就必须使用它，忽略它将导致编译错误：let VeryGreen = Color(0.0,1.0,0.0)// 报编译错误
//: #### 不带外部名的参数构造器参数
//: 如果不希望为构造器的某个参数提供外部名字，你可以使用下划线(_)来显式描述它的外部名
struct Celsius1 {
    var temperatureInCelsius:Double
    init(fromFahrenheit fahrenheit:Double) {
        temperatureInCelsius = (fahrenheit - 32.0)/1.8
    }
    init(fromKelvin kelvin:Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius:Double) {
        temperatureInCelsius = celsius
    }
}

let bodyTemperature = Celsius1(37.0)//
print("bodyTemperature.temperatureInCelsius 为 \(bodyTemperature.temperatureInCelsius)")
//: #### 可选属性
//: 如果定制的类型逻辑上允许为空的存储型属性--无论是因为它无法在初始化时赋值，还是因为它在之后某个时间点可以赋值为空--都需要定义为可选类型。可选类型初始化为nil，表示这个属性是有意在初始化设置为空。如下例：
class SurveyQuestion {
    var text:String
    var  response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()// Do you like cheese?
cheeseQuestion.response = "Yes, I do like cheese."
// 问题回答前无法确定答案，所以将response声明为 string？ 类型，或者说 可选字符串类型
//: #### 构造过程中常量属性的修改
//: 可以在构造过程的任意时间点给常量属性指定一个值，只要在构造结束时是一个确定的值即可。常量属性一旦被赋值，将永远不可改变。
//: ```
//: 注意
//: 对于类实例来说，常量属性只能定义在他的类构造过程中修改，不能在子类中修改。
class SurveyQuestion1{
    let text:String
    var response:String?
    init(text: String) {
        self.text = text
    }
    func ask()  {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion1(text: "How about beets?")
beetsQuestion.ask()//How about beets?
beetsQuestion.response = "I also like beets."
//: #### 默认构造器
//: 若结构体或类的所有属性都有默认属性，且没有自定义的构造器，swift会给他们提供一个默认构造器（default initalizers）。改构造器将简单的创建一个所有属性值都为默认值的实例。如下例：
class ShoppingListItem {
    var name:String = "" //这里必须有初始值
    var quantity  = 1
    var purchased = false
}
var item = ShoppingListItem()
//: #### 结构体的逐一成员构造器
//: 除默认构造器，如果结构体没有提供自定义的构造器，将自动获得一个逐一成员构造器，即使结构体的存储属性没有默认值。逐一成员构造器时初始化结构体新实例成员属性的快捷方法。通过与成员属性名相同的参数来进行传值完成对成员属性的初始赋值。如：
struct Size1 {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size1(width: 2.0, height: 2.0)
//: #### 值类型的构造器代理
//: 构造器可以通过调用其他构造器来完成实例的部分构造，这个过程叫做构造器代理能减少构造器间的代码重复。
//: 构造器代理的实现规则和形式在值类型和类类型中有所不同。值类型（结构体和枚举）不支持继承，所以构造器代理的过程相对简单，只能代理给自己的其它构造器。类则不同，可以继承自其他类，也就是说类有责任保证其所有继承的存储型属性在构造时也能正确的初始化。值类型，可以使用self.init 在自定义的构造器中引用其他类型构造器。并且只能在构造器内部调用self.init.若为值类型定义了一个自定义的构造器，将无法访问默认构造器。可以防止你为值类型增加额外的构造器后，仍然有人错误的使用自动生成的构造器。
//: ```
//: 注意
//: 假如你希望默认构造器、逐一成员构造器以及你自己的自定义构造器都能用来创建实例，可以将自定义的构造器写到扩展（extension）中，而不是写在值类型的原始定义中。
struct Size2 {
    var width = 0.0, height = 0.0
}
struct Point1 {
    var x = 0.0 , y = 0.0
}
// 如下列rect 的构建过程
struct Rect {
    var origin = Point1()
    var size = Size2()
    init() {
    }
    init(origin: Point1, size: Size2) {
        self.origin = origin
        self.size = size
    }
    init(center:Point1, size: Size2) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        
        self.init(origin: Point1(x: originX, y: originY), size: size)
    }
    
    
}


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
// 调用init() 返回rect 实例，它的origin和size属性都使用定义时的默认值Point(x: 0.0, y: 0.0)和Size(width: 0.0, height: 0.0)
let basicRect = Rect()

// Rect构造器init(origin:size:)，在功能上跟结构体在没有自定义构造器时获得的逐一成员构造器是一样的。
let originRect = Rect(origin: Point1(x: 2.0, y: 2.0), size: Size2(width: 5.0, height: 5.0))// originRect 的 origin 是 (2.0, 2.0)，size 是 (5.0, 5.0)
// 第三个构造器
let centerRect = Rect(center: Point1(x: 4.0, y: 4.0), size: Size2(width: 3.0, height: 3.0))// centerRect 的 origin 是 (2.5, 2.5)，size 是 (3.0, 3.0)
//: ```
//: 注意
//: 你想用另外一种不需要自己定义init()和init(origin:size:)的方式来实现这个例子，请参考扩展

//: #### 类的继承和构造过程
//: 类里面的所有存储型属性——包括所有继承自父类的属性——都必须在构造过程中设置初始值。wift 为类类型提供了两种构造器来确保实例中所有存储型属性都能获得初始值，它们分别是指定构造器和便利构造器。
//: #### 指定构造器和便利构造器
//: 指定构造器是类的主要构造器。指定构造器将初始化类中提供的所有属性，并根据父类链调用父类的构造器去实现父类的初始化。每个类都必须拥有至少一个指定构造器。许多类通过继承父类的指定构造器满足这个条件。
//: 便利构造器是类中比较次要的、辅助型的构造器。可以定义便利构造器来调用一个类的指定构造器，并提供默认值。

//: #### 指定构造器和便利构造器的语法
//: ````
//:init(parameters){
//:    statements
//:}
//: 便利构造器写法与上述相同，在 *init* 关键字前加上*convenience*
//: ``` 
//:convenience init (parameters) {
//:    statements
//:}

//: #### 类的构造器代理规则
//: 简化指定构造器和便利构造器之间的调用关系，规则如下：
//:  > 规则1
//:     指定构造器必须调用器其直接父类的指定构造器。
//: > 规则2
//:     便利构造器必须调用同类中定义的其他构造器。
//: > 规则3 
//:     便利构造器必须最终导致一个指定构造器被调用。
//: 方便记忆方法：
//: - 指定构造器必须总是 向上代理
//: - 便利构造器必须宗师 横向代理
//: ```
//: 注意
//: 这些规则不会影响类的实例如何构建。任何构造器都可以用来创建完全初始化的实例。只影响类如何定义实现。

//: #### 两段式构造过程
//: swift 中类的构造过程包含两个阶段。第一阶段，每个存储型属性被引入它们的类指定一个初始值。当每个存储型属性的初始值被确定后，第二个阶段，它给每个类一次机会，在新实例准备使用之前进一步制定它们的存储属性。两段式构造过程的使用让构造过程更安全，同时在整个类层级结构中给予每个类完全的灵活性。两段式构造过程可以防止属性值在初始化之前被访问，也可以防止属性被另外一个构造器意外地赋予不同的值。
//: ```
//: 注意
//: Swift 的两段式构造过程跟 Objective-C 中的构造过程类似。最主要的区别在于阶段1 Objective-C 给每一个属性赋值0或空值（比如说0或nil）。Swift 的构造流程则更加灵活，它允许你设置定制的初始值，并自如应对某些属性不能以0或nil作为合法默认值的情况。

//: 安全检查 1
//: 指定构造器必须保证它所在类引入的所有属性都必须先初始化完成，后才能将其他构造任务向上代理给父类的构造器。如上，一个对象的内存只有在其所有存储属性确定后才能完全初始化，因此，指定构造器必须保证所在类引入的属性在它向上代理之前完成初始化。
//: 安全检查 2
//: 指定构造器必须先向上代理调用父类的构造器，然后再为任意属性赋新值。如果没这么做，便利构造器赋的值降被同一类中其他指定的构造器所覆盖。
//: 安全检车 3
//: 遍历构造器必须先代理调用同一类中的其他构造器，然后再为任意属性赋新值。如果没这么做，便利构造器赋予的新值将被同一个类中其他指定构造器所覆盖。
//: 安全检查 4
//: 构造器在第一阶段完成前，不能调用任何实例方法，不能读取任何实例的属性，不能引用self作为值。类实例在第一阶段结束以前并不是完全有效的了。只有第一阶段完成后，该实例才会成为有效实例，才能访问属性和调用方法。
//: 阶段 1
//: > 某个指定构造器或便利构造器被调用。
//: > 完成新实例内存的分配，但此时内存还没有被初始化。
//: > 指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化。
//: > 指定构造器将调用父类的构造器，完成父类属性的初始化。
//: > 这个调用父类构造器的过程沿着构造器链一直往上执行，直到到达构造器链的最顶部。
//: > 当到达了构造器链最顶部，且已确保所有实例包含的存储型属性都已经赋值，这个实例的内存被认为已经完全初始化。此时阶段 1 完成。
//: 阶段 2
//: - 从顶部构造器链一直往下，每个构造器链中类的指定构造器都有机会进一步定制实例。构造器此时可以访问self、修改它的属性并调用实例方法等等。
//: > 最终，任意构造器链中的便利构造器可以有机会定制实例和使用self。

//: #### 构造器的继承和重写
//: 与Objectve-C的子类不同，swift 的子类默认情况下不会继承父类的构造器。这种机制可以防止一个父类的简单构造器被一个更精细的子类继承，并错误的用来创建子类的实例。
//: ```
//: 注意
//: 父类的构造器仅在安全和适当的情况下被继承.

//: 如果希望自定义的子类中有与父类相同的构造器，可以在子类中提供这些构造器的自定义实现。如果编写一个月父类指定构造器相匹配的子类构造器，实际是在重写父类的指定构造器。此时必须在子类构造器上加上 override 修饰符。即使重写的是系统提供的默认构造器，页需要带上 override。

//: ```
//: 注意
//: 重写父类的指定构造器时，总是需要写override 修饰符，即使子类将父类的指定构造器重写为了便利构造器。

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheels"
    }
}
let vehicle = Vehicle()
print("Vehicle:\(vehicle.description)")//Vehicle:0 wheels

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}
let bicycle = Bicycle()
print("Bicycle:\(bicycle.description)")//Bicycle:2 wheels
//: ```
//: 注意
//: 子类可以在初始化时修改继承的变量属性，但是不能修改继承来的常量的属性。

//: #### 构造器的自动继承
//: 子类在默认情况下不会继承父类的构造器。但若满足特定条件，父类构造器是可以被自动继承的。意味着许多常见的场景不必重写父类的构造器，并可在安全的情况下以最小的代价继承父类的构造器。如果你的子类中引入的所有新属性都提供默认值，一下2 规则适用：
//: 规则 1
//: 如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器。
//: 规则 2 
//: 如果子类提供了 父类指定构造器的实现-- 无论是通过规则1继承，还是提供了自定义的实现-- 它将自动继承所有父类的便利构造器。
//: #### 指定构造器和便利构造器实践
//: 下面将展示 在实践中指定构造器、便利构造器及构造器的自动继承。

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
let oneMysteryItem = RecipeIngredient()
print("\(oneMysteryItem.name)=\(oneMysteryItem.quantity)")//[Unnamed]=1
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem1: RecipeIngredient {
    var  purchased  = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? "✅":"❌"
        return output
    }
}
//: ```
//: 注意
//: ShoppingListItem 没有定义构造器来为purchased提供初始值，因为添加到购物单的物品初始状态总是未购买

var breakfastList = [
    ShoppingListItem1(),
    ShoppingListItem1(name: "Bacon"),
    ShoppingListItem1(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}
//1 x Orange juice✅
//1 x Bacon❌
//6 x Eggs❌

//: #### 可失败构造器
//: 如果一个类、结构体或枚举类型的对象，在构造过程中可能失败，则定义一个可失败构造器。"失败"指的是如果给构造器传入一个无效的参数值，或缺少某种所需的外部资源，或是不满足某种必要的条件等。为了处理这种情况。可以在类、结构体或枚举类型中添加一个或多个失败构造器。语法为在 init 关键字后面添加问好(init?)
//: ```
//: 注意
//: 可失败构造器的参数名和参数类型，不能与其他非可失败构造器的参数名及其类型相同。 严格说，构造器都不支持返回值。因为构造器本身的作用，只是为了确保对象能被正确的构造。因此你只是用 return nil 表明可失败构造器构造失败，而不用关键字 return 表明构造成功。

//: 例子
let wholeNumber : Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value")
}//12345.0 conversion to Int maintains value
let valueChanged = Int(exactly: pi)
//valueChanged 类型是 int？ 类型 而不是 int 类型
if valueChanged == nil  {
    print("\(pi) conversion to Int does not maintain value")
}//3.14159 conversion to Int does not maintain value
//: 下面可空的构造器
struct Animal {
    let species : String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}//An animal was initialized with a species of Giraffe

let anonymousCreature = Animal(species: "")
if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}//The anonymous creature could not be initialized

//: #### 枚举类型的可失败构造器
//: 你可以通过一个带一个或多个参数的可失败构造器来获取枚举类型中特定的枚举成员。如果提供的参数无法匹配任何枚举成员，则构造失败。如下例：
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a befined temperature unit, so initialization succeeded")
}//This is a befined temperature unit, so initialization succeed
let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed")
}//This is not a defined temperature unit, so initialization failed
//: #### 带原始值的枚举类型的可失败构造器
//: 带原始值的枚举类型会自带一个可失败的构造器 *init?(rawValue:)* , 该可失败构造器有一个名为rawValue的参数，其类型和枚举类型的原始值类型一致，如果该参数的值能够和某个枚举成员的原始值匹配，则该构造器会构造相应的枚举成员，否则构造失败。
//: 重写 temperatureUnit
enum TemperatureUnit1: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}
let fahrenheitUnit1 = TemperatureUnit1(rawValue: "F")
if fahrenheitUnit1 != nil {
    print("This is a defined temperature unit, so initialization succeeded")
}// This is a defined temperature unit, so initialization succeeded
let unknownUnit1 = TemperatureUnit1(rawValue: "X")
if unknownUnit1 == nil {
    print("This is not a defined temperature unit ,son initialization failed.")
}//This is not a defined temperature unit ,son initialization failed

//: #### 构造失败的传递
//: 类，结构体，枚举的可失败构造器可以横向代理到类型中的其他可失败构造器。类似的，子类的可失败构造器也能向上代理到父类的可失败构造器。无论是向上代理还是横向代理，如果代理到的其他可失败构造器触发构造失败，整个构造过程立即终止，接下来的任何构造代码 不会再执行。
//: ```
//: 注意
//: 可失败构造器也可以代理到其他的非可失败构造器。这种方式，可以增加一个可能的失败状态到现有的构造过程中。

class Product {
    let name: String
    init?(name:String) {
        if name.isEmpty {return nil}
        self.name = name
    }
}

class CarItem : Product {
    let quantity :Int
    init?(name: String, quantity: Int) {
        if quantity < 1 {return nil}
        self.quantity = quantity
        super.init(name: name)
    }
}
if let twoSocks = CarItem(name: "shirt", quantity: 2){
    print("Item: \(twoSocks.name), quantity:\(twoSocks.quantity)")
}//Item: shirt, quantity:2
if let zeroShirts = CarItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
}else {
    print("Unable to initialize zero shirts")
}//Unable to initialize zero shirts

//: #### 重写一个可失败构造器
//: 如同其它的构造器，你可以在子类中重写父类的可失败构造器。或者你也可以用子类的非可失败构造器重写一个父类的可失败构造器。这使你可以定义一个不会构造失败的子类，即使父类的构造器允许构造失败。

//: 注意，当你用子类的非可失败构造器重写父类的可失败构造器时，向上代理到父类的可失败构造器的唯一方式是对父类的可失败构造器的返回值进行强制解包。
//: document 类
class Document {
    var  name: String?
    init() {}

    init?(name:String) {
        self.name = name
        if name.isEmpty {return nil}
    }
}
class AutomaticallyNameDocument : Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        }else {
            self.name = name
        }
    }
}
//: 你可以在子类的非可失败构造器中使用强制解包来调用父类的可失败构造器。
class UntitleDocument : Document {
    override init() {
        super.init(name: "[Unititled]")!
    }
}
//: #### 可失败构造器 init！
//: 通常我们通过在init 关键字后添加问号的方式(init?)来定义一个可失败的构造器，可以通过在init 后面添加感叹号的方式类定义一个可失败的构造器（init!）,该可失败构造器会构建一个对应类型的隐士解包可选类型的对象。

//: #### 必要构造器
//: 在类的构造器前添加 *require* 修饰符表明所有该类的子类都必须实现该构造器
class SomeClass {
    required init(){}
}
//: 在子类重写的必要构造器时，必须在子类的构造器前加 *require*修饰符，表明该构造器要求也应用于继承链后的子类。重写父类中必要构造器时，不需添加 override 修饰符：
class SomeSubclass : SomeClass {
    required init() {
        //daima
    }
}
//: ```
//: 注意
//: 如果子类继承的构造器能满足必要构造器的要求，则无须在子类中显式提供必要构造器的实现。

//: #### 通过闭包或函数设置属性的默认值
//: 若某个存储型属性的默认值需要一些定制或设置，可以使用闭包或全局函数为其提供定制的默认值。当某个属性的类型的新实例被创建时，对应的闭包或函数会被调用，它们的返回值回当作默认值赋值给这个属性。这种类型的闭包或函数通常会创建一个跟属性类型相同的临时变量，然后修改它的值以满足预期的初始状态，最后返回这个临时变量。
//: ```
//: class SomeClass1 {
//:    let someProperty: SomeType = {
//:         // 闭包中给someProperty 创建一个默认值
//:         // someValue 必须和 sometype 类型相同
//:         return someValue
//:     }()
//: }

//: 注意 闭包结尾的大括号后面接了一对空的小括号。用来说明 立即执行次闭包。若忽略了这对括号，相当于闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性
//: ```
//: 注意
//: 如果你使用闭包来初始化属性，请记住在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能在闭包里访问其它属性，即使这些属性有默认值。同样，你也不能使用隐式的self属性，或者调用任何实例方法。

struct Checkerboard {
    let boardColors:[Bool] = {
        var temporatyBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporatyBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        print("---6666--")
        return temporatyBoard
    }()
    func squareIsBlackAtRow(row: Int, colume: Int) -> Bool {
        return boardColors[(row * 8) + colume]
    }
}
// 当一个新的checkboard 实例被创建时，赋值闭包被执行,boardColors 的默认值回被计算出来并返回。
let board = Checkerboard()
print(board.squareIsBlackAtRow(row: 0, colume: 1))// true
print(board.squareIsBlackAtRow(row: 7, colume: 7))// false

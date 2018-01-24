//: [协议](@协议)

import Foundation
import UIKit
//: 协议 定义了一个 蓝图，规定用来实现某一个特定人物或者功能的方法、属性，以及其他需要的东西。类、结构体和枚举都可以遵循协议，并为协议定义的要求提供具体实现。某个类型能够满足某个协议，就说 该类型 遵循 这个协议。
//: 除了遵循协议的类型必须实现的要求外，还可以对协议进行扩展，通过扩展来实现一部分或者实现一些附加功能，这样遵循协议的类型就能够使用这些功能。

//: #### 协议语法
//: 协议语法与类、结构体和枚举定义相似：
//:```
//: protocol SomeProtocol {
//:    // 协议的定义部分
//: }

//: 要让自定义类遵循某个协议，定义时，在类型名称后加上协议名称，加冒号(:) 分割。遵循多个协议时，各协议之间用 逗号 分隔。
//: ```
//: struct SomeStructure: FirstProtocol, AnotherProtocol {
//:    // 结构体的定义部分
//: }

//: 拥有父类的类在遵循协议时，应将父类名放在协议之前，用逗号分隔：

//: ```
//: class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
//:    // 类的定义部分
//: }

//: #### 属性要求
//: 协议可以要求遵循协议的类型提供特定名称和类型实例属性或者类型属性。协议不指定属性是存储型属性还是计算型属性，只指定属性的名称和类型。协议还指定属性是刻度还是可读可写的。 如果协议要求属性是可读可写的，该属性不能是常量属性或只读的计算属性。
//: 协议总是 用 var 关键字来声明变量属性，类型声明后加上{set get} 来表示属性是可读可写的，可读属性则用{get}表示：
protocol SomeProtocol{
    var mustBeSettable: Int {get set}
    var doesNotNeedToBeSettable: Int{get}
    
}
//: 在协议中定义类型属性时，总是使用 static 关键字作为前缀，类类型遵循协议时，除了 static 关键字，还可以用 class 关键字来声明：
protocol AnotherProtocol {
    static var someTypeProperty: Int{get set}
}
//:下面是一个只含 一个实例属性要求的协议例子：
protocol FullyNamed {
    var fullName: String {get}
}
// person 类例子
struct Person: FullyNamed {
    var  fullName: String
}
let john = Person(fullName: "John Appleseed")// person.full wei "John Appleseed"
print(john.fullName)

// 复杂的类
class Starship: FullyNamed {
    var prefix: String?
    var name:String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var ncc1701 = Starship(name: "Enterprist", prefix: "USS")
print(ncc1701.fullName)//USS Enterprist

//: #### 方法要求
//: 协议可以要求遵循协议的类型实现某些指定实例方法或类方法。方法作为协议的一部分，像普通方法一样放在协议的定义中，不需要打括号和方法体。可以在协议中定义具有可变参数的方法，和普通方法的定义方式相同。不支持为协议汇中的方法的参数提供默认值。
//: 正如属性要求中所述，在协议中定义类方法的时候，总是使用 static 关键字作为前缀。当类类型遵循协议时，除了 static 关键字，还可以使用 class 关键字作为前缀：
protocol SomeProtocol1{
    static func someTypeMethod()
}
protocol RandomNumberGenerator {
    func random() -> Double
}
// RandomNumberGenerator 协议要求遵循协议的类型必须拥有一个名为 random， 返回值类型为 Double 的实例方法。尽管这里未指明，但是我们假设返回值在 [0.0,1.0) 区间内。下例是一个遵循 RandomNumberGenerator 协议的类。
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = (lastRandom * a + c ).truncatingRemainder(dividingBy: m)
        return lastRandom/m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")//Here's a random number: 0.37464991998171
print("And another one :\(generator.random())")//And another one :0.729023776863283

//: #### Mutating 方法要求
//: 有时需要在方法中改变方法所属的实例。如，在值类型（即结构体和枚举）的实例方法中，将 mutating 关键字作为方法的前缀，写在 func 关键字之前，表示可以在该方法中修改它所属的实例以及实例的任意属性的值。
//: ```
//: 注意
//: 实现协议中 mutating 方法时，若是类类型，则不需要写 mutating 关键字。对于结构体和枚举，必须写 mutating 关键字。

//: 如：
protocol Togglable{
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
   mutating func toggle() {
        switch self {
        case .on:
            self = .off // 此时 若方法没有 mutating 修饰，则报错 self is immutable
        case .off:
            self = .on
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle() // 此时 为 on
//: #### 构造器要求
//: 协议可以要求遵循协议的类型实现指定的构造器。像编写普通构造器那样，协议的定义写下构造器的声明，不需要写花括号和构造器的实体。
protocol SomeProtocol2 {
    init(someParameter: Int)
}

//: #### 构造器要求在类中的实现
//: 可以在遵循协议的类中实现构造器，无论作为指定构造器，还是便利构造器。去论那种情况，都必须为构造器实现标上 required 修饰符：
class SomeClass: SomeProtocol2 {
    required init(someParameter: Int) {//使用 required 修饰符可以确保所有子类也必须提供此构造器实现，从而也能符合协议。
        // 实现部分
    }
}
//: ```
//: 注意
//: 若类被标注为 final ，那么不需要在协议构造器的实现中使用 required 修饰符。因为final 类不能有子类。
//: 如果一个子类重写了 父类的指定构造器，并且该构造器满足某个协议的要求，那么该构造器需要同时标注 required 和 override 修饰符：

protocol SomeProtocol3 {
    init()
}

class SomeSuperClass {
    init() {
        // 构造器实现部分
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol3 {
    // 因为遵循协议，需要加上 required
    // 因为继承自父类，需要加上 override
    required override init() {
        // 构造器的实现部分
    }
}

//: #### 可失败构造器要求
//: 协议还可为遵循协议的类型定义可失败构造器要求。
//: 遵循协议的类型可以通过 可失败构造器(init?) 或 非可失败构造器(init) 来满足协议定义的可失败构造器的要求。协议中定义的非可失败构造器要求可以通过非可失败构造器(init) 或隐士解包可失败构造器(init!).

//: #### 协议作为类型
//: 尽管协议本身并未实现任何功能，但协议可以被当作一个成熟的类型来使用。
//: 协议可以像普通类型一样，使用场景如下：
//: > 作为函数、方法或构造器中的参数类型或返回值
//: > 作为常量、变量或属性的类型
//: > 作为数组、字典或其他容器中的元素类型

//: ```
//: 注意
//: 协议是一种类型，因此协议类型的名称应与其他类型(如 Int，Double，String)的写法相同，使用大些字母开头的驼峰式写法。
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func  roll() -> Int {
        return Int(generator.random()*Double(sides)) + 1
    }
}
//: generator 属性的类型为 RandomNumberGenerator，因此任何遵循了 RandomNumberGenerator 协议的类型的实例都可以赋值给 generator，除此之外并无其他要求。 同样的，Dice 类还有一个构造器，用来设置初始状态。构造器有一个名为 generator，类型为 RandomNumberGenerator 的形参。在调用构造方法创建 Dice 的实例时，可以传入任何遵循 RandomNumberGenerator 协议的实例给 generator。

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}
//Random dice roll is 3
//Random dice roll is 5
//Random dice roll is 4
//Random dice roll is 5
//Random dice roll is 4

//: #### 委托(代理)模式
//: 委托 是一种设计模式，允许类或结构体将一些需要它们负责的功能委托给其他类型的实例。 委托模式的实现很简单：定义协议来封装哪些需要被委托的功能，这样就确保遵循协议的类型能提供这些功能。委托模式可以用来响应特定的动作，或者接收外部数据源提供的数据，无需关心 外部数据源的类型。

protocol DiceGame {
    var dice: Dice{get}
    func play()
}
protocol  DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceROll diceRoll: Int)
    func gameDidEnd(_ game : DiceGame)
}
//: DiceGame 协议可以被任意涉及骰子的游戏遵循。DiceGameDelegate 协议可以被任意类型遵循，用来追踪 DiceGame 的游戏过程。

class SnakesAndLadders: DiceGame {

    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var  board: [Int]
    init() {
        board = [Int](repeating : 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11 ; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceROll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare :
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
            
        }
        delegate?.gameDidEnd(self)
    }
}
//: 示例
class DiceGameTracker: DiceGameDelegate {
    var  numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceROll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()
//Started a new game of Snakes and Ladders
//The game is using a 6-sided dice
//Rolled a 3
//Rolled a 5
//Rolled a 4
//Rolled a 5
//The game lasted for 4 turns

//: #### 通过扩展添加协议一致性
//: 即使无法修改源代码，依然可以通过扩展令已有类型遵循并符合协议。扩展可以为已有类型添加属性、方法、下标以及构造器，因此可以符合协议中的相应要求。

//: ```
//: 注意
//: 通过扩展令已有类型遵循并符合协议时，该类型的所有实例也会随之获得协议中定义的各项功能。

//: 如下面这个 TextRepresentable 协议，任何想要通过文本表示一些内容的类型都可以实现该协议。这些想要表示的内容可以是实例本身的描述，也可以是实例当前状态的文本描述：
protocol TextRepresentable {
    var textualDescription: String {get}
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sides dece"
    }
}
//: 通过扩展遵循并符合协议，和在原始定义中遵循并符合协议的效果完全相同。协议名称写在类型名之后，以冒号隔开，然后在扩展的大括号内实现协议要求的内容。

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)//A 12-sides dece
// 同样，snakesAndLadders 类也可以通过扩展遵循符合 上述协议
extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ledders with \(finalSquare) squares"
    }
}
print(game.textualDescription)//A game of Snakes and Ledders with 25 squares

//: #### 通过扩展遵循协议
//: 若一个类型已经符合了某个协议中的所有要求，却还没有声明遵循该协议时，可以通过空扩展体的扩展来遵循该协议：
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable{}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)//A hamster named Simon
//: ```
//: 注意
//: 即使满足协议的所有要求，类型也不会自动遵循协议，必须显示的遵循协议

//: #### 协议类型的集合
//: 协议类型可以在数组或字典这样的集合中使用，
let things: [TextRepresentable] = [game, d12, simonTheHamster]
// 可遍历 things 数组
for thing in things {
    print(thing.textualDescription)
}
//A game of Snakes and Ledders with 25 squares
//A 12-sides dece
//A hamster named Simon
//: thing 是 TextRepresentable 类型而不是 Dice，DiceGame，Hamster 等类型，即使实例在幕后确实是这些类型中的一种。由于 thing 是 TextRepresentable 类型，任何 TextRepresentable 的实例都有一个 textualDescription 属性，所以在每次循环中可以安全地访问 thing.textualDescription。

//: #### 协议的继承
//: 协议能够继承一个或多个其他协议，可以在继承的协议基础上增加新的要求。协议继承语法与类的继承相似，多个被继承的协议间用逗号分隔：
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // 协议的定义部分
}
// 如下继承自 TextRepresentable 协议
protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String {get}
}
extension SnakesAndLadders : PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ " // 符号表示大于0
            case let snake where snake < 0:
                output += "▼ " // 符号表示小于0
            default:
                output += "○ " // 符号表示等于0
            }
        }
        return output
    }
}
print(game.prettyTextualDescription)
//A game of Snakes and Ledders with 25 squares:
//○ ○ ▲ ○ ○ ▲ ○ ○ ▲ ▲ ○ ○ ○ ▼ ○ ○ ○ ○ ▼ ○ ○ ▼ ○ ▼ ○

//: #### 类类型专属协议
//: 可以在协议的继承列表中，添加 class 关键字 来限制协议只能被 类类型 遵循，而 结构体或枚举 不能遵循该协议。 class 关键字必须第一个出现在协议的继承列表中，在其他继承的协议之前：
//: ```
//: protocol SomeClassOnlyProtocol: class, SomeInhertedProtocol {
//:    // 类类型专属协议的定义部分
//: }

//: 上述中，协议SomeClassOnlyProtocol 只能被类类型遵循。若尝试让结构体或枚举类型遵循该协议，会导致编译错误。
//: ```
//: 注意
//: 当协议定义的要求需要遵循协议的类型必须是引用语义而非值语义时，应该采用类类型专属协议。

//: #### 协议合成
//: 有时需要同时遵循多个协议，你可以将多个协议采用 SomeProtocol & AnotherProtocol 这样的格式进行组合，称为 协议合成（protocol composition）。你可以罗列任意多个你想要遵循的协议，以与符号(&)分隔。
protocol Named{
    var name: String {get}
}
protocol  Aged  {
    var age: Int {get}
}

struct PersonStruce: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)")
}
//: ```
//: wishHappyBirthday(to:) 函数的参数 celebrator 的类型为 Named & Aged。这意味着它不关心参数的具体类型，只要参数符合这两个协议即可。
let birthdayPerson = PersonStruce(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)//Happy birthday, Malcolm, you're 21
// 例子创建了一个名为 birthdayPerson 的 Person 的实例，作为参数传递给了 wishHappyBirthday(to:) 函数。因为 Person 同时符合这两个协议，所以这个参数合法
// 另例
class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City : Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
func  beginConcert(_ location: Location & Named) {
    print("Hello, \(location.name)")
}
// beginConcert(_ :)方法接受一个类型为 Location & Named 的参数，这意味着"任何Location的子类，并且遵循Named协议"
let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(seattle)//Hello, Seattle

// 将 birthdayPerson 传入beginConcert(_ :)函数是不合法的，因为 Person不是一个Location的子类。就像，如果你新建一个类继承与Location，但是没有遵循Named协议，你用这个类的实例去调用beginConcert(in:)函数也是不合法的。

//: #### 检查协议一致性
//: 可以使用类型转换中描述的 is 和 as 操作符来检查协议一致性，即是否符合某协议，并且转换到指定的协议类型。检查和转换到某个协议类型在语法上和类型的检查和转换完全相同：
//: > is 用来检查实例是否符合某个协议，若符合则返回 true，否则返回 false。
//: > as? 返回一个可选值，当实例符合某个协议时，返回类型为协议类型的可选值，否则返回 nil。
//: > as! 将实例强制向下转换到某个协议类型，如果强转失败，会引发运行时错误。

protocol HasArea {
    var area :Double {get}
}

class Circle : HasArea {
    let pi = 3.1415927
    let radius: Double
    var area: Double {return pi * radius * radius}
    init(radius: Double) {
        self.radius = radius
    }
}
class Country : HasArea {
    var area: Double
    init(area: Double) {
        self.area = area
    }
}
// Circle 类把 area 属性实现为基于存储型属性 radius 的计算型属性。Country 类则把 area 属性实现为存储型属性。这两个类都正确地符合了 HasArea 协议。

class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

let objects: [AnyObject] =  [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]
for object  in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    }else{
        print("Something that doesn't have an area")
    }
}
//Area is 12.5663708
//Area is 243610.0
//Something that doesn't have an area
//: objects 数组中的元素的类型并不会因为强转而丢失类型信息，它们仍然是 Circle，Country，Animal 类型。然而，当它们被赋值给 objectWithArea 常量时，只被视为 HasArea 类型，因此只有 area 属性能够被访问。
//: #### 可选的协议要求
//: 协议可以定义 可选要求，遵循协议的类型可以选择是否实现这些要求。在协议中使用 optional 关键字作为前缀来定义可选要求。可选要求用在你需要和 Objective-C 打交道的代码中。协议和可选要求都必须带上 @objc 属性。标记 @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类遵循，其他类及结构体和枚举均不能遵循这种协议。
//: 使用可选要求时，它们的类型会自动变成可选的。如一个类型为 (Int) -> String 的方法会变成 ((Int) -> String)?。需要注意的是整个函数类型是可选的，而不是函数的返回值。
@objc protocol CounterDataSource {
    @objc optional func incrementForCount(count: Int) -> Int
    @objc optional var fixedincrement: Int {get}
}
//: ```
//: 注意
//: 严格来说，counterDataSource 协议中的方法和属性都是可选的，因此遵循协议的类可以不实现这些要求，尽管技术上不允许 这样做，但是最要这样写。

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count: count) {
            count += amount
        }else if let amount = dataSource?.fixedincrement   {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedincrement: Int  = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}
//3
//6
//9
//12

// 更复杂的 数据源
@objc class TowardsZeroSource: NSObject, CounterDataSource {
    func incrementForCount(count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}
// TowardsZeroSource 实现了 CounterDataSource 协议中的 increment(forCount:) 方法，以 count 参数为依据，计算出每次的增量。如果 count 已经为 0，此方法返回 0，以此表明之后不应再有增量操作发生。

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}
//12
//-3
//-2
//-1
//0
//0
//: #### 协议扩展
//: 协议可以通过扩展来为遵循协议的类型提供属性、方法以及下标的实现。这种方式，可以基于协议本身来实现功能，无需在每个遵循协议的类型中重复同样的实现，无需使用全局函数。如下例：
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

// 通过协议扩展，所有遵循协议的类型，都能自动获得这个扩展所增加的方法实现。
let generator2 = LinearCongruentialGenerator()
print("Here's a random number: \(generator2.random())")//Here's a random number: 0.37464991998171
print("And here's a random Boolean: \(generator2.randomBool())")//And here's a random Boolean: true

//: #### 提供默认实现
//: 可以通过扩展协议来为协议要求的属性、方法以及下标提供默认的实现。若遵循协议的类型为这些要求提供给自己实现，这些自定义实现将会代替扩展中的默认实现被使用。
//: ```
//: 注意
//: 通过协议扩展为协议提供额默认实现和可选的协议要求不同。两种情况下，遵循协议的协议都无需自己实现这些要求，但是通过扩展提供的默认实现可以直接调用，无需使用可选链式调用。

// 下例
extension PrettyTextRepresentable {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

//: #### 为协议扩展添加限制条件
//: 扩展协议时，可以指定一些限制条件，只要遵循协议的类型满足这些条件，才能获得协议扩展提供的默认实现。限制条件写在协议名之后，使用 where 子句来描述，如where 所描述的：

extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map{$0.textualDescription}
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}
//: textualDescription 属性返回整个集合文本的文本描述，将集合的每个文本描述以逗号分隔的方式连接起来，包在一对方括号中。

let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]
// Array 符合 CollectionType 协议，而数组中的元素又符合 TextRepresentable 协议，所以数组可以使用 textualDescription 属性得到数组内容的文本表示：
print(hamsters.textualDescription) //[A hamster named Murray, A hamster named Morgan, A hamster named Maurice]
//: ```
//: 注意
//: 若多个协议扩展都为同一个协议要求提供默认实现，而遵循协议的类型又同时满足这些协议扩展的限制条件，那么将会使用限制条件最多的那个协议扩展提供的默认实现。


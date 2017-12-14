//: [方法](@方法)

import Foundation
import UIKit
//: 方法是与某些特定类型相关联的函数。类、结构体、枚举都可以定义实例方法；实例方法为给定类型的实例封装了具体的任务与功能。类、结构体、枚举也可以定义类型方法；类型方法与类型本身相关联。
//: ### 结构体和枚举能够定义方法是 Swift 与 C/Objective-C 的主要区别之一。
//: #### 实例方法（Instance Methods）
//: *实例方法* 是属于某个特定类、结构体或者枚举类型实例的方法。实例方法提供访问和修改实例属性的方法或提供与实例目的相关的功能，并以此来支撑实例的功能。实例方法要写在它所属的类型的前后大括号之间。实例方法能够隐式访问它所属类型的所有的其他实例方法和属性。实例方法只能被它所属的类的某个特定实例调用。
class Counter {
    var count = 0
    func  increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func  reset()  {
        count = 0
    }
}
// 调用
let counter = Counter()
counter.increment()// 1
counter.increment(by: 5)// 6
counter.reset()
//: ### self 
//: 类型的每一个实例都有一个隐含属性叫做self，self完全等同于该实例本身。可以在一个实例的实例方法中使用这个 self 属性来引用当前实例。如： 上例的 increment 可以这样写：
//: ```
//:func increment() {
//:    self.count += 1
//:}

//: 同常不需要在代码中写self。使用这条规则的主要场景是实例方法的某个参数名称与实例的某个属性名称相同的时候。参数名称享有优先权，并且在引用属性时必须使用一种更严格的方式。这时可以使用self属性来区分参数名称和属性名称。
struct Point {
    var  x = 0.0, y  = 0.0
    func  isToTheRightOfX(x:Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(x: 1.0) {
    print("This point is to right of the line where x == 1.0")
}//参数名称享有优先权，并且在引用属性时必须使用一种更严格的方式。这时你可以使用self属性来区分参数名称和属性名称。

//: #### 在实例方法中修改值类型
//: 结构体和枚举是值类型。默认情况，值类型的属性不能在实力方法中修改。如果确实需要在某个方法中修改，为这个方法选择 可变(mutating) 行为。
struct Point1 {
    var  x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var  somePoint1 = Point1(x: 1.0, y: 1.0)
somePoint1.moveByX(deltaX: 2.0, y: 3.0)
print("The point is now at (\(somePoint1.x),\(somePoint1.y))")//The point is now at (3.0,4.0)
//: ```
//: 注意，不能在结构体类型的常量（a constant of structure type）上调用可变方法，因为其属性不能被改变，即使属性是变量属性
let fixPoint = Point1(x: 3.0, y: 3.0)
//fixPoint.moveByX(deltaX: 2.0, y: 3.0)// 报错
//: #### 在可变方法中给 self 赋值
//: 重写上述方法
struct Point2 {
    var  x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        self = Point2(x: x + deltaX, y: y + deltaY)
    }
}
//: 枚举的可变方法可以把self设置为同一类型中的不同成员：
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}

//: #### 类型方法(类方法)
//: 实例方法是被某个类型的实例调用的方法。也可以定义在类型本身上调用的方法，这种方法就叫做类型方法（类方法）。在方法的*func*关键字之前加上关键字 *static*，来指定类型方法。类还可以用关键字 *class* 来允许子类重写父类的方法实现。
//: ```
//:注意
//: 在 Objective-C 中，你只能为 Objective-C 的类类型（classes）定义类型方法（type-level methods）。在 Swift 中，你可以为所有的类、结构体和枚举定义类型方法。每一个类型方法都被它所支持的类型显式包含。
class SomeClass {
    class func someTypeMethod(){
        // 方法的实现
    }
}
SomeClass.someTypeMethod() // 调用
//: 在类型方法的方法体（body）中，self指向这个类型本身，而不是类型的某个实例。这意味着你可以用self来消除类型属性和类型方法参数之间的歧义（类似于我们在前面处理实例属性和实例方法参数时做的那样）。类型方法的方法体中，任何未限定的方法和属性名称，可以被本类中其他的类型方法和类型属性引用。一个类型方法可以直接通过类型方法的名称调用本类中的其它类型方法，而无需在方法名称前面加上类型名称。
struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    static func isUnlocked(_ level: Int)-> Bool {
        return level <= highestUnlockedLevel
    }
    
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}
//: player 类使用 levelTracker 来监测和更新每个玩家的进度
class Player {
    var  tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level+1)
    }
    init(name: String) {
        playerName = name
    }
}
// 调用实例
var player = Player(name: "Argyrios")
player.complete(level: 1)
print( "highest unlock level is now \(LevelTracker.highestUnlockedLevel)")//highest unlock level is now 2
// 创建玩家，尝试一个没有解锁的等级
player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}//level 6 has not yet been unlocked
print(player.tracker.currentLevel)// 当前等级是 1

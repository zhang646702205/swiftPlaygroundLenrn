//: # 控制流[Previous](@previous)

import Foundation
//: ### for-in
// 遍历数组
let names = ["Anna", "Alex", "Brian","Jack"]
for name in names {
    print("hello, \(name)")
}
//: #### 遍历字典
let numberOfLegs = ["spider" : 8,"ant":6,"cat":4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName) have \(legCount) legs")
}
//: ###### 使用 数字范围
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

//: #### While 循环 while循环会一直运行一段语句直到条件变成falseswift 提供两种循环 >while循环，每次循环开始时计算条件是否符合 > repeat-while循环，每次在循环结束时计算条件是否符合
//: #### while 各式如下: (官网的移动🐍的骰子的例子)
//:```
//:while contain {
//:    statements
//:}

//: #### repeat-while (@Note):Swift语言的repeat-while循环和其他语言中的do-while循环是类似的。
//:```
//:repeat {
//:    statements
//:} while contion

//: ### 条件语句 Swift 提供两种类型的条件语句：if语句和switch语句
//: ###### if if 条件为true时，才执行相关代码
var temperatureInFahrenheit = 30
if temperatureInFahrenheit < 32 {
    print("It's very cold,consider wearing a scarf")
}//It's very cold,consider wearing a scarf

//: ###### 包含else 的if 条件句,可以吧多个if连在一起，实现多分支
temperatureInFahrenheit = 40
if temperatureInFahrenheit < 32 {
    print("It's very cold,consider wearing a scarf")
}else {
    print("It's not that cold.Wear a t-shirt")
}//It's not that cold.Wear a t-shirt

temperatureInFahrenheit = 80
if temperatureInFahrenheit <= 32 {
    print("It's very cold,consider wearing a scarf")
}else if temperatureInFahrenheit >= 86 {
    print("It's really warm .Don't forget to wear sunscreen.")
}else {
    print("It's not that cold.Wear a t-shirt")
} //It's not that cold.Wear a t-shirt

//: #### Switch switch语句会尝试把某个值与若干个模式（pattern）进行匹配
//:格式如下：
//:```
//:switch someValue {
//:case value1:
//:    response to value 1
//:case value2:
//:    response to value 2
//:default:
//:   otherwise `do something
//:}
//: 区别：与C和Objective-C 相比较，swift 中的switch 当匹配的 case 分支中的代码执行完毕后，程序会终止，而不会继续执行下一个 case 分支。这也就是说，不需要在 case 分支中显式地使用break语句。注意： 如果想要显式贯穿case分支，请使用fallthrough语句
//: ###### 区间匹配
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let natureCount: String
switch approximateCount {
case 0:
    natureCount = "no"
case 1..<5:
    natureCount = "a few"
case 5..<12:
    natureCount = "several"
case 12..<100:
    natureCount = "dozens of"
case 100..<1000:
    natureCount = "hundreds of"
default:
    natureCount = "many"
}
print("There are \(natureCount) \(countedThings)")

//: ###### 元组 我们可以使用元组在同一个switch语句中测试多个值. 元组中的元素可以是值，也可以是区间。使用下划线（_）来匹配所有可能的值
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}
// 输出 "(1, 1) is inside the box"
//: 值绑定 (value bindings) case 分支允许将匹配的值声明为临时常量或变量，并且在case分支体内使用 —— 这种行为被称为值绑定（value binding），因为匹配的值在case分支体内，与临时的常量或变量绑定.                   请注意，这个switch语句不包含默认分支。这是因为最后一个 case ——case let(x, y)声明了一个可以匹配余下所有值的元组。这使得switch语句已经完备了，因此不需要再书写默认分支

let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}// 输出 "on the x-axis with an x value of 2"

//: ###### where case 分支的模式可以使用where语句来判断额外的条件
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}
// 输出 "(1, -1) is on the line x == -y"
//: ###### 复合匹配 当多个条件可以使用同一种方法来处理时，可以将这几种可能放在同一个case后面，并且用逗号隔开。当case后面的任意一种模式匹配的时候，这条分支就会被匹配。并且，如果匹配列表过长，还可以分行书写

let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
default:
    print("\(someCharacter) is not a vowel or a consonant")
}
// 输出 "e is a vowel"

//: #### 控制转移语句 控制转移语句改变你代码的执行顺序，通过它可以实现代码的跳转。Swift 有五种控制转移语句 
//: >continue
//: >break
//: >fallthrough
//: >return
//: >throw
//: ###### continue continue语句告诉一个循环体立刻停止本次循环，重新开始下次循环,但是并不会离开整个循环体
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
for character in puzzleInput.characters {
    switch character {
    case "a", "e", "i", "o", "u", " ":
        continue
    default:
        puzzleOutput.append(character)
    }
}
print(puzzleOutput)
// 输出 "grtmndsthnklk"

//: #### break
//: break语句会立刻结束整个控制流的执行.

//: #### 循环语句中的break
//: 当在一个循环体中使用break时，会立刻中断该循环体的执行，然后跳转到表示循环体结束的大括号(})后的第一行代码。不会再有本次循环的代码被执行，也不会再有下次的循环产生
//: #### switch 语句中的break
//: 当在一个switch代码块中使用break时，会立即中断该switch代码块的执行，并且跳转到表示switch代码块结束的大括号(})后的第一行代码

let numberSymbol: Character = "三"  // 简体中文里的数字 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not be found for \(numberSymbol).")
}
// 输出 "The integer value of 三 is 3."

//: #### 贯穿  
//:  在 Swift 里，switch语句不会从上一个 case 分支跳转到下一个 case 分支中。相反，只要第一个匹配到的 case 分支完成了它需要执行的语句，整个switch代码块完成了它的执行.如果你确实需要 C 风格的贯穿的特性，你可以在每个需要该特性的 case 分支中使用fallthrough关键字                                                          注意： fallthrough关键字不会检查它下一个将会落入执行的 case 中的匹配条件。fallthrough简单地使代码继续连接到下一个 case 中的代码，这和 C 语言标准中的switch语句特性是一样的。
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)
// 输出 "The number 5 is a prime number, and also an integer."
//: #### 带标签的语句
//:  在 Swift 中，你可以在循环体和条件语句中嵌套循环体和条件语句来创造复杂的控制流结构。并且，循环体和条件语句都可以使用break语句来提前结束整个代码块。因此，显式地指明break语句想要终止的是哪个循环体或者条件语句，会很有用。类似地，如果你有许多嵌套的循环体，显式指明continue语句想要影响哪一个循环体也会非常有用。可以使用标签（statement label）来标记一个循环体或者条件语句，对于一个条件语句，你可以使用break加标签的方式，来结束这个被标记的语句,格式如下:                                                                                   ```                                                                                                 label name: while condition { statements }

//: #### 提前退出
//: if语句一样，guard的执行取决于一个表达式的布尔值,可以使用guard语句来要求条件必须为真时，以执行guard语句后的代码.如果guard语句的条件被满足，则继续执行guard语句大括号后的代码。将变量或者常量的可选绑定作为guard语句的条件，都可以保护guard语句后面的代码。

func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    print("Hello \(name)")
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location).")
}
greet(person: ["name": "John"])
// 输出 "Hello John!"
// 输出 "I hope the weather is nice near you."
greet(person: ["name": "Jane", "location": "Cupertino"])
// 输出 "Hello Jane!"
// 输出 "I hope the weather is nice in Cupertino."
//: #### 检测API可用性
//:  Swift内置支持检查 API 可用性，这可以确保我们不会在当前部署机器上，不小心地使用了不可用的API.格式如下：
//:```
//: if #available(platform name version, ..., *) {
//:     APIs 可用，语句将执行
//: } else {
//:     APIs 不可用，语句将不执行
//: }

if #available(iOS 10, macOS 10.12, *) {
    // 在 iOS 使用 iOS 10 的 API, 在 macOS 使用 macOS 10.12 的 API
} else {
    // 使用先前版本的 iOS 和 macOS 的 API
}
//:  以上可用性条件指定，if语句的代码块仅仅在 iOS 10 或 macOS 10.12 及更高版本才运行。最后一个参数，*，是必须的，用于指定在所有其它平台中，如果版本号高于你的设备指定的最低版本，if语句的代码块将会运行。

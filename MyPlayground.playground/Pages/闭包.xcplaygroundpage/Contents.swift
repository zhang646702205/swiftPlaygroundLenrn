//: [闭包](@闭包)

import Foundation
import UIKit
//: ###### 闭包是自包含的函数代码块，可以在代码中被传递和使用。Swift 中的闭包与 C 和 Objective-C 中的代码块（blocks）以及其他一些编程语言中的匿名函数比较相似。闭包可以捕获和存储其所在上下文中任意常量和变量的引用。被称为包裹常量和变量。
//: ###### 函数章节中介绍的全局和嵌套函数实际上也是特殊的闭包，闭包采取如下三种形式之
//: >全局函数是一个有名字但不会捕获任何值的闭包
//: >嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
//: >闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包
//: ###### Swift 的闭包表达式拥有简洁的风格，并鼓励在常见场景中进行语法优化，主要优化如下：
//: >利用上下文推断参数和返回值类型
//: >隐式返回单表达式闭包，即单表达式闭包可以省略 return 关键字
//: >参数名称缩写
//: >尾随闭包语法

//: #### 闭包表达式
//: 嵌套函数是一个在较复杂函数中方便进行命名和定义自包含代码模块的方式
//: sorted(by:)
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

var reversedNameds = names.sorted(by: backward)

//: #### 闭包 表达式语法
//:```
//:{(paramters) -> returnType in
//:    statements
//:}
// 上述backward 对应的闭包形式
reversedNameds = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
//: 闭包的函数体部分由关键字in引入。该关键字表示闭包的参数和返回值类型定义已经完成，闭包函数体即将开始。
//: #### 根据上下文推断类型
//: 因为排序闭包函数是作为 [sorted(by:)] 方法的参数传入的，Swift 可以推断其参数和返回值的类型。[sorted(by:)] 方法被一个字符串数组调用，因此其参数必须是 (String, String) -> Bool 类型的函数。因此可写为:
reversedNameds = names.sorted(by: { s1, s2  in return s1 > s2 })
//: #### 单表达式闭包隐式返回
//: 单行表达式闭包可以通过省略 return 关键字来隐式返回单行表达式的结果，如上版本的例子:
reversedNameds = names.sorted(by: {s1 , s2 in s1 > s2 })
//: #### 参数名称缩写
//: Swift 自动为内联闭包提供了参数名称缩写功能，你可以直接通过 $0，$1，$2 来顺序调用闭包的参数，以此类推.如果在闭包表达式中使用参数名称缩写，你可以在闭包定义中省略参数列表，并且对应参数名称缩写的类型会通过函数类型进行推断。in关键字也同样可以被省略，因为此时闭包表达式完全由闭包函数体构成：
reversedNameds = names.sorted(by: {$0 > $1})
//: #### 运算符方法
//: 实际上还有一种更简短的方式来编写上面例子中的闭包表达式。Swift 的 String 类型定义了关于大于号（>）的字符串实现，其作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值。
reversedNameds = names.sorted(by: >)

//: 尾随闭包
//: 如果你需要将一个很长的闭包表达式作为最后一个参数传递给函数，可以使用尾随闭包来增强函数的可读性。尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用。在使用尾随闭包时，你不用写出它的参数标签：
func someFunctionThatTakesAClosure(closure: ()-> Void){
    // 函数体部分
}
// 尾随闭包进行函数调用
someFunctionThatTakesAClosure {
    // 闭包主题
}
// 如此 sorted 可写为
reversedNameds = names.sorted(){$0 > $1}
// 尾随闭包好处,闭包非常长以至于不能在一行中进行书写时，尾随闭包变得非常有用
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]
let strings = numbers.map {
    (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
// strings 常量被推断为字符串类型数组，即 [String]
// 其值为 ["OneSix", "FiveEight", "FiveOneZero"]
//: (@注意)
//: 字典 digitNames 下标后跟着一个叹号（!），因为字典下标返回一个可选值（optional value），表明该键不存在时会查找失败。
//: #### 值捕获
//: 闭包可以在其被定义的上下文中捕获常量或变量。即使定义这些常量和变量的原作用域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值。
func makeIncrementer(forIncrement amount: Int) -> ()->Int{
    var  runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer // 返回值为一个函数
}
let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()//10
incrementByTen()// 20
//: (@注意：)
//: 如果你将闭包赋值给一个类实例的属性，并且该闭包通过访问该实例或其成员而捕获了该实例，你将在闭包和该实例间创建一个循环强引用。Swift 使用捕获列表来打破这种循环强引用。

//: #### 闭包是引用类型
//: 函数和闭包都是引用类型
//: #### 逃逸闭包
//: 当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。定义接受闭包作为参数的函数时，你可以在参数名之前标注 [@escaping]，用来指明这个闭包是允许“逃逸”出这个函数的。
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
//: 将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self
func someFunctionWithNonescapingClosure(closure: ()->Void){
    closure()
}
class SomeClass{
    var  x  = 10
    func  doSomething()  {
        someFunctionWithEscapingClosure {
            self.x = 100
        }
        someFunctionWithNonescapingClosure(closure: { 
            x = 200
        })
    }
}
let instance = SomeClass()
instance.doSomething()
print(instance.x) // 200
 completionHandlers.first?()
print(instance.x)// 100
//: #### 自动闭包
//: 自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。自动闭包让你能够延迟求值，因为直到你调用这个闭包，代码段才会被执行。 如下面代码：
var customersInLine = ["Chris", "Alex", "Ewa","Barry","Daniella"]
print(customersInLine.count)// 5 
let customerProvider = {customersInLine.remove(at: 0)} // 延迟执行 customerProvider 的类型是 ()->String 而不是 String
print(customersInLine.count)// 5
print("Now servine \(customerProvider())")

print(customersInLine.count)// 4
//: 将闭包作为参数传递给 函数时，可以获得同样的延时求值的行为
func serve(custom customerPrevider:()-> String){
    print("Now serving \(customerProvider())")
}
serve(custom: {customersInLine.remove(at: 0)})

//: 下面这个版本的 serve(customer:) 完成了相同的操作，不过它并没有接受一个显式的闭包，而是通过将参数标记为 @autoclosure 来接收一个自动闭包。现在你可以将该函数当作接受 String 类型参数（而非闭包）的函数来调用。customerProvider 参数将自动转化为一个闭包，因为该参数被标记了 @autoclosure 特性。
func server(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())")
}
serve(custom: customersInLine.remove(at: 0))// 注意这个调用的方法，不包含 {}


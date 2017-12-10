//: [Previous](@previous)函数

import Foundation
import UIKit

//:[函数](@函数) 函数是一段完成特定任务的独立代码片段。可以通过给函数命名来标识某个函数的功能，这个名字可以被用来在需要的时候"调用"这个函数来完成它的任务。在 Swift 中，每个函数都有一个由函数的参数值类型和返回值类型组成的类型。
//: #### 函数的定义与调用
//: 当你定义一个函数时，你可以定义一个或多个有名字和类型的值，作为函数的输入，称为参数，也可以定义某种类型的值作为函数执行结束时的输出，称为返回类型. 每个函数有个函数名，用来描述函数执行的任务。要使用一个函数时，用函数名来“调用”这个函数，并传给它匹配的输入值（称作 实参 ）。函数的实参必须与函数参数表里参数的顺序一致。
//:所有的这些信息汇总起来成为函数的定义，并以 [func](#func) 作为前缀。指定函数返回类型时，用返回箭头 ->（一个连字符后跟一个右尖括号）后跟返回类型的名称的方式来表示。
func greet(person: String) ->String {
    let greeting = "Hello, " + person + "!"
    return greeting
}
//: 调用一个函数

print(greet(person: "Anna"))//Hello, Anna!
print(greet(person: "Brian"))//
//: 简化返回
func greetAgain(person: String)->String {
    return "Hello, again," + person + "!"
}
print(greetAgain(person:"Anna"))
//: #### 函数参数与返回值
//: 函数参数与返回值在 Swift 中非常的灵活。你可以定义任何类型的函数，包括从只带一个未名参数的简单函数到复杂的带有表达性参数名和不同参数选项的复杂函数。

//:#### 无参数函数
//: 函数可以没有参数。尽管这个函数没有参数，但是定义中在函数名后还是需要一对圆括号。当被调用时，也需要在函数名后写一对圆括号。如下:
func sayHelloWorld()->String {
    return "Hello, world"
}
print(sayHelloWorld())//Hello, world
//: #### 多参数函数
//: 函数可以有多种输入参数，这些参数被包含在函数的括号之中，以逗号分隔。
func greet(person:String, alreadGreated: Bool) -> String {
    if alreadGreated {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}
print(greet(person: "Tim", alreadGreated: true))//Hello, again,Tim!
//: [note](@note)这个函数和上面[greet(person:)](@greet(person:))是不同的。虽然它们都有着同样的名字[greet](@greet)，但是[greet(person:alreadyGreeted:)](@greet(person:alreadyGreeted:))函数需要两个参数，而[greet(person:)](@greet(person:))只需要一个参数。

//:#### 无返回值函数
//:函数可以没有返回值。格式:
func greet1(person: String) {
    print("Hello, \(person)")
}
greet1(person : "Dave")//Hello, Dave
//: 注意
//: 严格上来说，虽然没有返回值被定义，greet(person:) 函数依然返回了值。没有定义返回类型的函数会返回一个特殊的Void值。它其实是一个空的元组（tuple），没有任何元素，可以写成()。
//: 被调用时，一个函数的返回值可以被忽略:
func printAndCount(string: String) -> Int {
    print(string)
    return string.characters.count
}
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")// 打印"hello,world" , 返回值12
//: 注意:
//: 返回值可以被忽略，但定义了有返回值的函数必须返回一个值，如果在函数定义底部没有返回任何值，将导致编译时错误（compile-time error）。
//: #### 多重返回值函数
//: 你可以用元组（tuple）类型让多个值作为一个复合值从函数中返回。
func minMax(array:[Int]) -> (min:Int, max:Int) {
    var  currentMin = array[0]
    var currentMax = array[0]
    for value in array[1...<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
//:[minMax(array:)] 函数返回一个包含两个 Int 值的元组，这些值被标记为 min 和 max ，以便查询函数的返回值时可以通过名字访问它们。
let bounds = minMax(array: [8,-6,109,3,71])
print("min is \(bounds.min) and max is \(bounds.max)")
//: #### 可选元组返回类型


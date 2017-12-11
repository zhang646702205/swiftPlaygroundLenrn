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
    for value in array[1 ..< array.count] {
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
//: 如果函数返回的元组类型有可能整个元组都“没有值”，你可以使用可选的(optional) 元组返回类型反映整个元组可以是nil的事实。你可以通过在元组类型的右括号后放置一个问号来定义一个可选元组，例如 (Int, Int)? 或 (String, Int, Bool)?
//: - @(note)
//: 注意 可选元组类型如 (Int, Int)? 与元组包含可选类型如 (Int?, Int?) 是不同的.可选的元组类型，整个元组是可选的，而不只是元组中的每个元素值。
func minMax1(array: [Int])-> (min: Int, max:Int)? {
    if  array.isEmpty {return nil}
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax{
            currentMax = value
        }
    }
    return (currentMin,currentMax)
}

//: #### 函数参数标签和参数名称
//: 每个函数参数都有一个参数标签( argument label )以及一个参数名称( parameter name )。参数标签在调用函数的时候使用；调用的时候需要将函数的参数标签写在对应的参数前面。参数名称在函数的实现中使用。默认情况下，函数参数使用参数名称来作为它们的参数标签。
//: ```
func someFunction(firstParameterName: Int, secondParameterName: Int) {
 //在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
}
someFunction(firstParameterName: 1, secondParameterName: 2)
//: #### 指定参数标签名
//: 可以在参数名称前指定它的参数标签，中间以空格分隔：
//: ```
//:func someFunction1(argumentLabel parameterName: Int) {
//:    // 在函数体内，parameterName 代表参数
//:}
func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)! Glad you could visit from \(hometown)"
}
print(greet(person: "Bill", from: "Cupertino"))//打印 "Hello Bill!  Glad you could visit from Cupertino."

//: #### 忽略参数标签
//: 如果你不希望为某个参数添加一个标签，可以使用一个下划线(_)来代替一个明确的参数标签。
func someFunction2(_ firstParameterName: Int, secondParameterName: Int) {
    // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
}
someFunction2(1, secondParameterName: 2)
//: #### 默认参数值
//: 你可以在函数体中通过给参数赋值来为任意一个参数定义默认值（Deafult Value）
func someFunction3(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // 如果你在调用时候不传第二个参数，parameterWithDefault 会值为 12 传入到函数体中。
}
someFunction3(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault = 6
someFunction3(parameterWithoutDefault: 4) // parameterWithDefault = 12

//: 将不带有默认值的参数放在函数参数列表的最前。一般来说，没有默认值的参数更加的重要，将不带默认值的参数放在最前保证在函数调用时，非默认参数的顺序是一致的，同时也使得相同的函数在不同情况下调用时显得更为清晰。
//: #### 可变参数
//: 一个可变参数（variadic parameter）可以接受零个或多个值。函数调用时，你可以用可变参数来指定函数参数可以被传入不确定数量的输入值。通过在变量类型名后面加入（...）的方式来定义可变参数。可变参数的传入值在函数体中变为此类型的一个数组。例如，一个叫做 numbers 的 Double... 型可变参数，在函数体内可以当做一个叫 numbers 的 [Double] 型的数组常量。
// 计算任意长度的 算数平均数
func arithmeticMean(_ numbers: Double...)-> Double {
    var  total:Double = 0
    for number in numbers {
        total += number
    }
    return total/Double(numbers.count)
}
arithmeticMean(1,2,3,4,5)//
arithmeticMean(3,8.25,18,75)//
//: (@note) 注意： 一个函数最多只能拥有一个可变参数。
//: #### 输入输出参数
//: 函数参数默认是常量。试图在函数体中更改参数值将会导致编译错误(compile-time error)。这意味着你不能错误地更改参数值。如果你想要一个函数可以修改参数的值，并且想要在这些修改在函数调用结束后仍然存在，那么就应该把这个参数定义为输入输出参数（In-Out Parameters）。
//: 定义一个输入输出参数时，在参数定义前加 inout 关键字。一个输入输出参数有传入函数的值，这个值被函数修改，然后被传出函数，替换原来的值。不能传入常量或者字面量，因为这些量是不能被修改的。当传入的参数作为输入输出参数时，需要在参数名前加 & 符，表示这个值可以被函数修改。
//: (@note) 注意 输入输出参数不能有默认值，而且可变参数不能用 inout 标记。
func swapTwoInts(_ a:inout Int, _ b:inout  Int ){
    let temporaryA = a
        a = b
        b = temporaryA
}
//: (@note) 如果没有 inout 报错 cannot assign to value: 'b' is a 'let' constant，要在函数中修改的变量必须用 var 声明
var someInt = 3
var anotherInt = 107
swap(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")//someInt is now 107, and anotherInt is now 3
//: (@note) 注意： 输入输出参数和返回值是不一样的。上面的 swapTwoInts 函数并没有定义任何返回值，但仍然修改了 someInt 和 anotherInt 的值。输入输出参数是函数对函数体外产生影响的另一种方式。
//: #### 函数类型 
//: 每个函数都有种特定的函数类型，函数的类型由函数的参数类型和返回类型组成。
func addTwoInts(_ a: Int, _ b: Int )-> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int,_ b: Int)-> Int {
    return a * b
}
//: 这个例子中定义了两个简单的数学函数：addTwoInts 和 multiplyTwoInts。这两个函数都接受两个 Int 值， 返回一个 Int 值。

//: 这两个函数的类型是 (Int, Int) -> Int，可以解读为“这个函数类型有两个 Int 型的参数并返回一个 Int 型的值。”。

//: #### 使用函数类型
var mathFunction: (Int, Int) -> Int = addTwoInts//可以定义一个类型为函数的常量或变量，并将适当的函数赋值给它
print("Result: \(mathFunction(2,3))") // print "Result: 5"
//: 有相同匹配类型的不同函数可以被赋值给同一个变量，就像非函数类型的变量一样
mathFunction = multiplyTwoInts(_:_:)
print("Result: \(mathFunction(2,3))") // Result: 6

//: #### 函数类型作为参数类型
//: 可以用 (Int, Int) -> Int 这样的函数类型作为另一个函数的参数类型。这样你可以将函数的一部分实现留给函数的调用者来提供
func printMathResult(_ mathFunction:(Int, Int)-> Int, _ a: Int, _ b : Int ) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts(_:_:), 3, 5)//Result: 8
//: 上述例子中定义了三个参数：第一个参数叫 mathFunction，类型是 (Int, Int) -> Int，你可以传入任何这种类型的函数；第二个和第三个参数叫 a 和 b，它们的类型都是 Int，这两个值作为已给出的函数的输入值。

//: #### 函数类型做为返回类型
//: 可以用函数类型作为另一个函数的返回类型。需要做的是在返回箭头（->）后写一个完整的函数类型。如：
func stepForward(_ input: Int)->Int {
    return input + 1
}
func stepBackward(_ input: Int)->Int {
    return input - 1
}
//: 将上面 [stepForward(_:)] 函数返回一个比输入值大 1 的值。[stepBackward(_:)] 函数返回一个比输入值小 1 的值。下面返回值是 [(Int) -> Int] 类型的函数。
func chooseStepFunction(backward: Bool) -> (Int)->Int {
    return backward ? stepBackward : stepForward
}
var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)//
print("Counting to zero:")
while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = moveNearerToZero(currentValue)
}
print("zero")
//3...
//2...
//1...
//zero

//: #### 嵌套函数
//: 到目前为止本章中你所见到的所有函数都叫全局函数（global functions），它们定义在全局域中。也可以把函数定义在别的函数体中，称作 嵌套函数（nested functions）。
func chooseStepFunction1(backward: Bool) -> (Int) -> Int {
    func stepForward(input : Int) -> Int{return input + 1}
    func stepBackward(input: Int) -> Int {return input - 1}
    return backward ? stepBackward : stepForward
}
 currentValue = 4
let moveNearerToZero1 = chooseStepFunction1(backward: currentValue > 0)
while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = moveNearerToZero1(currentValue)
}
print("zero!")


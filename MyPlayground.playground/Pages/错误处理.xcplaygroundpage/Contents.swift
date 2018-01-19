//: [错误处理](@错误处理)

import Foundation
import UIKit

//: 错误处理 (Error handling) 是响应错误以及从错误中恢复的过程。swift 提供了在运行时对可恢复错误的抛出、捕获、传递和操作的一等支持。
//: swift 中的错误处理涉及到错误处理模式，会用到 Cocoa 和 Objective-C 中的NSError。
//: #### 表示并抛出错误
//: swift 中，错误用符合 Error 协议的类型值来表示。空协议表示该类型可以用于错误处理。
//: swift 中的枚举类型适合构建一组相关的错误状态，枚举的关联值可以提供错误状态的额外信息。如下例：
enum VendingMachineError: Error {
    case invalidSelection // 选择无效
    case insufficientFunds(coinsNeeded: Int) // 金额不足
    case outOfStock // 缺货
}

//: 抛出错误可以表明有意外情况发生，导致正常的执行流程无法继续执行。抛出错误 使用 throw 关键字。如下所示：

//:throw VendingMachineError.insufficientFunds(coinsNeeded:5)
//print("000000")
//: #### 处理错误
//: 某个错误抛出时，附近某部分代码必须负责处理这个错误。
//: swift 中有4种处理错误的方式，可以把函数抛出的错误传递给调用此函数的代码、用 do-catch 语句处理错误、将错误作为可选类型处理、或者断言此错误根本不会发生。
//: 当一个函数抛出一个错误时，程序流程会发生改变，所以要能 迅速识别代码中会抛出错误的地方。为了标识这些地方，在调用一个能抛出错误的函数、方法或者构造器之前，加上 try 关键字，或者 try? 或者 try！这种变体。

//: ```
//: 注意
//: swift 中的错误处理和其他语言中 try ，catch 和 throw 进行异常处理很像，和其他语言 （包括 OC）处理不同的是，swift 中的错误 处理不涉及解除调用栈。 就此而言，throw 语句的性能特性是可以和return 语句相媲美的。

//: #### 用 throwing 函数传递错误
//: 为了表示一个函数、方法或构造器可以抛出错误，在函数声明的参数列表后加上 throws 关键字。一个标有 throws 关键字的函数被 称作 throwing 函数。若该函数指明了返回值类型，throws 关键字要写在箭头 (->) 前面。
//: ```
//: func canThrowErrors() throws -> String
//: func cannotThrowErrors()-> String

//: 一个 throwing 函数可以在器内部抛出错误，并将错误传递到函数被调用时的作用域。

//: ```
//: 注意
//: 只有 throwing 函数可以传递错误。任何在某个 非 throwing 函数内部抛出的错误只能在函数内部处理。

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar" : Item(price: 12, count: 7),
        "Chips" : Item(price: 10, count: 4),
        "Pretzels" : Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    func dispenseSnack(snack: String) {
        print("Dispensing \(snack)")
    }
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        print("Dispensing \(name)")
    }
}
//: 在 vend(itemNamed:) 方法中使用了 guard 语句来提前退出方法，确保购买某个物品所需的条件，有任意条件不满足，提前退出方法并抛出错误。由于throw 语句 会立即退出方法，所以物品只有在满足所有条件时才被售出。
//: 应为该方法会传递出它抛出的任何错误，在调用此方法的地方，必须要么直接处理这些错误-- 使用 do-catch 语句，try? 或 try!; 要么继续将错误传递下去。

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob" : "Licorice",
    "Eve" : "Pretzels"
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
        try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name : String
    init(name: String, vendingMechine: VendingMachine) throws {
        try vendingMechine.vend(itemNamed: name)
        self.name = name
    }
}

//: #### 用 Do-Catch 处理错误
//: 可以使用 do-catch 语句运行一段闭包代码来处理错误。如果在 do 语句中的抛出了一个错误，这个错误会与catch 子句匹配，决定那条子句能处理它。
//: ```
//:   do {
//:       try expression
//:       // statements
//:   }catch pattern 1{
//:       // statements
//:   }catch pattern 2 where condition {
//:       // statements
//:   }

//: 在catch 后面写一个匹配模式来表明子句能处理什么样的错误。如果 一条 catch 语句没有指定匹配模式，这条子句可以匹配任何匹配，并且把错误绑定到一个名字为 error 的局部常量。
//: catch 子句不必将 do 子句中的代码所抛出的每一种可能错误都作处理。如果所有 catch 子句都未处理错误，错误就会传递到周围的作用域。但是，错误还是必须要被某个周围的作用域处理--要么是外围的 do-catch 错误处理语句，要么是一个 throwing 函数的内部。如下例：
print("33333")
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do{
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let conisNeeded) {
    print("Insufficient funds. Please insert an additional \(conisNeeded) coins")
}//Insufficient funds. Please insert an additional 2 coins
print("ssssss")

//: #### 将错误转换成可选值
//: 可以使用 try？ 通过将错误转换成一个可选值来处理错误。在评估 try? 表达式时一个错误被抛出，那么表达式的值就是nil。
//: ```
 func someThrowingFunction() throw -> Int {
    // ...
 }
let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
}catch {
    y = nil
}
//: 如果对所有的错误都采用同样的方式来处理，用 try？ 就可以让你写出简洁的错误处理代码。如下：
//: func fetchData()-> Data?{
//:    if let data = try? fetchDataFromDisk() {
//:        return data
//:    }
//:    if let data = try? fetchDataFromServer() {
//:        return data
//:    }
//:    return nil
//: }

//: #### 禁用错误传递
//: 有时某个 throwing 函数实际上在运行时是不会抛出错误的，这种情况下，可以在表达式前面写try! 来禁用错误传递，这会把调用包装在一个不会有错误抛出的运行时断言。若抛出错误，会得到一个运行时错误。
//: 如下例，加载图片，函数从给定的路径加载图片资源，若图片无法载入则抛出一个错误。因为图片是和应用绑定的，运行时不会有错误抛出，所以禁用错误传递。
//: let photo = try! loadImage(atPath:"./Resource/John Appleseed.jpg")

//: #### 指定清理操作
//: 可以使用 defer 语句在即将离开当前代码块时执行一系列语句。该语句可以执行一些必要的清理工作，不论以何种方式离开当前的代码块--无论是抛出错误而离开，或是由于如 return、break的语句。可以用defer语句来确保文件描述符得以关闭，以及手动分配的内存得以释放。
//: defer 语句将代码的执行延迟到当前的作用域退出之前。该语句又defer关键字和要被延迟执行的语句组成。延迟执行的语句不能包含任何控制转移语句，如break、return语句，或是抛出一个错误。延迟执行的操作会按照声明的顺序从后往前执行--即，第一条defer语句中的代码最后才执行，第二条defer语句中的代码倒数第二执行，以此类推。知道最后一条语句第一个执行

//: func processFile(filename: String) throws{
//:    if exists(filename) {
//:        let file = open(filename)
//:        defer {
//:            close(file )
//:        }
//:        while let line = try file.readline() {
//:            // 处理文件
//:        }
//:        //close(file )// 会在这里被调用，即作用域的最后
//:    }
//: }

//: ```
//: 注意
//: 即使没有涉及到错误处理，你也可以使用defer语句。


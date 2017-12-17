//: [下标](@下标)

import Foundation
import UIKit
//: 下标可以定义在类、结构体和枚举中，是访问集合，列表或序列中元素的快捷方式。可以使用下标的索引，设置和获取值，而不需要再调用对应的存取方法。
//: #### 下标语法
//: 下标允许你通过在实例名称后面的方括号中传入一个或者多个索引值来对实例进行存取。语法类似于实例方法语法和计算型属性语法的混合。定义实例方法类似，定义下标使用 *subscript* 关键字，指定一个或多个输入参数和返回类型；与实例方法不同的是，下标可以设定为读写或只读。
//: ```
//: subscript(index: Int)-> Int {
//:     get {
//:         // 返回一个适当的 int 类型的值
//:    }
//:     set(newValue) {
//:         // 执行适当的赋值操作
//:     }
//: }

struct TimesTable {
    let multiplier : Int
    subscript(index: Int)->Int{
        get {
            return multiplier * index
        }
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")// six times three is 18
//: ````
//: 注意
//: TimesTable例子基于一个固定的数学公式，对 threeTimesTable[someIndex] 进行赋值操作并不合适，因此下标定义为只读的。

//: #### 下标用法
//: 下标的确切含义取决于使用场景。下标通常作为访问集合，列表或序列中元素的快捷方式。可以针对自己的类或结构体功能自由实现最恰当的实现下标。如：swift 中字典的实现：
var numberOfLegs = ["spider":8,"ant": 6, "cat": 4]
numberOfLegs["bird"] = 2
//: ```
//: 注意
//: swift 中字典类型的下标接受并返回可选类型的值。之所以这样设计下标实现，是因为不是每个键都有对应的值，同时也提供了一种通过键删除对应值的方式，只需将对应的值赋值为nil即可。
//: #### 下标选项
//: 下标可以接受任意数量的参数，并且这些入参可以是任意类型。其返回值也可以是任意类型。下标可以使用变量参数和可变参数，但不能使用输入输出参数，也不能设置默认值。 类和结构体可以根据需要提供多个下标实现，使用下标时根据入参的数量和类型进行区分，自动匹配合适的下标，这就是下标的 重载。
struct Matrix {
    let rows: Int, columns : Int
    var grid:[Double]
    init(rows: Int, columns:Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int)-> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * column) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column),"Index out of range")
            grid[(row * column) + column] = newValue
        }
    }
}
var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2
//: 设置值或取值时有断言，用来检查下标的如参row和column的值是否有效。断言在下标越界时触发:
let someValue = matrix[2,2]//断言将会触发，因为 [2, 2] 已经超过了 matrix 的范围




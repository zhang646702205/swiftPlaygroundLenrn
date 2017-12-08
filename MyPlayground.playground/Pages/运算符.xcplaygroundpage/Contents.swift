//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//: 赋值运算符
let b = 10
var a = 5
let (x, y) = (1, 2)
//if a = b { // 报错
//    
//}
//: 算数运算符
1 + 2
let tempStr = "hello, " + "world"
//: 求余运算符
let c1 = -9 % 4
//: 一元负/正 号运算符
let three = 3
let minusThree = -three
//: 组合赋值运算符
var a1 = 1
a1 += 2

//: 比较运算符
1 == 1
2 != 1
2 > 1
1 < 2
1 >= 1
2 <= 1
// 元组比较
(1, "zebra") < (2, "apple")
(3, "apple") < (3, "bird")
//("blue", false) < ("purple", true) // bool 值不能比较


//: 三目运算符
//: 空合运算符 ??
//: 区间运算符
// 闭区间运算符
for index in 1...5 {
    print("\(index) * 5 = \(index * 5)")
}
// 半开区间运算符 a..<b 
// 单侧区间 [2...]
//: 逻辑运算符 操作对象是 逻辑布尔值



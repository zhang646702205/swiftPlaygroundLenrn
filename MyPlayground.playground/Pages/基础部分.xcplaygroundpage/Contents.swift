//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

print(INT8_MAX)
print(INT16_MAX)
uint.min
Int64.max
uint.min
uint.max
UInt32.max
MAXFLOAT
1.25e2
let pad = 1_000_000
//let cannotBeNegative : uint = -1 overflows 
let s = 2e8
let s1 = Int(3.1)
let s2 = Int(3.9)
let s3 = 3 + 0.14
let t = s3 + Double(s2) // 变量相加必须要 显示转换为相同类型
//typealias a = Int
//let b:a = 3
let orangesAreOrange = true
let turnipsAreDelicious = false
if turnipsAreDelicious {
    print("tasty turnips")
} else {
    print("turnips are horrible")
}


let http404Error = (404,"Not Found")
http404Error.0
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")

let convertedNumber = Int("123")
//: 可选绑定
 // 只能在 if 中才能去到值
if let a1 = Int("221a") {
    print("a is \(a1)")
}else {
    print("a =  ")
}

//print(a)

// 错误处理
func canThrowError() throws {
    throw NSError(domain: "ss", code: 11, userInfo: nil)
}
do {
    try canThrowError()
} catch {
//    print(s)
}
//: 断言
let age = 1
assert(age > 0, "aaa")

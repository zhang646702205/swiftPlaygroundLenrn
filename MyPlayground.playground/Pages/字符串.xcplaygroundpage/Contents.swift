//: [Previous](@previous)

import Foundation

var str: String = "Hello, playground"

//: [Next](@next)
//: 字符串 字面量 多行字符串
//let quotation = "the lajsdofadlkfadfjal, asljaflasdfas.quotation.quotationslfkjalsfjkalfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfafd"
var ss = "s"
//print("%p",ss)

ss == "s"
//Array
var a = ["1","2","3","4","5"]
a.contains("1")
a[0] = "9"

print(a)
var b = a
b[1] = "6"
print(b)
print(a)
// : 字符串是值类型
//: 使用字符串
for character in "Dog!🐶".characters {
    print(character)
}

//: 字符串插值 字符串插值是一种构建新字符串的方式，可以在其中包含常量、变量、字面量和表达式。字符串字面量和多行字符串字面量都可以使用字符串插值
let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: Character = "\u{65}\u{301}"

var word = "cafe字符🐶"
word.lengthOfBytes(using: .utf16)
word.lengthOfBytes(using: .utf8)
word.lengthOfBytes(using: .unicode)
(word as NSString).length
word.range(of: "fe")
//print(word.characters.indices)
word.insert("!", at: word.endIndex)
//print(word.substring(with: Range(uncheckedBounds: (lower: 1, upper: 2))))
print("number of characters in \(word) is \(word.characters.count))")
//print("length of \(word) is \(word.length)")

let greeting = "Hello, world"
let index = greeting.characters.index(of: ",")
let beginning = greeting.substring(to: index!)

let start = greeting.index(greeting.startIndex, offsetBy: 1)
let end = greeting.index(greeting.startIndex, offsetBy: 4)
let range = start..<end

let b1 = greeting.substring(with: range)
//: 字符串比较
let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
    print("These two strings are considered equal")
}
//: 前缀／后缀
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]
var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        act1SceneCount += 1
    }
}
print(act1SceneCount)
var mansionCount  = 0
var cellCount = 0

for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell"){
        cellCount += 1
    }
}

print("\(mansionCount) mansion scenes;\(cellCount) cell scenes")




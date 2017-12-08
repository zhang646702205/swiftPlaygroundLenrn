//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var l1 = 3
l1 = 4

let cons : Float = 1
print(cons)
print("i hava \(l1)")
let label = "width is "

let width = label + String(l1)

var shoppingList = ["catfish", "water", "tulips","blue paint"]
var occuprtion = [
    "Malcolm" : "Captain",
    "Kaylee" : "Mechianc",
    "abc" : "ABC"
                ]
print(occuprtion["abc"]!)
print(occuprtion)
for (key, value) in occuprtion {
    print( "\(key) 的值是 \(value)")
}

let individualScores = [75,43,104,87,12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)

var optionalString : String? = "hello"
print(optionalString == nil)
var optionName : String? = nil //"Jhon Appleseed"
var  greeting  = "hello"
if let name = optionName {
    greeting = "hello ,\(name)"
}else {
    print("optionName 为 nil")
}

let nickName: String? = nil
let fullName : String = "Jhon"
let infomalFreeting = "hi \(nickName ?? fullName)"

var n = 2
while n < 100 {
    n *= 2
}
print(n)
var m = 2
repeat {
    m *= 2
}while m<100
print(m)

for i  in 0 ..< 4 {
    print(i)
    
}
print("---")
for i  in 0 ... 4 {
    print(i)
}



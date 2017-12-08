//: [Previous](@previous)

import Foundation

var str = "Hello, playground"


func greet(person: String, day: String) -> String {
    return "Hello \(person) , today is \(day)"
}
print(greet(person: "Bob", day: "Tuesday"))


func greet1(_ person: String, day: String) -> String {
    return "Hello \(person) , today is \(day)"
}
print(greet1("pr", day: "sss"))

func greet2(name person: String, day: String) -> String {
    return "Hello \(person) , today is \(day)"
}
print(greet2(name: "ss", day: "ss"))

func greet(person: String) -> String {
    return "Hello \(person) "
}
print(greet(person: "ss"))

func calculateStatistics(scores: [Int]) -> (min: Int, max: Int , sum: Int){
    var min = scores[0]
    var max = scores[0]
    var  sum = 0
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += sum
    }
    
    return (min, max, sum)
}

let statistics = calculateStatistics(scores: [5,3,100,2,9])
print(statistics)
print(statistics.min)
print(statistics.max)

func sumOf(numbers: Int...) -> Int {
    var  sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
sumOf(numbers: 42, 597, 12)

/// 函数作为返回值
///
/// - Returns: 返回一个函数
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
  return addOne
}
var increment = makeIncrementer()
increment(7)

/// 函数作为参数
///
/// - Parameters:
///   - list: <#list description#>
///   - condition: <#condition description#>
/// - Returns: <#return value description#>
func hasAnyMatches(list: [Int], condition : (Int)-> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}

var numbers = [20, 19 , 7 ,12]
hasAnyMatches(list: numbers, condition: lessThanTen(number:))
numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    return result
})

// 声明 对象和类
class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides"
    }
}
// 创建一个类 的实例
var shape = Shape()
shape.numberOfSides = 7
var shapeDescrpition  = shape.simpleDescription()

// 
class NamedShape {
    var  numberOfSides : Int  = 0
    var  name:String
    init(name: String) {
        self.name = name
    }
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

// 子类
class Square : NamedShape {
    var  sideLength: Double 
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)"
    }
    
}
let test = Square(sideLength: 5.2 , name: "test square")
test.area()
test.simpleDescription()
Bool("1")

var x = 0,y = 0, z = 0
var red, green, blue: Double
var s = "sss" + String(3)
print(("sdfi" + String(3)))

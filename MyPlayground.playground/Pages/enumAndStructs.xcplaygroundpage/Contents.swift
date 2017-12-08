//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

enum Rank: Int {
    case ace = 1
    case two, three, four, five , six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack :
            return "jack"
        case .queen:
            return "queen"
        case .king :
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

let ace = Rank.three
print(ace)
let aceRawValue = ace.rawValue
print(aceRawValue)
enum Suit {
    case spades, hearts, diamonds, clubs
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts :
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
}

let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()


enum ServerResponse {
    case result(String, String)
    case failure(String)
    
    
}

let sucess = ServerResponse.result("6:00 am", "8:08 pm")
let failure = ServerResponse.failure("out of cheese")

switch sucess {
case let .result(sunrise, sunset):
    print("sunrise is at \(sunrise) and sunset is at \(sunset)")
case let .failure(message):
    print("failure...\(message)")
}

//: 与类 有相同的地方 如： 方法和构造器 最大的区别就是结构体是传值 ，类是传引用

struct Card {
    var  rank: Rank
    var suit: Suit
    func  simpleDescription() -> String {
        return "The \(rank.simpleDescription() ) of \(suit.simpleDescription())"
    }
}

let threeOfSpade = Card(rank: .three , suit: .spades)
threeOfSpade.simpleDescription()
//: 协议和扩展
protocol ExampleProtocol {
    var  simpleDescription : String {get}
    mutating func adjust()
}

// 枚举 类 结构体都可以实现协议
class SimpleClass : ExampleProtocol {
    var  simpleDescription: String = "A very simple class"
    var  anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "Now 100% adjust"
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

struct SimpleStructure: ExampleProtocol {
    var  simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += "(adjust)"
    }
    
    
}
var  b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription
// 使用 extension 类为表现的类型添加功能
extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
    
}
print(7.simpleDescription)


//: 泛型
func repeatItem<Item>(repeating item: Item , numberOfTimes: Int )-> [Item]{
    var  result = [Item]()
    for _ in 0 ..< numberOfTimes{
        result.append(item)
    }
    return result
}

let items = repeatElement("knock", count: 4)
print(items[0])
func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
    where T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element {
        for lhsItem in lhs {
            for rhsItem in rhs {
                if lhsItem == rhsItem {
                    return true
                }
            }
        }
        return false
}
anyCommonElements([1, 2, 3], [3])

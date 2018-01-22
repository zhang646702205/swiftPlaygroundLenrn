//: [嵌套类型](@嵌套类型)

import Foundation
import UIKit
//: 枚举常被用于 特定的类或结构体实现某些功能。相似的，枚举可以方便定义工具类或结构体，为某个复杂的类型使用。为了实现这种功能，swift 允许定义嵌套类型，可以在支持的类型定义中嵌套枚举、类和结构体。 要在一个类型中嵌套另外一个类型，嵌套类型的定义写在其外部类型的 {} 内，而且可以定义多级嵌套。
//: #### 嵌套类型 实践
//: 下例中 BlackjackCard 结构体包含两个嵌套定义的枚举类型 Suit 和 Rank

struct BlackjackCard {
    // 嵌套 suit 枚举
    enum Suit : Character {
        case spades = "♠️", hearts = "♥️", diamonds = "♦️", clubs = "♣️"
    }
    
    // 嵌套 Rank 枚举
    enum Rank: Int  {
        case two = 2, three, four, five, six, seven, eight, nine , ten
        case jack, queen , king, ace
        struct Values {
            let  first: Int, second:Int?
        }
        
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack,.queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    // blackjackcard
    let rank: Rank , suit: Suit
    var description: String{ //计算型属性
        var output = "suit is \(suit.rawValue)"
        output += "value is \(rank.values.first)"
        if let second = rank.values.second {
            output += "or \(second)"
        }
        return output
    }
}
//: 上例中, Rank 枚举在内部定义了一个嵌套结构体 Values。结构体 Values 中定义了两个属性，用于反映只有 Ace 有两个数值，其余牌都只有一个数值：
//: > first 的类型为 Int
//: > second 的类型为 Int?，或者说“可选 Int”

let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")//theAceOfSpades: suit is ♠️value is 1or 11

//: #### 引用类型嵌套
//: 外部引用嵌套函数时，在嵌套函数的类型名前加上其外部的类型名作为前缀：
let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
print("\(heartsSymbol)")//♥️


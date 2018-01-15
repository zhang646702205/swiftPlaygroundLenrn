//: [析构过程](@析构过程)

import Foundation
import UIKit
//: 析构器只适用于*类*类型，当一个类的实例被释放之前，析构器会被立即调用。析构器用关键字 *deinit* 来表示，类似于构造器要用init来表示。
//: #### 析构过程原理
//: swift 自动释放不再需要的实例以释放资源。Swift通过 自动引用计数（ARC）处理实例的内存管理。通常当实例被释放时不需要手动的去清理。使用自己的资源时，需要进行一些额外的清理。例如：如果创建了一个自定义的类来打开一个文件，并写入数据，需要在类实例被释放前手动关闭该文件。
//: 在类定义中，没个类最多有一个析构器。且不带任何参数，如下所示：
//: ```
//: dedeinit {
//:     // 执行析构过程
//: }

//: 析构器在实例释放前被自动调用。不能主动调用析构器。子类继承父类的析构器，并在子类析构器实现的最后，父类的析构器会被自动调用。即使子类没有提供自己的析构器，父类的析构器也同样会被调用。
//: 直到实例的析构器被调用后，实例才会被释放。所以析构器可以访问实例的所有属性，并可以根据属性修改它的行为。

//: #### 析构器实践
//: 实例
class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins : Int){
        coinsInBank += coins
    }
}
class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int)  {
        coinsInPurse += Bank.distribute(coins:coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}
var playerOne :Player? = Player(coins: 100)
print("A new player has jioned the game with \(playerOne!.coinsInPurse) coins")//A new player has jioned the game with 100 coins
playerOne?.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")//PlayerOne won 2000 coins & now has 2100 coins
playerOne = nil
print("PlayerOne has left the game")//PlayerOne has left the game

print("The bank now has \(Bank.coinsInBank) coins")//The bank now has 10000 coins
//: 离开游戏了。这通过将可选类型的 playerOne 设置为nil 来表示，意味着 "没有 player实例"。发生时，playerOne 变量对player实例的引用被破坏了，没有其他属性或变量引用player实例，实例会被释放，以便回收内存。在这之前，该实例的析构器被自动调用。


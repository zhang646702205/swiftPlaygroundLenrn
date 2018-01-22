//: [类型转换](@类型转换)

import Foundation
import UIKit
//: 类型转化可以判断一个实例的类型，可以将实例看作是其父类或者子类的实例。
//: 类型转换在 swift 中使用 is 和 as 操作符实现。两个操作符提供一种简单的方式去检查值的类型或者转换它的类型。 可以检查一个类型是否实现了某个协议。
//: #### 定义一个类层次作为例子
//: 可以将类型转换用在类和子类的层次结构上，检查特定的类实例的类型并且转换这个类实例的类型，成为这个层次结构中的其他类型。下例作为类型转换的例子：
class MediaItem {
    var name: String
    init(name : String) {
        self.name = name
    }
}
//: 下面是两个mediaItem 的子类
class Movie : MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song : MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}
//: 最后代码段创建了一个数组常量 library，包含两个 Movie 实例和三个 Song 实例。library 的类型是在它被初始化时根据它数组中所包含的内容推断来的。Swift 的类型检测器能够推断出 Movie 和 Song 有共同的父类 MediaItem，所以它推断出 [MediaItem] 类作为 library 的类型：
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One", artist: "Elvis Presley"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
//: 在幕后 library 里存储的媒体项依然是 Movie 和 Song 类型的。但是，若迭代它，依次取出的实例会是 MediaItem 类型的，而不是 Movie 和 Song 类型。为了让它们作为原本的类型工作，你需要检查它们的类型或者向下转换它们到其它类型，就像下面描述的一样。
//: #### 检查类型
//: 用类型检查 操作符(is ) 来检查实例是否属于特定的子类。若实例属于那个类型，返回true，否则返回 false。
var movieCount = 0
var songCount = 0
for item  in library {
    if item is Movie {
        movieCount += 1
    }else if item is Song {
        songCount += 1
    }
}
print("Media libraty contains \(movieCount) movies and \(songCount ) songs")
//Media libraty contains 2 movies and 3 songs

//: #### 向下转型
//: 某类型的一个常量或变量可能在幕后实际属于一个子类。当确定这种情况时，可以尝试向下转到它的子类行，用类型转换操作符(as? 或 as!).
//: 向下转型可能会失败，类型操作符带有两种形式，条件形式 as？ 返回一个试图向下转型的可选值，强制类型 as! 试图向下转型和强制解包转换结果为一个操作。
//: 当不确定向下转型可以成功时，用类型转换的条件形式（as?）。条件形式的类型转换总是返回一个可选值，并且若下转是不可能的，可选值将是 nil。这使你能够检查向下转型是否成功。

//: 只有可以确定向下转型一定会成功时，才使用强制形式（as!）。当试图向下转型为一个不正确的类型时，强制形式的类型转换会触发一个运行时错误。
for item  in library {
    if  let movie = item as? Movie {
        print("Movie: '\(movie.name)', dir \(movie.director)")
    }else if let song = item as? Song {
        print("Song : '\(song.name)', by \(song.artist)")
    }
}
//Movie: 'Casablanca', dir Michael Curtiz
//Song : 'Blue Suede Shoes', by Elvis Presley
//Movie: 'Citizen Kane', dir Orson Welles
//Song : 'The One', by Elvis Presley
//Song : 'Never Gonna Give You Up', by Rick Astley

//: ```
//: 注意
//: 转换没有真的改变实例或它的值，根本实例保持不变，只是简单的把它作为转换的类型来使用。

//: #### Any 和 AnyObject 的类型转换
//: swift为不确定的类型提供两种特殊的别名：
//: > Any 可以表示任何类型，包括函数类型。
//: > AnyObject 可以表示任何类型的实例。
//: 只有当确实需要它们的行为和功能时才使用 Any 和 AnyObject ，在代码中使用期望的类型总是更好的。如下例：
var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0,5.0))
things.append(Movie(name:"Ghostbusters", director:"Ivan Reitman"))
things.append({(name: String) -> String in "hello,\(name) "})
// things 数组包含两个 Int 值，两个 Double 值，一个 String 值，一个元组 (Double, Double)，一个Movie实例"Ghostbusters"，以及一个接受 String 值并返回另一个 String 值的闭包表达式。
for thing  in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as an Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y ) point at \(x),\(y)")
    case let movie as Movie:
        print("a movie called '\(movie.name)', dir: \(movie.director)")
    case let stringConverter as (String) -> String: // 注意这里闭包的判断
        print(stringConverter("Michael"))
    default:
//        print( thing is (String) -> String)
            print("something else")
    }
}
//zero as an Int
//zero as an Double
//an integer value of 42
//a positive double value of 3.14159
//a string value of "hello"
//an (x, y ) point at 3.0,5.0
//a movie called 'Ghostbusters', dir: Ivan Reitman
//hello,Michael

//: ```
//: 注意
//: Any 类型可以表示所有类型的值，包括可选类型，Swift 会在用 Any 类型来表示一个可选值的时候，给一个警告，若确实想使用Any 类型来承载可选值，可以 使用 as 操作符显示转换 为Any，如下：
//: let optionalNumber: Int? = 3
//: things.append(optionalNumber) // 警告
//: things.appendappend(optionalNumber as Any) // 没有警告


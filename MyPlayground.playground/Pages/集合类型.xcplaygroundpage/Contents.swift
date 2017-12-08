//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//: 集合的可变性 常见可变性和不可变性
//: 数组 有序列表的集合， 存储同一类型，值可重复
// 创建一个 空数组
var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) items")
 someInts.append(3)
var threeDouble = Array(repeating: 0.0, count: 3)
// 两个数组相加
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
var sixDoubles = threeDouble + anotherThreeDoubles
// 数组字面量构造数组  数组字面量是一系列由逗号分割并由方括号包含的数值 [value1,value2]
var shoppingList:[String] = ["Eggs","Milk"]
//:访问和修改数组
print("The shopping list contains \(shoppingList.count) items.") // count 属性
if shoppingList.isEmpty { // isEmpty 属性
    print("shopping list is empty.")
} else {
    print("shopping list is not empty")
}
//: append 或者用 += 也可以在数组后面添加一个或多个相同类型的数据
shoppingList.append("Flour")
shoppingList += ["Baking Powder"]
var firstItem = shoppingList[0]
// 用下表来改变某个已有值的数据值 下标来一次改变一系列数据值，即使新数据和原有数据的数量是不一样的
shoppingList[0] = "Six eggs"
//insert 
shoppingList.insert("Maple Syrup", at: 0)
// remove 
let mapleSyrup = shoppingList.remove(at: 0)
//: note 除了当count等于 0 时（说明这是个空数组），最大索引值一直是 count - 1，因为数组都是零起索引。
//:我们只想把数组中的最后一项移除，可以使用removeLast()方法而不是remove(at:)方法来避免我们需要获取数组的count属性
shoppingList.removeLast()
//:: 数组的遍历， 如果需要每个数据项的值和索引值，可以使用enumerated()方法来进行数组遍历。enumerated()返回一个由每一个数据项索引值和数据值组成的元组
for item in shoppingList {
    print(item)
}

for (index , value ) in shoppingList.enumerated() {
    print("Item \(String(index+1)): \(value)")
}

//:: sets 集合(Set)用来存储相同类型并且没有确定顺序的值。当集合元素顺序不重要时或者希望确保每个元素只出现一次时可以使用集合而不是数组
//:  集合类型的哈希值 一个类型为了存储在集合中，该类型必须是可哈希化的--也就是说，该类型必须提供一个方法来计算它的哈希值
//: 集合类型语法 Set 类型被写为 Set<Element>
// 空集合
var letters = Set<Character>()
letters.insert("a")
print(letters)
// 用数组字面量创建集合
var favoriteGenres : Set<String> = ["Rock", "Classical", "Hip hop"]
//: 访问和修改集合 可以通过Set的属性和方法来访问和修改一个Set
//count 属性
print("i have \(favoriteGenres.count) favorite music genres")
// isEmpty 
if favoriteGenres.isEmpty {
    print("favoriteGenres is empty")
}else {
    print("favoriteGenres is not empty")
}
//insert
favoriteGenres.insert("Jazz")
//remove 
if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre) ? i'm over it")
} else {
    print("I never much cared for that")
}
//contains 检查是否包含一个特定值
if favoriteGenres.contains("Funk") {
    print("i get up on the good foot")
}else {
    print("It's too funky in here")
}
// 遍历一个集合
for genre in favoriteGenres {
    print(genre)
}
//:: 集合操作
/**基本集合操作:
  *使用intersection(_:)方法根据两个集合中都包含的值创建的一个新的集合。
  *使用symmetricDifference(_:)方法根据在一个集合中但不在两个集合中的值创建一个新的集合。
  *使用union(_:)方法根据两个集合的值创建一个新的集合。
  *使用subtracting(_:)方法根据不在该集合中的值创建一个新的集合。*/
let oddDigist : Set = [1,3,5,7,9]
let evenDigist : Set = [0,2,4,6,8]
let singleDigitPrimeNumbers: Set = [2,3,5,7]
oddDigist.union(evenDigist).sorted()
oddDigist.intersection(evenDigist).sorted()
oddDigist.subtracting(singleDigitPrimeNumbers).sorted()
oddDigist.symmetricDifference(singleDigitPrimeNumbers).sorted()
/**
 * 集合成员关系和相等
 * 使用“是否相等”运算符(==)来判断两个集合是否包含全部相同的值。
 * 使用isSubset(of:)方法来判断一个集合中的值是否也被包含在另外一个集合中。
 * 使用isSuperset(of:)方法来判断一个集合中包含另一个集合中所有的值。
 * 使用isStrictSubset(of:)或者isStrictSuperset(of:)方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。
 * 使用isDisjoint(with:)方法来判断两个集合是否不含有相同的值(是否没有交集)。
 */

let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]
houseAnimals.isSubset(of: farmAnimals)
// true
farmAnimals.isSuperset(of: houseAnimals)
// true
farmAnimals.isDisjoint(with: cityAnimals)
// true

//:: 字典 字典是一种存储多个相同类型的值的容器
// 字典类型简化语法 Swift 的字典使用Dictionary<Key, Value>定义，其中Key是字典中键的数据类型，Value是字典中对应于这些键所存储值的数据类型
// 创建一个空字典
var namesOfIntergers = [Int: String]()
namesOfIntergers[16] = "sixteen"
// 用字典字面量创建字典
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]


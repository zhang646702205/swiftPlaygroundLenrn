//: [泛型](@泛型)

import Foundation
import UIKit
//: 泛型代码 可以是你能够根据自定义的需求，编写出适用于任意类型、灵活可重用的函数及类型。能避免代码重用，用一种清晰和抽象的方式来表达代码的意图。
//: 泛型是 swift 最强大的特性之一，许多 swift 标准库都是泛型代码创建的。如：swift 的array 和 Dictionary 都是泛型。可以创建一个 Int数组，也可创建 String 数组，或者可以是任意其他 swift 类型数组。也可以创建存储任意指定类型的字典。

//: #### 泛型所解决的问题
//: 下例是一个标准的非泛型函数，用来交换 两个Int 的值：
func swapTwoInts(_ a: inout Int , _ b : inout Int){
    let temporatyA = a
    a = b
    b = temporatyA
}
//: 这个函数使用输入输出参数(inout) 来交换a 和 b的值。如下交换两个Int 的值：

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")//someInt is now 107, and anotherInt is now 3
//: swapTwoInt 函数有用，但是它只能交换Int 的值，如果想交换两个 String 或者 Double ，就需要写更多函数，如：
func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporary = a
    a = b
    b = temporary
}

func swapTwoDouble(_ a: inout Double, _ b : inout Double) {
    let temporary = a
    a = b
    b = temporary
}
//: 至此，可以看出三个函数功能都相同，唯一不同的是传入的变量类型不同，分别是 Int 、 String 和 Double. 实际应用中，通常需要一个更实用更灵活的函数来交换两个任意类型的值，幸运的是，泛型代码帮你解决了这种问题。

//: ```
//: 注意
//: 上述三个函数中，a 和 b 类型必须相同。若不同则不能互换。Swift 是类型安全的语言，不允许一个String 类型变量和一个 Double 类型变量互换值。试图这样做会导致变异错误。

//: #### 泛型函数
//: 泛型函数可以适用于任何类型。
func swapTwoValues<T>(_ a: inout T, _ b : inout T){
    let temporaty = a
    a = b
    b = temporaty
}
//: 与 swapTwoInts 相比，只有第一行不同。
//: 该函数的泛型版本使用了占位类型名(T)来代替实际类型名(如 Int，String 或 Double)。占位类型没有指明T必须是什么类型，但是指明 a 和 b 必须是同一个类型 T， 无论T 代表什么类型。只有函数调用时，才会根据所传入的实际类型决定T代表的类型。
//: 泛型函数和非泛型函数的另个不同之处，在于泛型函数名 后面跟着占位类型名(T),并且尖括号括起来(<T>).该尖括号告诉 swift 那个T是swapTwoValues 函数定义内的一个占位类型名，因此swift 不会去查找名为 T 的实际类型。
//: swapTwoValues(_:_:) 函数现在可以像 swapTwoInts(_:_:) 那样调用，不同的是它能接受两个任意类型的值，条件是这两个值有着相同的类型。
 someInt = 3
 anotherInt = 107
swapTwoValues(&someInt, &anotherInt)

print("someInt = \(someInt), anotherInt = \(anotherInt)")//someInt = 107, anotherInt = 3

var  someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
print("someString = \(someString), anotherString = \(anotherString)")//someString = world, anotherString = hello

//: ```
//: 注意
//: 上述swapTwoValues(_:_:) 函数是等候 swap(_:_:)函数启发而实现的。后者是swift 标准库，可以在程序中使用它。

//: #### 类型参数
//: 上面 swapTwoValues(_:_:) 函数中，占位类型T 是类型参数的一个例子。类型参数指定并命名一个占位类型。并紧随在函数名后面，使用一对尖括号括起来(<T>).
//: 若一个类型参数被指定，可以用它来定义一个函数的参数类型(ru swapTwoValues )函数中的参数a 和 b ，或者作为函数的返回类型，也可以作为函数主体中的注释类型。这些情况下，类型参数会在函数调用时被实际类型所替代。(在上面的 swapTwoValues(_:_:) 例子中，当函数第一次被调用时，T 被 Int 替换，第二次调用时，被 String 替换。)
//: 可以提供多个类型参数，都写在尖括号中，用逗号分开。

//: #### 命名类型参数
//: 多数情况下，类型参数具有一个描述性名字。如：Dictionary<key, value> 中的 key 和 value ，以及 Array<Element> 中的Element。可以告诉阅读代码的人这些类型参数和泛型函数之间的关系。之间没有有意义的关系时，通常使用 单个字母来命名 如T， U, V 和swapTwoValues 中的T 一样。

//: ```
//: 注意
//: 请始终使用大写字母开头的驼峰命名法(如 T 和 MyTypeParameter) 来为类型参数命名，已表明它们是占位类型，而不是一个值。

//: #### 泛型类型
//: 除了泛型函数，swift 允许定义泛型类型。自定义类、结构体和枚举可以适用于任何类型，类似 Array 和 Dictionary。
//: 该部分内容将展示如何编写一个名为 Stack （栈）的泛型集合类型。栈是一系列值的有序集合，和 Array 类似，但它相比 Swift 的 Array 类型有更多的操作限制。 数组允许在任意位置插入新元素或是删除其中任意位置的元素。而站只允许在集合的末端添加新元素(入栈)。类似，也只能从末端一处元素(出栈)。
//: ```
//: 注意
//: 栈的概念已被UINavigationController 类用来构造视图控制器的导航结构。通过调用 UINavigationController 的pushViewController(_: animated:) 方法来添加新的视图控制器到导航栈。通过 popViewControllerAnimated(_:) 方法从导航栈中移除视图控制器。当需要一个严格的"后进先出"方式来管理集合，栈是 最实用的模型。
//: 编写一个非泛型版本的栈：
struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int){
        items.append(item)
    }
    mutating func pop() -> Int{
        return items.removeLast()
    }
}

//: 结构体在栈中使用一个名为 items 的 Array 属性来存储值。Stack 提供了两个方法：push(_:) 和 pop()，用来向栈中压入值以及从栈中移除值。这些方法被标记为 mutating，因为它们需要修改结构体的 items 数组。
//: 上面的 IntStack 结构体只能用于 Int 类型。不过，可以定义一个泛型 Stack 结构体，从而能够处理任意类型的值。

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element){
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
// 注意，Stack 基本上和 IntStack 相同，只是用占位类型参数 Element 代替了实际的 Int 类型。这个类型参数包裹在紧随结构体名的一对尖括号里（<Element>）。

//: Element 为待提供的类型定义了一个占位名。这种待提供的类型可以在结构体的定义中通过 Element 来引用。在这个例子中，Element 在如下三个地方被用作占位符：

//: > 创建 items 属性，使用 Element 类型的空数组对其进行初始化。
//: > 指定 push(_:) 方法的唯一参数 item 的类型必须是 Element 类型。
//: > 指定 pop() 方法的返回值类型必须是 Element 类型。
// 例子
var  stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// 到此 stackOfStrings 中有4 个元素
let fromTheTop = stackOfStrings.pop()// 值为 cuatro

//: #### 扩展一个泛型类型
//: 扩展一个泛型的时候，不需要在扩展的定义中提供类型的参数列表。原始类型定义中声明的类型参数列表在扩展中可以直接使用，且来自原始类型中的参数名称会被用做原始定义总的类型参数的引用。

// 例子扩展了泛型类型 Stack，为其添加了一个名为 topItem 的只读计算型属性，它将会返回当前栈顶端的元素而不会将其从栈中移除：
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}//topItem 属性会返回一个 Element 类型的可选值。当栈为空的时候，topItem 会返回 nil；当栈不为空的时候，topItem 会返回 items 数组中的最后一个元素。

//: ```
//: 注意，这个扩展并没有定义一个类型参数列表。相反的，Stack 类型已有的类型参数名称 Element，被用在扩展中来表示计算型属性 topItem 的可选类型。
// 只访问任意 stack 实例顶端
if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem)")
}//The top item on the stack is tres

//: #### 类型约束
//: swapTwoValues(_:_:) 函数和Stack 类型可以作用于任何类型。有时如果能将使用在泛型函数和泛型类型中的类型添加一个特定的类型约束，是很有用的。类型约束可以指定一个类型参数必须继承自指定类，或者符合一个特定的协议或协议组合。
//: 例如，Swift 的 Dictionary 类型对字典的键的类型做了些限制。在字典的描述中，字典的键的类型必须是可哈希（hashable）的. 也就是说，必须有一种方法能够唯一地表示它。Dictionary 的键之所以要是可哈希的，是为了便于检查字典是否已经包含某个特定键的值。若没有这个要求，Dictionary 将无法判断是否可以插入或者替换某个指定键的值，也不能查找到已经存储在字典中的指定键的值。

//: #### 类型约束的语法
//: 在一个类型参数 名后面放置一个类名或者协议名，并用冒号进行分隔，来定义类型约束，将成为类型参数列表的一部分，
//: ```
//: func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U){
//:    // 泛型函数的函数题部分
//: }

//: 上面函数有两个类型参数，第一个类型是 T， 要求是 T 必须是 SomeClass 子类的类型约束；第二个类型是 U，要求 U 必须符合 SomeProtocol 协议的类型约束。

//: #### 类型约束实践
//: 这有个 名为 findIndex(ofString:in:) 的泛型函，该函数的功能实在一个 String 数组中查找给定 String 的索引。
func findIndex(ofString valueToFind: String, in array :[String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat","dog","llama","parakeet","terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")//The index of llama is 2
}
//: 若只能查字符串的索引，用处不大。下面是 findIndex 函数的泛型版本。注意，这个函数返回值的类型仍然是 Int? .因为函数返回的是个可选索引值，不是从数组中得到的可选值。 注意：该函数无法通过编译，原因后面说明。
//func findIndex<T>(of valueToFind: T , in array: [T]) -> Int? {
//    for (index, value) in array.enumerated() {
//        if value == valueToFind {
//            return index
//        }
//    }
//    return nil
//}
// 上面所写的函数无法通过编译 问题出在相等性检查上，即 "if value == valueToFind"。不是所有的 Swift 类型都可以用等式符（==）进行比较,部分代码无法保证适用于每个可能的类型 T，当你试图编译这部分代码时会出现相应的错误。不过，所有的这些并不会让我们无从下手。Swift 标准库中定义了一个 Equatable 协议，该协议要求任何遵循该协议的类型必须实现等式符（==）及不等符(!=)，从而能对该类型的任意两个值进行比较。

func findIndex<T: Equatable>(of valueToFind: T, in array: [T])-> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
//:findIndex(of:in:) 唯一的类型参数写做 T: Equatable，也就意味着“任何符合 Equatable 协议的类型 T ”。findIndex(of:in:) 函数现在可以成功编译了，并且可以作用于任何符合 Equatable 的类型，如 Double 或 String：
let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])// nil
let stringIndex = findIndex(of: "Andrea", in: ["Mike","Malcolm","Andrea"])//2

//: #### 关联类型
//: 定义协议时，有时声明一个或多个关联类型作为协定定义的一部分将会很有用。 关联类型为 协议中的某个类型提供一个占位名(或者说别名), 代表的实际类型在协议被采纳时才会被指定。通过 associatedtype 关键字指定关联类型。

//: #### 关联类型实践
//: 例子,该协议定义一个 关联类型 ItemType
protocol Container {
    associatedtype ItemType
    mutating func append(_ item : ItemType)
    var count: Int {get}
    subscript(i: Int)-> ItemType {get}
    
}
//: Container 协议定义了三个任何采纳该协议的类型必须提供的功能：
//: > 必须通过 append(_:) 方法添加新元素到容器中；
//: > 必须通过 count 属性获取容器中元素的数量；
//: > 必须可以通过索引值类型为 Int 的下标检索到容器中的每一个元素。

//: 该协议没有指定容器中元素该如何存储，以及元素必须是何种类型。这个协议只指定了三个任何遵从 Container 协议的类型必须提供的功能。遵从协议的类型在满足这三个条件的情况下也可以提供其他额外的功能。任何遵从 Container 协议的类型必须能够指定其存储的元素的类型，必须保证只有正确类型的元素可以加进容器中，必须明确通过其下标返回的元素的类型。

//: 这个协议无法定义 ItemType 是什么类型的别名，这个信息将留给遵从协议的类型来提供。尽管如此，ItemType 别名提供了一种方式来引用 Container 中元素的类型，并将之用于 append(_:) 方法和下标，从而保证任何 Container 的行为都能够正如预期地被执行。

struct IntStack1: Container {
    // IntStack 的原始实现部分
    var items = [Int]()
    mutating func push(_ item: Int){
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // Container 协议的实现部分
    typealias ItemType = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int{
        return items[i]
    }
}

//: IntStack 结构体实现了 Container 协议的三个要求，其原有功能也不会和这些要求相冲突。IntStack 在实现 Container 的要求时，指定 ItemType 为 Int 类型，即 typealias ItemType = Int，从而将 Container 协议中抽象的 ItemType 类型转换为具体的 Int 类型。
//: 由于 Swift 的类型推断，你实际上不用在 IntStack 的定义中声明 ItemType 为 Int。因为 IntStack 符合 Container 协议的所有要求，Swift 只需通过 append(_:) 方法的 item 参数类型和下标返回值的类型，就可以推断出 ItemType 的具体类型。事实上，如果你在上面的代码中删除了 typealias ItemType = Int 这一行，一切仍旧可以正常工作，因为 Swift 清楚地知道 ItemType 应该是哪种类型。

// 泛型 stack 结构体 遵从 Container 协议
struct Stack1<Element> : Container {
    // Stack<Element> 原始实现部分
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // container 协议实现部分
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

//: #### 通过扩展一个存在的类型来指定关联类型
//: Swift 的Array 类型已经提供 append(_:) 方法，一个 count 属性，以及一个接受Int 类型索引值的下标用以检索器元素。三个功能都符合 Container 协议的要求，意味着只需简单的声明 Array 采纳协议就可以扩展Array， 使其遵从 Container 协议。可以通过空扩展来实现。
extension Array : Container, Container1{}

//: #### 约束关联类型
//: 可以给协议里的 关联类型加类型注释，让遵守协议的类型必须遵循这个条件约束。如下例所示：
protocol Container1 {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int {get}
    subscript(i: Int) -> Item{get}
    
}
// 遵守了 Container 协议，Item 类型也必须遵守 Equatable 协议。

//: #### 泛型 where 语句
//: 类型约束能让你 为 泛型函数，下标，类型的类型参数定义一些强制要起。
//: 关联类型定义约束 也非常有用。可以在参数列表中通过 where 为关联类型定义约束。通过 where 子句要求一个关联类型遵从某个特定的协议，以及某个特定的类型参数和关联类型必须类型相同。通过将 where 关键字紧跟在类型参数列表后面来定义 where 子句，where 子句后跟一个或者多个针对关联类型的约束，以及一个或多个类型参数和关联类型间的相等关系。你可以在函数体或者类型的大括号之前添加 where 子句。

//: 下面的例子定义了一个名为 allItemsMatch 的泛型函数，用来检查两个 Container 实例是否包含相同顺序的相同元素。如果所有的元素能够匹配，那么返回 true，否则返回 false。

func allItemMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2)-> Bool where C1.ItemType == C2.ItemType , C1.ItemType: Equatable{
    // 检查两个容器 还有相同的元素个数
    if someContainer.count != anotherContainer.count {
        return false
    }
    // 检查每一对元素是否相等
    for i  in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    // 所有元素匹配
    return true
}
// allItemsMatch 的使用
var stackOfStrngs = Stack1<String>()
stackOfStrngs.push("uno")
stackOfStrngs.push("dos")
stackOfStrngs.push("tres")

var  arrayOfStrings = ["uno","dos","tres"]

if allItemMatch(stackOfStrngs, arrayOfStrings) {
    print("all items match.")
} else {
    print("Not all item match.")
}//all items match.

//: 例子创建了一个 Stack 实例来存储一些 String 值，然后将三个字符串压入栈中。这个例子还通过数组字面量创建了一个 Array 实例，数组中包含同栈中一样的三个字符串。即使栈和数组是不同的类型，但它们都遵从 Container 协议，而且它们都包含相同类型的值。因此你可以用这两个容器作为参数来调用 allItemsMatch(_:_:) 函数。在上面的例子中，allItemsMatch(_:_:) 函数正确地显示了这两个容器中的所有元素都是相互匹配的。

//: #### 具有泛型 where 子句的扩展
//: 可以使用泛型 where 子句作为扩展的一部分。基于以前的例子，下例展示扩展 泛型 Stack 结构体，添加istop 方法

extension Stack where Element: Equatable {
    func isTop(_ item: Element ) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

//: 新的 isTop(_:) 方法首先检查这个栈是不是空的，然后比较给定的元素与栈顶部的元素。如果你尝试不用泛型 where 子句，会有一个问题：在 isTop(_:) 里面使用了 == 运算符，但是 Stack 的定义没有要求它的元素是符合 Equatable 协议的，所以使用 == 运算符导致编译时错误。使用泛型 where 子句可以为扩展添加新的条件，因此只有当栈中的元素符合 Equatable 协议时，扩展才会添加 isTop(_:) 方法。

if stackOfStrings.isTop("tres") {
    print("Top element is tres")
} else {
    print("Top element is somegthing else")
}
//Top element is tres

//: 尝试在元素不符合 Equatable 协议栈上调用 isTop 方法，收到编译错误：
struct NotEquatable{}
var notEquatableStack = Stack<NotEquatable>()

let notEquatableValue = NotEquatable()
notEquatableStack.push(notEquatableValue)
//notEquatableStack.isTop() // 报错 not comfirm to protocol equatable

//: 可以 使用 泛型where 去扩展一个 协议，如：
extension Container1 where Item: Equatable {
    func  startsWith(_ item : Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}
//: 这个 startsWith(_:) 方法首先确保容器至少有一个元素，然后检查容器中的第一个元素是否与给定的元素相等。任何符合 Container 协议的类型都可以使用这个新的 startsWith(_:) 方法，包括上面使用的栈和数组，只要容器的元素是符合 Equatable 协议的

if  [9, 9, 9].startsWith(42){
    print("Starts with 42")
}else {
    print("Start with something else")
}

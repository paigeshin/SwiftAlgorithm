# Complexity

### Constant Time Complexity

Constant time complexity describes an operation that takes the same amount of time to complete regardless of the input size

```swift
func checkFirst(names: [String]) {
    if let first = names.first {
        print(first)
    } else {
        print("no names")
    }
}
```

### Linear Time Complexity

Linear time complexity is when the time taken for an operation increases proportionally with the number of items in the input, such as iterating through an array to print each element.

```swift
func printNames(names: [String]) {
    for name in names {
        print(name)
    }
}
```

### Quadratic Time

Quadratic time complexity occurs when an operation involves nested iterations over the input data, such as a loop within a loop, resulting in the time taken to complete the operation being proportional to the square of the number of items in the input. This means that even a small

```swift
func printNames(names: [String]) {
    for _ in names {
        for name in names {
            print(name)
        }
    }
}
```

### Lograithmic Time

Logarithmic time complexity, exemplified by the binary search algorithm, describes a situation where the time to complete a task increases logarithmically relative to the size of the input data. This means that as the input data grows larger, the time to search or process it doesn't grow linearly but instead slows down, increasing at a decreasing rate, making it efficient for large datasets.

### Quasilinear Time

- Swift `sort()` function uses it

The `sort` function mentioned might indeed have a complexity that is worse than pure linear (as in simple iteration from start to end) but better than quadratic (as in nested loops). Algorithms with this complexity often involve a combination of linear operations and another operation that increases more slowly than linear, such as logarithmic, resulting in a total complexity that is often expressed as O(n log n), where 'n' is the number of items in the input. The graph for this complexity would start off growing relatively quickly but then start to flatten out as the data size increases, indicating that the time cost grows slower than it would for a quadratic complexity.

---

# Linked List

```swift
import Cocoa

// Linked List
// First Node(Head) pointing to the next node
// The last Node(Tail) pointing to nothing

struct LinkedList<Value> {

    var head: Node<Value>?
    var tail: Node<Value>?

    var isEmpty: Bool {
        return self.head == nil
    }

    init() {}

    func node(at index: Int) -> Node<Value>? {
        var currentIndex = 0
        var currentNode = self.head
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
    }

    // `insert` method, add a new element in between nodes
    func insert(_ value: Value, after node: Node<Value>) {
        node.next = Node(value: value, next: node.next)
    }

    // `push` Method replaces head by adding a new element
    mutating func push(_ value: Value) {
        self.head = Node(value: value, next: self.head)
        if self.tail == nil {
            self.tail = self.head
        }
    }

    // `append` Method replaces tail by adding a new element
    mutating func append(_ value: Value) {
        guard !self.isEmpty else {
            self.push(value)
            return
        }
        let node = Node(value: value, next: nil)
        self.tail!.next = node
        self.tail = node
    }

    // `pop`: Remove Head
    mutating func pop() -> Value? {
        defer {
            self.head = self.head?.next
            if self.isEmpty {
                self.tail = nil
            }
        }
        return self.head?.value
    }

    // `removeLast`: Remove Tail
    mutating func removeLast() -> Value? {
        guard let head = self.head else {
            return nil
        }
        guard head.next != nil else {
            return self.pop()
        }

        var prev = head
        var current = head
        while let next = current.next {
            prev = current
            current = next
        }

        prev.next = nil
        self.tail = prev
        return current.value
    }

    mutating func remove(after node: Node<Value>) -> Value? {
        defer {
            if node.next === self.tail { // check if it is the same instance
                self.tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }


}

extension LinkedList: CustomStringConvertible {
    var description: String {
        guard let head = self.head else { return "Empty List" }
        return String(describing: head)
    }
}

final class Node<Value> {

    var value: Value
    var next: Node? // because tail does not point anything, it can be nullable

    init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }

}

extension Node: CustomStringConvertible {
    var description: String {
        guard let next = self.next else {
            return "\(self.value)"
        }
        return "\(self.value) -> " + String(describing: next)
    }
}

var list = LinkedList<Int>()

list.append(10)
list.append(3)
list.append(12)
list.append(100)

print(list)

let index = 1
let node = list.node(at: index - 1)!
let removedValue = list.remove(after: node)

print(list)

```

---

# Stack

LIFO: Last In First Out

The stack is a fundamental data structure that mimics real-life stacks, such as piles of books or pancakes. It operates on the Last In, First Out (LIFO) principle, meaning the last item added is the first to be removed. Below is a Python version of the Swift code provided, demonstrating a simple stack implementation.

```swift
import UIKit

// Stack
// Last In First Out, LIFO
// Imagine Stack of Books, Stack of Pancakes

struct Stack<Element> {

    private var storage: [Element] = []

    init() {}

    mutating func push(_ element: Element) {
        self.storage.append(element)
    }

    mutating func pop() -> Element? {
        return self.storage.popLast()
    }

}

extension Stack: CustomStringConvertible {

    var description: String {
        let topDivider = "-----top-----\n"
        let bottomDivider = "\n----------"
        let stackElements = self.storage.map { "\($0)" }.reversed().joined(separator: "\n")
        return topDivider + stackElements + bottomDivider
    }

}

var stack = Stack<Int>()
stack.push(20)
stack.push(10)
stack.push(5)
print(stack)
stack.pop()
print(stack)

```

---

# Queue

FIFO: First In, First Out

```swift
import UIKit

struct Queue<T> {

    var array: [T] = []

    init() {}

    var isEmpty: Bool {
        return self.array.isEmpty
    }

    // Check the first item
    var peek: T? {
        return self.array.first
    }

    mutating func enqueue(_ element: T) -> Bool {
        self.array.append(element)
        return true
    }

    mutating func dequeue() -> T? {
        return self.isEmpty ? nil : self.array.removeFirst()
    }

}

extension Queue: CustomStringConvertible {

    var description: String {
        return String(describing: self.array)
    }

}


var queue = Queue<Int>()
queue.enqueue(10)
queue.enqueue(20)
queue.enqueue(30)
print(queue)
queue.dequeue()
print(queue)
```

---

# Recursion

The process in which a function calls itself directly or indirectly is called `Recursion`

- Base Case: This case ends the recursion
- Recursive Case: This case calls the function recursively

```swift
// Infinitely Called
func increment(index: Int) {
    increment(index: index)
}
increment(index: 0)
```

```swift
func increment(index: Int) {
    var counter = index
    counter += 1
    if counter < 10 {
        return increment(index: counter) // Recursive Case
    } else {
        return counter
    }
}
```

```swift
func factorial(number: Int) -> Int {
    if number == 0 {
        return 1
    }
    return number * factorial(number: number - 1)
}

```

---

# Trees

This lecture series covers the tree data structure, highlighting its significance in representing hierarchical data, managing sorted data efficiently, and enabling fast data lookups. The structure of a tree is explained through nodes, with a focus on the root node (the topmost node without a parent), internal nodes (nodes with at least one child), and leaf nodes (nodes without children).

The implementation begins with defining a tree node in Swift, utilizing generics to allow flexibility in the data type stored. Children of a node are managed using an array, and a method to add child nodes is provided.

The lectures then delve into two tree traversal methods: depth-first and level-order. Depth-first traversal accesses nodes from the root down to the deepest leaf before backtracking, while level-order traversal accesses nodes level by level from the root.

The implementation uses Swift's extensions and generics, and includes a search function leveraging the traversal methods to locate a specific value within the tree.

Below is a simplified and more concise version of the tree and queue structures, along with depth-first and level-order traversals, and the search function in Python, which is inherently more succinct:

```python
class TreeNode:
    def __init__(self, value):
        self.value = value
        self.children = []

    def add_child(self, child):
        self.children.append(child)

    def depth_first_traversal(self, action):
        action(self.value)
        for child in self.children:
            child.depth_first_traversal(action)

    def level_order_traversal(self, action):
        queue = [self]
        while queue:
            current_node = queue.pop(0)
            action(current_node.value)
            queue.extend(current_node.children)

    def search(self, value):
        def visit(node):
            if node.value == value:
                nonlocal result
                result = node
        result = None
        self.level_order_traversal(visit)
        return result


# Example usage:
root = TreeNode("Beverages")

hot = TreeNode("Hot")
cold = TreeNode("Cold")

root.add_child(hot)
root.add_child(cold)

hot.add_child(TreeNode("Tea"))
hot.add_child(TreeNode("Coffee"))

cold.add_child(TreeNode("Soda"))
cold.add_child(TreeNode("Milk"))

# Depth First Search
print("Depth First Search:")
root.depth_first_traversal(print)

# Level Order Search
print("\nLevel Order Search:")
root.level_order_traversal(print)

# Search
search_result = root.search("Soda")
print("\nSearch for 'Soda':", search_result.value if search_result else "Not found")

```

```swift
import UIKit

struct Queue<Element> {

    var elements: [Element] = []

    var isEmpty: Bool { self.elements.isEmpty }

    @discardableResult
    mutating func enqueue(_ value: Element) -> Bool {
        self.elements.append(value)
        return true
    }

    @discardableResult
    mutating func deqeue() -> Element? {
        return self.isEmpty ? nil : self.elements.removeFirst()
    }

}

final class TreeNode<T: Equatable> {
    // Root Node
    // Leaf

    var value: T
    var children: [TreeNode] = []

    init(_ value: T) {
        self.value = value
    }

    func add(_ child: TreeNode) {
        self.children.append(child)
    }

}

extension TreeNode {

    // Depth First Traversal - Traversal Algorithm
    func forEachDepthFirst(_ visit: (TreeNode) -> Void) {
        visit(self)
        self.children.forEach { node in
            node.forEachDepthFirst(visit)
        }
    }

    // Level Order Traversal - Traversal Algorithm
    func forEachLevelOrder(_ visit: (TreeNode) -> Void) {
        visit(self)
        var queue = Queue<TreeNode>()
        self.children.forEach {
            queue.enqueue($0)
        }
        while let node = queue.deqeue() {
            visit(node)
            node.children.forEach { queue.enqueue($0) }
        }
    }

    func search(_ value: T) -> TreeNode? {

        var result: TreeNode?

        self.forEachLevelOrder { node in
            if node.value == value {
                result = node
            }
        }

        return result
    }

}

// Root Node
let beverages = TreeNode<String>("Beverages")

let hot = TreeNode<String>("Hot")
let cold = TreeNode<String>("Cold")

let tea = TreeNode("Tea")
let coffee = TreeNode("Coffee")
hot.add(tea)
hot.add(coffee)

let soda = TreeNode("Soda")
let milk = TreeNode("Milk")

cold.add(soda)
cold.add(milk)

beverages.add(hot)
beverages.add(cold)

// Depth First
print("Depth First Search")
beverages.forEachDepthFirst { print($0.value) }

// Level Order
print("Lever Order Search")
beverages.forEachLevelOrder { print($0.value) }

// Search
print("Search")
let result = beverages.search("Soda")
print(String(describing: result?.value))


```

This Python code snippet provides the same functionality described in the Swift lectures but in a more compact form. The TreeNode class represents a node in the tree, with the ability to add children and perform traversals. The example usage at the end demonstrates creating a simple tree, performing both depth-first and level-order traversals, and searching for a specific value within the tree.

**Depth-First Traversal:**
This method involves exploring as far as possible along each branch before backtracking. It's like walking through a maze and taking each path to its end before trying a different path. In a tree, you start from the root and explore each subtree as deeply as you can before moving to the next subtree.

**Level-Order Traversal:**
Also known as Breadth-First Traversal, this method involves visiting all the nodes at the present depth before moving on to the nodes at the next depth level. It's similar to how you might line up to get into a movie; everyone on the same level (or row) must go first before the next row starts moving. In a tree, you start at the root and move across the tree horizontally, visiting all the nodes at one level before going down to the next level.

---

# Binary Tree

- Binary Tree
  - Every node contains `at most` two childs
  - Left Child, Right Child

Sure, let's break down binary trees and the traversal methods into a visual and simple explanation:

**Binary Trees:**
Imagine a family tree but with a rule: each person can have no more than two children. This is what a binary tree is like. Each spot in the family tree is called a "node," and the top-most node (like the great-grandparent of the family) is called the "root." Every node in this tree can have zero, one, or two "children" (nodes directly connected to it). When a node has no children, it's like an only child in the family and is called a "leaf."

**Depth-First Traversals:**
There are three main ways to walk through this family tree, visiting everyone in a specific order:

1. **In-Order Traversal:**

   - Visit the left child (like saying hi to the younger sibling first).
   - Visit the node itself (like saying hi to yourself in the mirror).
   - Visit the right child (then hi to the older sibling).

2. **Pre-Order Traversal:**

   - Say hi to yourself first.
   - Then visit the left child (younger sibling).
   - And finally, visit the right child (older sibling).

3. **Post-Order Traversal:**
   - Start with the left child (younger sibling).
   - Then the right child (older sibling).
   - And say hi to yourself last.

**Level-Order Traversal:**
This is like taking a family photo. You get everyone on the same generation to stand in a line. First, you'd take a picture of the great-grandparent alone. Next, their children, and so on, until you reach the youngest generation. This way, you capture everyone level by level.

Let's visualize these concepts with a simple binary tree where the root node is `7`, and it has two children `1` and `9`. The `1` node has two children `0` and `5`, and the `9` node has a single child `8`.

```
    7
   / \
  1   9
 / \   \
0   5   8
```

**In-Order Traversal:** We visit `0`, then `1`, then `5` (all on the left), come back up to `7` (the root), and then visit `9` and `8` on the right. So the order is `0, 1, 5, 7, 9, 8`.

**Pre-Order Traversal:** Start at `7`, then go down to `1`, then `0`, back up to `1`, then `5`, and then over to `9` and down to `8`. So the order is `7, 1, 0, 5, 9, 8`.

**Post-Order Traversal:** Visit `0` and `5` (children of `1`), then `1` itself, then `8` (child of `9`), then `9`, and finally `7`. So the order is `0, 5, 1, 8, 9, 7`.

**Level-Order Traversal:** We visit `7`, then `1` and `9` (next level), and finally `0`, `5`, and `8` (last level). So the order is `7, 1, 9, 0, 5, 8`.

Each traversal method has its own use-cases depending on what you need to achieve with the binary tree, like searching, sorting, or just organizing data.

```swift
import UIKit

class BinaryNode<Element> {

    var value :Element
    var leftChild :BinaryNode?
    var rightChild :BinaryNode?

    init(_ value :Element) {
        self.value = value
    }

}

extension BinaryNode {



    // In Order Traversal
    /*
       10
     /    \
     9     2
    / \     / \
    1  3   4  6

     Print:
     1 9 3 10 4 2 6

     */
    func traverseInOrder(visit :(Element) -> Void) {
        self.leftChild?.traverseInOrder(visit: visit)
        visit(value)
        self.rightChild?.traverseInOrder(visit: visit)
    }

    // Post Order Traversal
    /*
       10
     /    \
     9     2
    / \     / \
    1  3   4  6

     Print:
     1 3 9 4 6 2 10

     */
    func traversePostOrder(visit :(Element) -> Void) {

        self.leftChild?.traversePostOrder(visit: visit)
        self.rightChild?.traversePostOrder(visit: visit)
        visit(value)

    }

    // Pre Order Traversal
    /*
       10
     /    \
     9     2
    / \     / \
    1  3   4  6

     Print:
     10 9 1 3 2 4 6

     */
    func traversePreOrder(visit: (Element) -> Void) {
        visit(value)
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
    }

}




let ten = BinaryNode(10)
let nine = BinaryNode(9)
let two = BinaryNode(2)
let one = BinaryNode(1)
let three = BinaryNode(3)
let four = BinaryNode(4)
let six = BinaryNode(6)

ten.leftChild = nine
ten.rightChild = two
nine.leftChild = one
nine.rightChild = three
two.leftChild = four
two.rightChild = six

// Traverse In Order
ten.traverseInOrder {
    print($0)
}

// Traverse Post Order
ten.traversePostOrder {
    print($0)
}

// Traverse In Pre Order
ten.traversePreOrder {
    print($0)
}

```

---

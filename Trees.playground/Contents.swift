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

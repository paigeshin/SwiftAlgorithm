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

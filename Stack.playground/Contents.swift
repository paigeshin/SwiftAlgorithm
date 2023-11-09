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

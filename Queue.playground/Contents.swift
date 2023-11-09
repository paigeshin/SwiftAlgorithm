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


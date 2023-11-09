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

import UIKit

func power(number: Int, n: Int) -> Int {
    
    // base case
    if n == 0 {
        return 1
    } else {
        return number * power(number: number, n: n - 1)
    }
}

let mypower = power(number: 2, n: 3)
print(mypower)

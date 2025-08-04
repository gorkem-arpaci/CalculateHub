//
//  Calculate.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 5.08.2025.
//


import Foundation


protocol Stackable {
    associatedtype Element
    func peek() -> Element?
    mutating func push(_ element: Element)
    @discardableResult mutating func pop() -> Element?
}

extension Stackable {
    var isEmpty: Bool { peek() == nil }
}


struct Stack<Element>: Stackable where Element: Equatable {
    private var storage = [Element]()
    func peek() -> Element? { storage.last }
    mutating func push(_ element: Element) { storage.append(element)  }
    mutating func pop() -> Element? { storage.popLast() }
}

extension Stack: Equatable {
    static func == (lhs: Stack<Element>, rhs: Stack<Element>) -> Bool { lhs.storage == rhs.storage }
}

extension Stack: CustomStringConvertible {
    var description: String { "\(storage)" }
}
    
extension Stack: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Self.Element...) { storage = elements }
}

class InfixToPostfix {
    private var operatorStack = Stack<String>()
    
    private func precedence(_ op: String) -> Int {
        switch op {
        case "+", "-": return 1
        case "*", "/", "%": return 2
        case "^": return 3
        default: return 0
        }
    }
    
    private func isRightAssociative(_ op: String) -> Bool {
          return op == ""
      }
    
    func converter(_ infix: String) -> String {
        operatorStack = Stack<String>()
        var postfix = [String]()
        
        let tokens = infix.components(separatedBy: " ")
        
        for token in tokens {
            if Double(token) != nil {
                postfix.append(token)
            }
            
            else {
                while let top = operatorStack.peek(),
                      (precedence(top) > precedence(token) ||
                       (precedence(top) == precedence(token) && !isRightAssociative(token))) {
                    postfix.append(operatorStack.pop()!)
                }
                operatorStack.push(token)
            }
        }
        
        while !operatorStack.isEmpty {
            postfix.append(operatorStack.pop()!)
        }
        
        let result = postfix.joined(separator: " ")
        return result
    }
    
    func calculatePostfix(_ postfix: String) -> Double {
        var stack = Stack<Double>()
        
        let tokens = postfix.components(separatedBy: " ")
        
        for token in tokens {
            if Double(token) != nil {
                stack.push(Double(token)!)
            }
            
            else {
                let right = stack.pop()!
                let left = stack.pop()!
                
                switch token {
                case "+":
                    stack.push(left + right)
                case "-":
                    stack.push(left - right)
                case "*":
                    stack.push(left * right)
                case "/":
                    stack.push(left / right)
                case "%":
                    if right == 0 {
                        fatalError("Cannot divide by zero")
                    }
                    stack.push(left.truncatingRemainder(dividingBy: right))
                default:
                    break
                }
                
            }
        }
        let result = stack.pop()!
        
        return result
        
    }
}




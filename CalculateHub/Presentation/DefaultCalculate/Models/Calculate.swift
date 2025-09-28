//
//  Calculate.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 5.08.2025.
//


import Foundation

enum Token {
    case number(Double)
    case op(Character)
    case leftParen
    case rightParen
}

func tokenize(_ expr: String) -> [Token] {
    var tokens: [Token] = []
    var numberBuffer = ""
    
    for char in expr.replacingOccurrences(of: " ", with: "") {
        if char.isNumber || char == "." {
            numberBuffer.append(char)
        } else {
            if !numberBuffer.isEmpty {
                tokens.append(.number(Double(numberBuffer)!))
                numberBuffer = ""
            }
            
            switch char {
            case "+", "-", "*", "/":
                tokens.append(.op(char))
            case "(":
                tokens.append(.leftParen)
            case ")":
                tokens.append(.rightParen)
            default:
                break
            }
        }
    }
    if !numberBuffer.isEmpty {
        tokens.append(.number(Double(numberBuffer)!))
    }
    return tokens
}

func precedence(_ op: Character) -> Int {
    switch op {
    case "+", "-": return 1
    case "*", "/": return 2
    default: return 0
    }
}

func applyOp(_ a: Double, _ b: Double, _ op: Character) -> Double {
    switch op {
    case "+": return a + b
    case "-": return a - b
    case "*": return a * b
    case "/": return a / b
    default: fatalError("Geçersiz operator")
    }
}

func evaluate(_ expr: String) -> Double {
    let tokens = tokenize(expr)
    var values: [Double] = []
    var ops: [Character] = []
    
    for token in tokens {
        switch token {
        case .number(let num):
            values.append(num)
        case .leftParen:
            ops.append("(")
        case .rightParen:
            while let op = ops.last, op != "(" {
                _ = ops.popLast()
                let b = values.popLast()!
                let a = values.popLast()!
                values.append(applyOp(a, b, op))
            }
            _ = ops.popLast() // "(" kaldır
        case .op(let op):
            while let last = ops.last, last != "(", precedence(last) >= precedence(op) {
                _ = ops.popLast()
                let b = values.popLast()!
                let a = values.popLast()!
                values.append(applyOp(a, b, last))
            }
            ops.append(op)
        }
    }
    
    while let op = ops.popLast() {
        let b = values.popLast()!
        let a = values.popLast()!
        values.append(applyOp(a, b, op))
    }
    
    return values[0]
}


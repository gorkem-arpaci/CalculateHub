//
//  FormulaType.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 25.08.2025.
//

import Foundation

enum FormulaType: String, CaseIterable {
    case bisection = "bisection"
    case conjugate = "conjugate"
    case gradientDescent = "gradient-descent"
    case newtonRaphson = "newton-raphson"
    case safeGuarded = "safe-guarded"
    case secant = "secant"
    case toBinary = "to-binary"
    
    var title: String {
        switch self {
        case .bisection: "Bisection"
        case .conjugate: "Conjugate"
        case .gradientDescent: "Gradient-Descent"
        case .newtonRaphson: "Newton-Raphson"
        case .safeGuarded: "Safe-Guarded"
        case .secant: "Secant"
        case .toBinary: "To Binary"
        }
    }
    
    var endpoint: String {
        return "http://127.0.0.1:5000/" + rawValue
    }
}




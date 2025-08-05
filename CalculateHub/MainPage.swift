//
//  SwiftUIView.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 2.08.2025.
//

import SwiftUI



var toInfix = InfixToPostfix()
let symbols: [String] = ["+", "-", "x", "÷", "%"]

struct MainPageView: View {
    @State private var result = "0"
    @State private var operation : String = ""
    
    @EnvironmentObject var themeManager : ThemeManager

    var body: some View {
        VStack(alignment: .trailing) {
            
            VStack(alignment: .trailing) {
                Text(operation)
                    .foregroundStyle(.gray.opacity(0.8))
                    .font(Font.custom("WorkSans-Light", size: 32))
                
                Text(String(result))
                    .foregroundStyle(.primary)
                    .font(Font.custom("WorkSans-Light", size: 84))
            }
            
            
            HStack {
                ButtonLayout(title:"C", background: Color.gray, result: $result, operation: $operation)
                
                Button(action: {
                    
                }){
                    Image(systemName: "plus.forwardslash.minus")
                        .font(Font.custom("WorkSans-Regular", size: 28))
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .frame(width: 78, height: 78)
                }
                .background(Color.gray, in:RoundedRectangle(cornerRadius: 24))
                .padding([.leading, .bottom, .trailing], 7)
                
                ButtonLayout(title: "%", background: Color.gray, result: $result, operation: $operation)
                ButtonLayout(title: "÷", background: Color.indigo, result: $result, operation: $operation)
            }
            HStack {
                ButtonLayout(title: "7", background: Color(UIColor.systemGray4), result: $result, operation: $operation)
                ButtonLayout(title: "8", background: Color(UIColor.systemGray4), result: $result, operation: $operation)
                ButtonLayout(title: "9", background: Color(UIColor.systemGray4), result: $result, operation: $operation)
                ButtonLayout(title: "x", background: Color.indigo, result: $result, operation: $operation)
            }
            HStack {
                ButtonLayout(title: "4", background: Color(UIColor.systemGray4), result: $result, operation: $operation)
                ButtonLayout(title: "5", background: Color(UIColor.systemGray4), result: $result, operation: $operation)
                ButtonLayout(title: "6", background: Color(UIColor.systemGray4), result: $result, operation: $operation)
                ButtonLayout(title: "-", background: Color.indigo, result: $result, operation: $operation)
            }
            HStack {
                ButtonLayout(title: "1", background: Color(UIColor.systemGray4), result: $result, operation: $operation)
                ButtonLayout(title: "2", background: Color(UIColor.systemGray4), result: $result, operation: $operation)
                ButtonLayout(title: "3", background: Color(UIColor.systemGray4), result: $result, operation: $operation)
                ButtonLayout(title: "+", background: Color.indigo, result: $result, operation: $operation)
            }
            HStack {
                ButtonLayout(title: ".", background: Color(UIColor.systemGray4), result: $result, operation: $operation)
                ButtonLayout(title: "0", background: Color(UIColor.systemGray4), result: $result, operation: $operation)
                
                Button(action: {self.result.removeLast()}){
                    Image(systemName: "delete.left")
                        .foregroundStyle(.primary)
                        .frame(width: 78, height: 78)
                        .fontWeight(.medium)
                        .font(Font.custom("WorkSans-Regular", size: 28))
                }
                .background(Color(UIColor.systemGray4), in:RoundedRectangle(cornerRadius: 24))
                .padding([.leading, .bottom, .trailing], 7)
                
                ButtonLayout(title: "=", background: Color.indigo, result: $result, operation: $operation)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .padding(.bottom, 25)
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)

    }
}

#Preview {
    MainPageView()
        .environmentObject(ThemeManager())
}

struct ButtonLayout : View {
    
    let title : String
    let background : Color
    @Binding var result : String
    @Binding var operation : String
    
    
    var body: some View {
        
        Button(action: {
            addParameter(value: title)
        }){
            Text(title)
                .font(Font.custom("WorkSans-Regular", size: 32))
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .frame(width: 78, height: 78)
        }
        .background(background, in:RoundedRectangle(cornerRadius: 24))
        .padding([.leading, .bottom, .trailing], 7)
        
    }
    

    
    func addParameter(value: String) {
        let operators: [String] = ["+", "-", "x", "÷", "%", "."]

        
        switch value {
        case "C":
            result = "0"
            
        case "=":
            let post = toInfix.converter(separateString(result))
            let calculation = toInfix.calculatePostfix(post)
            operation = result
            result = calculation.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(calculation)) : String(Float(calculation))
            
        case "0" where result == "0":
            return
            
        case let op where operators.contains(op):
            // Operator işlemi
            guard !result.isEmpty && result != "0" else { return }
            
            // Son karakter de operator ise değiştir
            if let lastChar = result.last, operators.contains(String(lastChar)) {
                result.removeLast()
            }
            result.append(op)
            
        default:
            // Sayı işlemi
            if result == "0" {
                result = value
            } else {
                result.append(value)
            }
        }
    }
    
    func separateString(_ input: String) -> String {
        var result : String = ""
        var num : String = ""
        
        for char in input {
            if !symbols.contains(String(char)) {
                num.append(char)
            }
            else {
                if !num.isEmpty {
                    result += num + " "
                    num = ""
                }
                result += String(char) + " "
            }
        }
        
        if !num.isEmpty {
             result += num
        }
        
        return result.trimmingCharacters(in: .whitespaces)
    }
}

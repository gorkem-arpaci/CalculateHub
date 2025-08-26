//
//  Deneme.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 14.08.2025.
//

//Bisection = a,b,iterasyon sayısı ve fonksiyon (a -> alt sınır, b -> üst sınır) 3 textField
//Conjugate = func, nums (nums -> [a,b] şeklinde dizi) 1 textField
//Gradient Descent = x0, fonksiyon ve alpha değeri (x0 -> 1. iterasyon değeri) 2 textField
//Newton Raphson = x0, fonksiyon (x0 -> 1. iterasyon değeri) 1 textField
//Safe Guarded = x0, fonksiyon ?a,b? 1veya3 textField
//Secant = x0, x1, fonksiyon (x0 -> 1. iterasyon 1. değeri, x1 -> 1. iterasyon 2. değeri) 2 textField
//toBinary = hexNum

import SwiftUI

struct FunctionDetail: View {
    @EnvironmentObject var themeManager : ThemeManager
    @StateObject var viewModel = NewtonRaphsonViewModel()
    @State private var mainLabel : String = ""
    @State private var resultLabel : String = ""
    @Binding var path: [String]
    
//    variables
    @State private var x0 : String = ""
    @State private var x1 : String = ""
    @State private var aText : String = ""
    @State private var bText : String = ""
    @State private var iterasyonText : String = ""
    @State private var alpha : String = ""
    @State private var hexNum : String = ""
    @State private var nums : String = ""
    
    
    var body: some View {
        
        VStack(alignment: .trailing) {
            VStack(alignment: .trailing) {
                
                TextField("Fonksiyon giriniz", text: $resultLabel)
                    .multilineTextAlignment(.trailing)
                    .foregroundStyle(.primary)
                    .font(Font.custom("WorkSans-Light", size: 32))
                    .textInputAutocapitalization(.never)
                
                
                Text(String(mainLabel))
                    
                    .foregroundStyle(.primary)
                    .font(Font.custom("WorkSans-Light", size: 64))
            }
            .padding(10)
            
            HStack {
                switch $path.last?.wrappedValue {
                case "Bisection":
                    VStack{
                        TextFieldView(text: $aText, placeholder: "Başlangıç değeri girin")
                        TextFieldView(text: $bText, placeholder: "Bitiş değeri girin")
                        
                    }
                case "Conjugate":
                        TextFieldView(text: $nums, placeholder: "1-1 matris giriniz")
                case "Gradient-Descent":
                    VStack {
                        TextFieldView(text: $x0, placeholder: "Başlangıç değeri girin")
                        TextFieldView(text: $alpha, placeholder: "Alpha değeri girin")
                    }
                case "Newton-Raphson":
                    TextFieldView(text: $x0, placeholder: "Başlangıç değeri girin")
                case "Safe-Guarded":
                    TextFieldView(text: $x0, placeholder: "Başlangıç değeri girin")
                case "Secant":
                    VStack {
                        TextFieldView(text: $x0, placeholder: "1. İterasyon 1. Değer")
                        TextFieldView(text: $x1, placeholder: "1. İterasyon 2. Değer")
                    }
                case "ToBinary":
                    TextFieldView(text: $hexNum, placeholder: "Hexadecimal sayı girin")
                default:
                    Text("")
                }
            }
            
            
            
        }
        Button(action: {
            Task {
                guard let selected = path.last else { return }
                
                switch selected {
                case "Newton-Raphson":
                    await viewModel.calculateNewtonRaphson(x_0: x0, func_input: resultLabel)
                case "Gradient-Descent":
                    await viewModel.calculateGradientDescent(x_0: x0, func_input: resultLabel, alpha: alpha)
                case "Safe-Guarded":
                    await viewModel.calculateSafeGuarded(x_0: x0, func_input: resultLabel)
                case "Conjugate":
                    await viewModel.calculateConjugate(func_input: resultLabel, nums: nums)
                case "Bisection":
                    await viewModel.calculateBisection(a: aText, b: bText, func_input: resultLabel)
                case "Secant":
                    await viewModel.calculateSecant(x_0: x0, x_1: x1, func_input: resultLabel)
                default:
                    break
                }

                
                   mainLabel = viewModel.x
            }
        
        }) {
            Text("Solve")
                .foregroundColor(.primary)
                
        }
        .frame(width: 250, height: 70)
        .background(.indigo, in: RoundedRectangle(cornerRadius: 20))
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)

    }
}

struct TextFieldView: View {
    @Binding var text: String
    var placeholder: String = ""
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.secondarySystemBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
            .font(.system(size: 16, weight: .regular, design: .rounded))
            .foregroundColor(.primary)
            .frame(maxWidth: 340)
            .padding(.horizontal)
            .textInputAutocapitalization(.never)
        }
}

//#Preview {
//    @State var list = [""]
//    FunctionDetail(path: $list)
//        .environmentObject(ThemeManager())
//}


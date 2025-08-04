//
//  SwiftUIView.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 2.08.2025.
//

import SwiftUI

struct MainPageView: View {
    @EnvironmentObject var themeManager : ThemeManager
    let result: Int = 1991
    let operation: String = "1907+31"
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
                ButtonLayout(title:"C", background: Color.gray)
                
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
                
                ButtonLayout(title: "%", background: Color.gray)
                ButtonLayout(title: "÷", background: Color.indigo)
            }
            HStack {
                ButtonLayout(title: "7", background: Color(UIColor.systemGray4))
                ButtonLayout(title: "8", background: Color(UIColor.systemGray4))
                ButtonLayout(title: "9", background: Color(UIColor.systemGray4))
                ButtonLayout(title: "x", background: Color.indigo)
            }
            HStack {
                ButtonLayout(title: "4", background: Color(UIColor.systemGray4))
                ButtonLayout(title: "5", background: Color(UIColor.systemGray4))
                ButtonLayout(title: "6", background: Color(UIColor.systemGray4))
                ButtonLayout(title: "-", background: Color.indigo)
            }
            HStack {
                ButtonLayout(title: "1", background: Color(UIColor.systemGray4))
                ButtonLayout(title: "2", background: Color(UIColor.systemGray4))
                ButtonLayout(title: "3", background: Color(UIColor.systemGray4))
                ButtonLayout(title: "+", background: Color.indigo)
            }
            HStack {
                ButtonLayout(title: ".", background: Color(UIColor.systemGray4))
                ButtonLayout(title: "0", background: Color(UIColor.systemGray4))
                
                Button(action: {}){
                    Image(systemName: "delete.left")
                        .foregroundStyle(.primary)
                        .frame(width: 78, height: 78)
                        .fontWeight(.medium)
                        .font(Font.custom("WorkSans-Regular", size: 28))
                }
                .background(Color(UIColor.systemGray4), in:RoundedRectangle(cornerRadius: 24))
                .padding([.leading, .bottom, .trailing], 7)
                
                ButtonLayout(title: "=", background: Color.indigo)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .padding(.bottom, 25)
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
        .onAppear{
            let toPostfix = InfixToPostfix()
            let post = toPostfix.converter("4 + 2 - 6 * 3")
            sleep(3)
            print(toPostfix.calculatePostfix(post))
        }
    }
}

#Preview {
    MainPageView()
        .environmentObject(ThemeManager())
}

struct ButtonLayout : View {
    
    let title : String
    let background : Color
    
    
    var body: some View {
        
        Button(action: {
            
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
}

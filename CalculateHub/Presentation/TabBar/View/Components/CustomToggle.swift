//
//  CustomToggle.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 4.08.2025.
//

import SwiftUI


class ThemeManager : ObservableObject {
    @Published var isDarkMode = true
    
    func toggleTheme(){
        isDarkMode.toggle()
    }
}

struct CustomToggle: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 72, height: 32)
                .foregroundStyle(.background.tertiary)
                .shadow(radius: 16)
            
            HStack(spacing:17) {
                
                if !themeManager.isDarkMode {
                            Image(systemName: "sun.max")
                                .foregroundStyle(.indigo)
                                .font(.system(size: 12))
                                .transition(.opacity.combined(with: .scale))
                            
                            
                            
                            Circle()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.gray)
                                .shadow(radius: 2)
                                .transition(.slide)
                        } else {
                            Circle()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.gray)
                                .shadow(radius: 2)
                                .transition(.slide)
                            
                            
                            Image(systemName: "moon")
                                .foregroundStyle(.indigo)
                                .font(.system(size: 12))
                                .transition(.opacity.combined(with: .scale))
                                
                        }
            }
            .padding(.horizontal, 4)
            .id(themeManager.isDarkMode)
            .onTapGesture {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    themeManager.toggleTheme()
                    
                }
            }
            .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
            
        }
    }
}

#Preview {
    CustomToggle()
        .environmentObject(ThemeManager())
}

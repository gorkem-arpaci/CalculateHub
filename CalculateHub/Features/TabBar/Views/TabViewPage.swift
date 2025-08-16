//
//  TaBViewPage.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 11.08.2025.
//

import SwiftUI

struct TabViewPage: View {
    @StateObject private var themeManager = ThemeManager()

    @Binding var selectedIndex: Int

    var body: some View {

            
            ZStack {
                Rectangle()
                    .foregroundStyle(Color(UIColor.systemGray4))
                    .frame(width: 350, height: 90)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 24)
                    )
                    .shadow(radius: 16)
                HStack(spacing: 40) {
                    CustomCalculateIcon()
                        .onTapGesture {
                            selectedIndex = 0
                        }
                        
                    Image(systemName: "function")
                        .onTapGesture {
                            selectedIndex = 1
                        }
                       
                    Image(systemName: "wand.and.sparkles")
                        .onTapGesture {
                            selectedIndex = 2
                        }
                    
                }
                
                .foregroundStyle(Color.indigo)
                .font(.system(size: 32, weight: .bold, design: .monospaced))

            }
            
        }
    }

#Preview {

    TabViewPage(selectedIndex: .constant(0))
        .environmentObject(ThemeManager())
        
}

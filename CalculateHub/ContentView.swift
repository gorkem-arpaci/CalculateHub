//
//  ContentView.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 2.08.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var number : Int = 0
    
    var body: some View {
        ZStack {
            VStack {
                VStack{
                    
                    TabViewPage(selectedIndex: $number)
                    CustomToggle()
                }
                
                switch number {
                case 0:
                    MainPageView()
                case 1:
                    CollegeFunctionsPage()
                case 2:
                    AIPage()
                default:
                    MainPageView()
                }

            }

        }
        
    }
}

#Preview {
    ContentView()
        .environmentObject(ThemeManager())
        
}

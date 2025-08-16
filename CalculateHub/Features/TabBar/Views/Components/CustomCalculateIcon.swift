//
//  CustomCalculateIcon.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 12.08.2025.
//

import SwiftUI

struct CustomCalculateIcon: View {
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    Image(systemName: "plus")
                    Image(systemName: "minus")
                }
                HStack{
                    Image(systemName: "multiply")
                    Image(systemName: "divide")
                }
            }
            .font(.system(size:12) .weight(.heavy))
            Image(systemName: "square")
                .font(.system(size: 46))
        }
    }
}

#Preview {
    CustomCalculateIcon()
}

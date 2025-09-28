//
//  ResponseDetailView.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 25.09.2025.
//

import SwiftUI


struct ResponseDetailView: View {
    let response: ResponseData
    @State private var showFullImage = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Soru resmi (büyük)
                if let image = response.uiImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 300)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                        .onTapGesture {
                            showFullImage = true
                        }
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 200)
                        .overlay {
                            VStack {
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                Text("Resim Yüklenemedi")
                                    .font(.caption)
                            }
                            .foregroundColor(.gray)
                        }
                }
                
                // Metadata
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Label(response.imageSource.capitalized,
                              systemImage: response.imageSource == "camera" ? "camera.fill" : "photo.fill")
                        
                        Spacer()
                        
                        Text(response.createdAt.formatted(.dateTime.day().month().year().hour().minute()))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .font(.subheadline)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
                
                Divider()
                
                // Yanıt içeriği
                VStack(alignment: .leading, spacing: 10) {
                    Text("AI Yanıtı")
                        .font(.title2)
                        .bold()
                    
                    MathDisplayView(mathContent: response.responseText.isEmpty ? "Boş content" : response.responseText)
                        .frame(height: 300)
                        .id(response.id)
                    
                }
            }
            .padding()
        }
        .navigationTitle("Yanıt Detayı")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showFullImage) {
            if let image = response.uiImage {
                FullScreenImageView(image: image)
            }
        }
    }
}

//#Preview {
//    ResponseDetailView()
//}

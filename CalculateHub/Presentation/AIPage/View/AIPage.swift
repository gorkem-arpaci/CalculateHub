//
//  AIPage.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 11.08.2025.
//
import SwiftUI
import PhotosUI
import SwiftData

struct AIPage: View {
    @State private var selectedImage: UIImage?
    @State private var showCamera = false
    @State private var apiResponse: String = ""
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var isLoading = false
    @Environment(\.modelContext) private var modelContext

    private let imageService = ImageService()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Seçilen / çekilen resim
                if let selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(12)
                } else {
                    Text("Henüz resim seçilmedi")
                        .foregroundStyle(.gray)
                }
                
                // Loading indicator
                if isLoading {
                    ProgressView("AI yanıtı işleniyor...")
                        .padding()
                }

                // Butonlar
                HStack(spacing: 30) {
                    // Kamera butonu
                    Button {
                        showCamera = true
                    } label: {
                        VStack {
                            Image(systemName: "camera")
                                .foregroundStyle(.black)
                                .frame(width: 50, height: 50)
                            Text("Kamera")
                                .font(.caption)
                        }
                    }
                    .disabled(isLoading)
                    
                    // Galeri butonu
                    PhotosPicker(
                        selection: $selectedPhotoItem,
                        matching: .images
                    ) {
                        VStack {
                            Image(systemName: "photo")
                                .foregroundStyle(.white)
                                .frame(width: 50, height: 50)
                            Text("Galeri")
                                .font(.caption)
                        }
                    }
                    .disabled(isLoading)
                    .onChange(of: selectedPhotoItem) { newItem in
                        if let newItem {
                            Task {
                                await handlePhotoSelection(newItem)
                            }
                        }
                    }
                }
                .sheet(isPresented: $showCamera) {
                    CameraView { image in
                        self.selectedImage = image
                        Task {
                            await sendImage(image, source: "camera", photoItemID: nil)
                        }
                    }
                }

                // API yanıtı - Güvenli WebView yüklemesi
                if !apiResponse.isEmpty && !isLoading {
                    ScrollView {
                        MathDisplayView(mathContent: apiResponse)
                            .frame(minHeight: 200, maxHeight: 400)
                    }
                } else if apiResponse.isEmpty && !isLoading && selectedImage != nil {
                    Text("AI yanıtı bekleniyor...")
                        .foregroundStyle(.gray)
                        .padding()
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("AI Asistan")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ResponseListView()) {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - Async Photo Selection
    @MainActor
    private func handlePhotoSelection(_ item: PhotosPickerItem) async {
        isLoading = true
        
        do {
            if let data = try await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                self.selectedImage = uiImage
                await sendImage(uiImage, source: "gallery", photoItemID: item.itemIdentifier)
            }
        } catch {
            print("Fotoğraf yükleme hatası: \(error)")
        }
        
        isLoading = false
    }

    // MARK: - Async Image Sending
    @MainActor
    private func sendImage(_ image: UIImage, source: String, photoItemID: String?) async {
        isLoading = true
        
        await withCheckedContinuation { continuation in
            imageService.sendImage(image) { response in
                Task { @MainActor in
                    // WebView yüklemesinden önce kısa bir bekleme
                    try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 saniye
                    
                    self.apiResponse = response
                    
                    AIResponseManager.saveResponse(
                        image: image,
                        response: response,
                        source: source,
                        context: modelContext
                    )
                    
                    self.isLoading = false
                    continuation.resume()
                }
            }
        }
    }
}
// MARK: - Full Screen Image View
struct FullScreenImageView: View {
    let image: UIImage
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            }
            .navigationTitle("Soru Resmi")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Kapat") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}

// MARK: - Search Bar
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField("Yanıtlarda ara...", text: $text)
            
            if !text.isEmpty {
                Button("Temizle") {
                    text = ""
                }
                .foregroundColor(.secondary)
                .font(.caption)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
        AIPage()
    
}

//
//  ResponseData.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 23.09.2025.
//

import Foundation
import SwiftData
import PhotosUI

@Model
class ResponseData {
    var id: UUID
    @Attribute(.externalStorage) var imageData: Data?
    var responseText: String
    var imageSource: String
    var createdAt: Date
    
    init(image: UIImage, response: String, source: String) {
        self.id = UUID()
        self.imageData = image.jpegData(compressionQuality: 0.8)
        self.responseText = response
        self.imageSource = source
        self.createdAt = Date() // Tarih eklendi
    }
    
    var uiImage: UIImage? {
        guard let imageData = imageData else { return nil }
        return UIImage(data: imageData)
    }
}

class AIResponseManager {
    
    @MainActor
    static func saveResponse(
        image: UIImage,
        response: String,
        source: String,
        context: ModelContext
    ) {
        let apiResponse = ResponseData(image: image, response: response, source: source)
        context.insert(apiResponse)
        do {
            try context.save()
            print("✅ Başarıyla kaydedildi.")
        } catch {
            print("❌ Kaydetme hatası: \(error.localizedDescription)")
        }
    }
    
    static func fetchAllResponses(context: ModelContext) -> [ResponseData] {
        let descriptor = FetchDescriptor<ResponseData>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }
    
    static func searchResponses(_ query: String, context: ModelContext) -> [ResponseData] {
        let descriptor = FetchDescriptor<ResponseData>(
            predicate: #Predicate { response in
                response.responseText.localizedStandardContains(query)
            },
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }
    
    // Ek yararlı fonksiyonlar
    static func fetchResponsesBySource(_ source: String, context: ModelContext) -> [ResponseData] {
        let descriptor = FetchDescriptor<ResponseData>(
            predicate: #Predicate { response in
                response.imageSource == source
            },
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }
    
    static func deleteResponse(_ response: ResponseData, context: ModelContext) {
        context.delete(response)
        do {
            try context.save()
            print("✅ Yanıt silindi.")
        } catch {
            print("❌ Silme hatası: \(error.localizedDescription)")
        }
    }
    
    static func deleteAllResponses(context: ModelContext) {
        let allResponses = fetchAllResponses(context: context)
        for response in allResponses {
            context.delete(response)
        }
        do {
            try context.save()
            print("✅ Tüm yanıtlar silindi.")
        } catch {
            print("❌ Silme hatası: \(error.localizedDescription)")
        }
    }
    
}

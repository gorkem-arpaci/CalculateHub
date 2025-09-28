//
//  ImageService.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 10.09.2025.
//

import UIKit

final class ImageService {
    private let client = APIClient()
    
    func sendImage(_ image: UIImage, completion: @escaping (String) -> Void) {
        guard let imageData = image.pngData() else { return }
        let base64String = imageData.base64EncodedString()
        let prompt = """
        Can you solve the problem in this image?
        ***For formatting***
        -Return Markdown format use only $$ $ boxed{} and ### 
        """
        
        let body: [String: Any] = [
            "model": "qwen/qwen2.5-vl-32b-instruct:free",
            "messages": [
                [
                    "role": "user",
                    "content": [
                        ["type": "text", "text": prompt],
                        ["type": "image_url",
                         "image_url": ["url": "data:image/png;base64,\(base64String)"]]
                    ]
                ]
            ]
        ]
        
        client.sendRequestOpenRouter(body: body) { result in
            switch result {
            case .success(let json):
                if let choices = json["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    completion(content)
                } else {
                    completion("Invalid response")
                }
            case .failure(let error):
                completion("Error: \(error.localizedDescription)")
            }
        }
    }
}

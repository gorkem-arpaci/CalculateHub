//
//  NetworkService.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 21.08.2025.
//

import Foundation

protocol NetworkService {
    func postFlask<T: Decodable, U: Encodable>(endpoint: String, body: U, completion: @escaping (Result<T, Error>) -> Void)
    func sendRequestOpenRouter(body: [String: Any], completion: @escaping (Result<[String: Any], Error>) -> Void)
}

class APIClient : NetworkService {
    func postFlask<T: Decodable, U: Encodable>(endpoint: String, body: U, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(NSError(domain: "", code: -1)))
            return
        }


        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -2)))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }

        }.resume()
    }
    
    func sendRequestOpenRouter(body: [String: Any], completion: @escaping (Result<[String: Any], Error>) -> Void) {
        guard let apiKey = ProcessInfo.processInfo.environment["OPENROUTER_API_KEY"], !apiKey.isEmpty else {
            print("API key yok!")
            completion(.failure(NSError(domain: "", code: 401)))
            return
        }
        let url = URL(string: "https://openrouter.ai/api/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
            
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    completion(.success(json))
                    print(json)
                } else {
                    completion(.failure(NSError(domain: "", code: -1)))
                }
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
}

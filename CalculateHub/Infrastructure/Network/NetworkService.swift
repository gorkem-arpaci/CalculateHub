//
//  NetworkService.swift
//  CalculateHub
//
//  Created by Görkem Arpacı on 21.08.2025.
//

import Foundation

protocol NetworkService {
    func post<T: Decodable, U: Encodable>(endpoint: String, body: U, completion: @escaping (Result<T, Error>) -> Void)
}

class APIClient : NetworkService {
    func post<T: Decodable, U: Encodable>(endpoint: String, body: U, completion: @escaping (Result<T, Error>) -> Void) {
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
}

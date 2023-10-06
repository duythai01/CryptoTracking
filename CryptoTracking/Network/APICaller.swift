//
//  APICaller.swift
//  CryptoTracking
//
//  Created by DuyThai on 05/10/2023.
//

import Foundation

class APICaller {
}
enum EndPoint {

}
struct APIService {
    static let shared = APIService()
    private let apiKey = "F926ZY2E61PNJIBFBGXYWIRSSPKI6WPE4C"

    private init() {}

    func request<T: Decodable>(url: String,  parameters: [String: Any], completion: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            
            guard var components = URLComponents(string: url) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            
            components.queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
            
            guard let url = components.url else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    }

    func requestArray<T: Decodable>(url: String, completion: @escaping (Result<[T], Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode([T].self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}


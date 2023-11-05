//
//  APICaller.swift
//  CryptoTracking
//
//  Created by DuyThai on 05/10/2023.
//

import Foundation
import SwiftUI
import Combine

class APICaller {
}
enum EndPoint {

}
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
struct APIService {
    static let shared = APIService()
    private let apiKey = "F926ZY2E61PNJIBFBGXYWIRSSPKI6WPE4C"

    private init() {}

    func request<T: Decodable>(endpoint: String, parameters: [String: Any], method: HTTPMethod, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: "\(BaseUrl.coinGekko.rawValue)\(endpoint)") else {
            completion(.failure(NetworkError.invalidURl))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if method == .get {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }

            if let urlWithQuery = components?.url {
                request.url = urlWithQuery
            }
        } else if method == .post {
            // Nếu có tham số và phương thức là POST, hãy mã hóa tham số thành dữ liệu JSON và đặt nó làm phần thân của yêu cầu
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = jsonData
            } catch {
                completion(.failure(error))
                return
            }
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            if (200..<300).contains(httpResponse.statusCode) {
                // Mã trạng thái HTTP nằm trong khoảng hợp lệ (200-299)
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(T.self, from: data)
                        completion(.success(model))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NetworkError.noData))
                }
            } else {
                // Mã trạng thái HTTP không nằm trong khoảng hợp lệ
                completion(.failure(NetworkError.httpError(code: httpResponse.statusCode)))
            }
        }

        task.resume()
    }


    func requestArray<T: Decodable>(endpoint: String, parameters: [String: Any], method: HTTPMethod, completion: @escaping (Result<[T], Error>) -> Void) {

        guard let url = URL(string: "\(BaseUrl.mock.rawValue)\(endpoint)") else {
            completion(.failure(NetworkError.invalidURl))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if method == .get {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }

            if let urlWithQuery = components?.url {
                request.url = urlWithQuery
            }
        } else if method == .post {
            // Nếu có tham số và phương thức là POST, hãy mã hóa tham số thành dữ liệu JSON và đặt nó làm phần thân của yêu cầu
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = jsonData
            } catch {
                completion(.failure(error))
                return
            }
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
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




class APIClient {
    static let shared = APIClient() // Singleton để sử dụng chung API Client

    private init() {} // Đảm bảo không thể tạo thể hiện mới

    func fetchData<T: Decodable>(_ endpoint: String, parameters: [String: String], responseType: T.Type) -> AnyPublisher<T, Error> {

        var components = URLComponents(string: "https://your-api-url.com/\(endpoint)")!
        components.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }

        guard let url = components.url else {
            return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: responseType, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


enum NetworkError: Error {
    case invalidResponse
    case invalidURl
    case noData
    case httpError(code: Int)
}

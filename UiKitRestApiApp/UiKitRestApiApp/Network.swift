//
//  Network.swift
//  UiKitRestApiApp
//
//  Created by kamil on 07.10.2021.
//

import Foundation


protocol NetworkServiceProtocol {
    var baseUrl: String { get }
    func getPostDate(completion: @escaping (Result<[Post], Error>) -> Void)
}

final class ApiClient: NetworkServiceProtocol {
    
    static let shared = ApiClient()
    
    let baseUrl = "https://jsonplaceholder.typicode.com/posts"
    
    func getPostDate(completion: @escaping (Result<[Post], Error>) -> Void) {
        guard let url = URL(string: baseUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    completion(.success(posts))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

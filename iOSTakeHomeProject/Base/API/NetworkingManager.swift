//
//  NetworkingManager.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 13.08.2023.
//

import Foundation


final class NetworkingManager {
    static let shared = NetworkingManager()
    
    private init(){
        
    }
    
    func request<T: Codable>(_ absoluteString: String, type: T.Type, completion: @escaping(Result<T,Error>) -> Void) {
        let url = URL(string: absoluteString)
        let request = URLRequest(url: url!)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...300) ~= response.statusCode else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let res = try decoder.decode(UserResponse.self, from: data)
            } catch {
                print("DEBUG: JSON parse error: \(error.localizedDescription)")
            }
            
        }
        dataTask.resume()
        
    }
}

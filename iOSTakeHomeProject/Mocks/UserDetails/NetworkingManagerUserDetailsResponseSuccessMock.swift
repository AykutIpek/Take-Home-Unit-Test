//
//  NetworkingManagerUserDetailsResponseSuccess.swift
//  iOSTakeHomeProjectTests
//
//  Created by aykut ipek on 18.08.2023.
//

import Foundation


#if DEBUG
final class NetworkingManagerUserDetailsResponseSuccessMock: NetworkingManagerProtocol {
    func request<T>(session: URLSession, _ endpoint: iOSTakeHomeProject.EndPoint, type: T.Type) async throws -> T where T : Decodable {
        return try StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self) as! T
    }
    
    func request(session: URLSession, _ endpoint: iOSTakeHomeProject.EndPoint) async throws {
        
    }
}
#endif


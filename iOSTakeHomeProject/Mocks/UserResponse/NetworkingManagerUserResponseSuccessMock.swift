//
//  NetworkingManagerUserResponseSuccessMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by aykut ipek on 17.08.2023.
//

import Foundation
@testable import iOSTakeHomeProject

final class NetworkingManagerUserResponseSuccessMock: NetworkingManagerProtocol {
    func request<T>(session: URLSession, _ endpoint: iOSTakeHomeProject.EndPoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper.decode(file: "UserStaticData", type: UserResponse.self) as! T
    }
    
    func request(session: URLSession, _ endpoint: iOSTakeHomeProject.EndPoint) async throws {
        
    }
}

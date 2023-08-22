//
//  NetworkingManagerUserResponseSuccessMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by aykut ipek on 17.08.2023.
//
#if DEBUG
import Foundation

class NetworkingManagerUserResponseSuccessMock: NetworkingManagerProtocol {
    func request<T>(session: URLSession, _ endpoint: EndPoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper.decode(file: "UserStaticData", type: UserResponse.self) as! T
    }
    
    func request(session: URLSession, _ endpoint: EndPoint) async throws {}
    
}
#endif

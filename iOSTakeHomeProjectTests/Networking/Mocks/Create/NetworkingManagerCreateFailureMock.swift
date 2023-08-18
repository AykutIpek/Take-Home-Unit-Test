//
//  NetworkingManagerCreateFailureMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by aykut ipek on 18.08.2023.
//

import Foundation

final class NetworkingManagerCreateFailureMock: NetworkingManagerProtocol {
    func request<T>(session: URLSession, _ endpoint: iOSTakeHomeProject.EndPoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return Data() as! T
    }
    
    func request(session: URLSession, _ endpoint: iOSTakeHomeProject.EndPoint) async throws {
        throw NetworkingManager.NetworkingError.invalidUrl
    }
    
    
}

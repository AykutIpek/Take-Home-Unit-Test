//
//  NetworkingManagerUserResponseFailureMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by aykut ipek on 17.08.2023.
//

import Foundation
@testable import iOSTakeHomeProject

final class NetworkingManagerUserResponseFailureMock: NetworkingManagerProtocol {
    func request<T>(session: URLSession, _ endpoint: iOSTakeHomeProject.EndPoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        throw NetworkingManager.NetworkingError.invalidUrl
    }
    
    func request(session: URLSession, _ endpoint: iOSTakeHomeProject.EndPoint) async throws {
        
    }
    
    
}

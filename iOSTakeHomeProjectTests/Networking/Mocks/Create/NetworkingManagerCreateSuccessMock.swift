//
//  NetworkingManagerCreateSuccessMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by aykut ipek on 18.08.2023.
//

#if DEBUG
import Foundation

final class NetworkingManagerCreateSuccessMock: NetworkingManagerProtocol {
    func request<T>(session: URLSession, _ endpoint: iOSTakeHomeProject.EndPoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return Data() as! T
    }
    
    func request(session: URLSession, _ endpoint: iOSTakeHomeProject.EndPoint) async throws {
        
    }
    
    
}
#endif

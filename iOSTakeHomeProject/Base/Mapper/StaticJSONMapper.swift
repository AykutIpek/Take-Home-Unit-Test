//
//  StaticJSONMapper.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 12.08.2023.
//

import Foundation


struct StaticJSONMapper {
    
    static func decode<T: Decodable>(file: String, type: T.Type) throws -> T {
        
        guard let path = Bundle.main.path(forResource: file, ofType: "json"),
        let data = FileManager.default.contents(atPath: path) else {
            throw MappingError.failedToGetContents
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}

private extension StaticJSONMapper {
    enum MappingError: Error {
        case failedToGetContents
    }
}

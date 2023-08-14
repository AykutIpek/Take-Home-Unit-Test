//
//  EndPoint.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 14.08.2023.
//

import Foundation


enum EndPoint {
    case people
    case detail(id: Int)
    case create(submissionData: Data?)
}

extension EndPoint {
    enum MethodType {
        case GET
        case POST(data: Data?)
    }
}


extension EndPoint {
    var host: String { "reqres.in" }
    
    var path : String {
        switch self {
        case .people,
                .create:
            return "/api/users"
        case .detail(let id):
            return "/api/users/\(id)"
        }
    }
    
    var methodType: MethodType {
        switch self {
        case .people, .detail:
            return .GET
        case .create(let data):
            return .POST(data: data)
        }
    }
}


extension EndPoint {
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        #if DEBUG
        urlComponents.queryItems = [
            URLQueryItem(name: "delay", value: "1")
        ]
        
        #endif
        
        return urlComponents.url
    }
}

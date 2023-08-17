//
//  NetworkingEndpointTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by aykut ipek on 17.08.2023.
//

import XCTest
@testable import iOSTakeHomeProject

final class NetworkingEndpointTests: XCTestCase {
    
    func test_with_people_endpoint_request_is_valid() {
        let endpoint = EndPoint.people(page: 1)
        
        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users", "The host should be /api/users")
        XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")
        XCTAssertEqual(endpoint.queryItems, ["page" : "1"], "The query items should be page: 1")
        XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users?page=1&delay=2", "The generated doesn't match our endpoint")
        
    }
    
    func test_with_detail_endpoint_request_is_valid() {
        let userId = 1
        let endpoint = EndPoint.detail(id: userId)
        
        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users/\(userId)", "The path should be /api/users/\(userId)")
        XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")
        XCTAssertNil(endpoint.queryItems, "The query items sholud be nil")
        XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users/\(userId)?delay=2", "The generated doesn't match our endpoint")

    }
    
    func test_with_create_endpoint_request_is_valid() {
        let endpoint = EndPoint.create(submissionData: nil)
        
        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users", "The host should be /api/users")
        XCTAssertEqual(endpoint.methodType, .POST(data: nil), "The method type should be POST")
        XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users?delay=2", "The generated doesn't match our endpoint")

    }
}

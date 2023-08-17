//
//  PeopleViewModelSuccessTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by aykut ipek on 17.08.2023.
//

import XCTest
@testable import iOSTakeHomeProject

@MainActor
final class PeopleViewModelSuccessTests: XCTestCase {

    private var networkingMock: NetworkingManagerProtocol!
    private var viewModel: PeopleViewModel!
    

    override func setUp() {
        networkingMock = NetworkingManagerUserResponseSuccessMock()
        viewModel = PeopleViewModel(networkingManager: networkingMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        viewModel = nil
    }

    func test_with_successful_response_users_array_is_set() async throws {
        
        XCTAssertFalse(viewModel.isLoading, "The view model shouldn't be loading any data")
        defer {
            XCTAssertFalse(viewModel.isLoading, "The view model shouldn't be loading any data")
            XCTAssertEqual(viewModel.viewState, .finished, "The view model view state shold be finished")
        }
        
        await viewModel.fetchUser()
        
        XCTAssertEqual(viewModel.users.count, 6, "There should be 6 users withing our data array")
    }
    
    func test_with_successful_paginated_response_users_array_is_set() async throws {
        
        XCTAssertFalse(viewModel.isLoading, "The view model shouldn't be loading any data")
        
        defer {
            XCTAssertFalse(viewModel.isFetching, "The view model shouldn't be fetching any data")
            XCTAssertEqual(viewModel.viewState, .finished, "The view model view state should be finished")
        }
        
        await viewModel.fetchUser()
        
        XCTAssertEqual(viewModel.users.count, 6, "The should be 6 users within our data array")
        
        await viewModel.fetchNextSetOfUsers()
        
        XCTAssertEqual(viewModel.users.count, 12, "The should be 12 users within our data array")
        
        XCTAssertEqual(viewModel.page, 2, "The page should be 2")
    }
}

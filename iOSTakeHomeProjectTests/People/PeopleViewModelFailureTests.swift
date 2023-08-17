//
//  PeopleViewModelFailureTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by aykut ipek on 17.08.2023.
//

import XCTest
@testable import iOSTakeHomeProject

@MainActor
final class PeopleViewModelFailureTests: XCTestCase {

    private var networkingMock: NetworkingManagerProtocol!
    
    private var viewModel: PeopleViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerUserResponseFailureMock()
        viewModel = PeopleViewModel(networkingManager: networkingMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        viewModel = nil
    }
    
    func test_with_unsuccessful_response_error_is_handled() async {
        
        XCTAssertFalse(viewModel.isLoading, "The view model shouldn't be loading any data")
        
        defer {
            XCTAssertFalse(viewModel.isLoading, "The view model shouldn't be loading any data")
            XCTAssertEqual(viewModel.viewState, .finished, "The view model view state shold be finished")
        }
        
        await viewModel.fetchUser()
        
        XCTAssertTrue(viewModel.hasError, "The view model should have an error")
        XCTAssertNotNil(viewModel.error, "The view model error should be set")
    }
}

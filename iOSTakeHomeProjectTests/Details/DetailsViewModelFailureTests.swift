//
//  DetailsViewModelFailureTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by aykut ipek on 18.08.2023.
//

import XCTest
@testable import iOSTakeHomeProject

final class DetailsViewModelFailureTests: XCTestCase {

    private var networkingMock: NetworkingManagerProtocol!
    private var viewModel: DetailViewModel!
    
    
    override func setUp() {
        networkingMock = NetworkingManagerUserDetailsResponseFailureMock()
        viewModel = DetailViewModel(networkingManager: networkingMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        viewModel = nil
    }
    
    func test_with_unsuccessful_response_error_is_handled() async throws {
        XCTAssertFalse(viewModel.isLoading, "The view model should not be loading")
        
        defer {
            XCTAssertFalse(viewModel.isLoading, "The view model should not be loading")
        }
        
        await viewModel.fetchDetails(for: 1)
        
        XCTAssertTrue(viewModel.hasError, "The view model error should be true")
        
        XCTAssertNotNil(viewModel.error, "The view model error should be not be nil")
    }

}

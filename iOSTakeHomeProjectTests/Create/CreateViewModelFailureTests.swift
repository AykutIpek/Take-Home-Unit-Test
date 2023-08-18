//
//  CreateViewModelFailureTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by aykut ipek on 18.08.2023.
//

import XCTest
@testable import iOSTakeHomeProject

final class CreateViewModelFailureTests: XCTestCase {

    private var networkingMock: NetworkingManagerProtocol!
    private var validationMock: CreateValidatorProtocol!
    private var viewModel: CreateViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerCreateFailureMock()
        validationMock = CreateValidatorSuccessMock()
        viewModel = CreateViewModel(networkingManager: networkingMock, validator: validationMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        validationMock = nil
        viewModel = nil
    }
    
    func test_with_unsuccessful_response_submission_state_is_unsuccessful() async throws {
        XCTAssertNil(viewModel.state, "The view model state should be nil")
        
        defer {
            XCTAssertEqual(viewModel.state, .unsuccessful, "The view model state should be unsuccessful")
        }
        await viewModel.create()
        
        XCTAssertTrue(viewModel.hasError, "The view model should have an error")
        XCTAssertNotNil(viewModel.error, "The view model error shouldn't be nil")
        XCTAssertEqual(viewModel.error, .networking(error: NetworkingManager.NetworkingError.invalidUrl), "The view model error should be a networking error with invalid url")
    }

}

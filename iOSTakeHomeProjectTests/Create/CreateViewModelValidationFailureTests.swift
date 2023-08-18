//
//  CreateViewModelValidationFailureTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by aykut ipek on 18.08.2023.
//

import XCTest
@testable import iOSTakeHomeProject

final class CreateViewModelValidationFailureTests: XCTestCase {
    
    private var networkingMock: NetworkingManagerProtocol!
    private var validationMock: CreateValidatorProtocol!
    private var viewModel: CreateViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerCreateSuccessMock()
        validationMock = CreateValidatorFailureMock()
        viewModel = CreateViewModel(networkingManager: networkingMock, validator: validationMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        validationMock = nil
        viewModel = nil
    }
    
    func test_with_invalid_form_submission_state_is_invalid() async {
        XCTAssertNil(viewModel.state, "The view model should ne nil initially")
        
        defer {
            XCTAssertEqual(viewModel.state, .unsuccessful, "The view model state should be unsuccessful")
        }
        
        await viewModel.create()
        
        XCTAssertTrue(viewModel.hasError, "The view model should have an error")
        XCTAssertNotNil(viewModel.error, "The view model error property shouldn't be nil")
        XCTAssertEqual(viewModel.error, .validation(error: CreateValidator.CreateValidotorError.invalidFirstName), "The view model error should be invalid first name")
    }
}

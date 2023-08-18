//
//  CreateViewModelSuccessTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by aykut ipek on 18.08.2023.
//

import XCTest
@testable import iOSTakeHomeProject

final class CreateViewModelSuccessTests: XCTestCase {

    private var networkingMock: NetworkingManagerProtocol!
    private var validationMock: CreateValidatorProtocol!
    private var viewModel: CreateViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerCreateSuccessMock()
        validationMock = CreateValidatorSuccessMock()
        viewModel = CreateViewModel(networkingManager: networkingMock, validator: validationMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        validationMock = nil
        viewModel = nil
    }
    
    func test_with_successful_response_submission_state_is_successful() async throws {
        
        XCTAssertNil(viewModel.state, "The view model state should be nil initally")
        
        defer {
            XCTAssertEqual(viewModel.state, .successful, "The view model state shold be successful")
        }
        
        await viewModel.create()
    }

}

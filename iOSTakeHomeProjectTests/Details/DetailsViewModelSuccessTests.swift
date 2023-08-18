//
//  DetailsViewModelSuccessTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by aykut ipek on 18.08.2023.
//

import XCTest
@testable import iOSTakeHomeProject

final class DetailsViewModelSuccessTests: XCTestCase {

    private var networkingMock: NetworkingManagerProtocol!
    private var viewModel: DetailViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerUserDetailsResponseSuccessMock()
        viewModel = DetailViewModel(networkingManager: networkingMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        viewModel = nil
    }
    
    func test_with_successful_response_users_details_is_set() async throws {
        XCTAssertFalse(viewModel.isLoading, "The view model should not be loading")
        
        defer {
            XCTAssertFalse(viewModel.isLoading, "The view model should not be loading")
        }
        
        await viewModel.fetchDetails(for: 1)
        
        XCTAssertNotNil(viewModel.userInfo, "The user info in the view model should not be nil")
        
        let userDetailsData = try StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self)
        
        XCTAssertEqual(viewModel.userInfo, userDetailsData, "The response from our networking mock should match")
    }

}

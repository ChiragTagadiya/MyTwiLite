//
//  MyTwiLiteUserTests.swift
//  MyTwiLiteTests
//
//  Created by DC on 28/01/23.
//

import XCTest
@testable import MyTwiLite

final class MyTwiLiteUserTests: XCTestCase, Profile {
    let viewModel = ProfileViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Fetch user profile
    func fetchUserInformation(callBack: @escaping (Result<Int, Error>) -> Void) {
        self.viewModel.fetchUserInformation(callBack: callBack)
    }

    // MARK: - Profile test case
    func testLogInUserSuccess() throws {
        let expectation = self.expectation(description: "Profile API Success")
        var profileResponse = 1
        var profileError: Error?
        
        self.fetchUserInformation { result in
            switch result {
            case .success(let response):
                profileResponse = response
            case .failure(let error):
                profileError = error
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
        XCTAssertTrue(self.viewModel.connectedToNetwork())
        XCTAssertEqual(profileResponse, 0)
        XCTAssertNil(profileError)
    }
}

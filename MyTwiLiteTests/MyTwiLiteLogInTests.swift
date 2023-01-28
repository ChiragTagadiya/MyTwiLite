//
//  MyTwiLiteLogInTests.swift
//  MyTwiLiteTests
//
//  Created by DC on 26/01/23.
//

import XCTest
import Firebase
@testable import MyTwiLite

final class MyTwiLiteLogInTests: XCTestCase, LogInUser {
    let viewModel = LogInViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Sign in user
    func signinUser(email: String, password: String, isReachable: ((Bool) -> Void)?, callBack: @escaping MyTwiLite.FirebaseCallBackType) {
        self.viewModel.signinUser(email: email, password: password, isReachable: nil, callBack: callBack)
    }
    
    // MARK: - Sign in user validation test case
    func testLogInUserValidation() {
        let email = "user12@test.com"
        let password = "Hello@123"
        let isEmailValid = viewModel.isUserDetailValid(text: email, validationType: .email)
        let isPasswordValid = viewModel.isUserDetailValid(text: password, validationType: .password)
        let invalidText = viewModel.isUserDetailValid(text: "", validationType: .normalText)
        XCTAssertFalse(invalidText)
        XCTAssertTrue(isEmailValid && isPasswordValid)
    }

    // MARK: - Sign in user test case
    func testLogInUserSuccess() throws {
        let expectation = self.expectation(description: "Log In User API Success")
        let email = "user12@test.com"
        let password = "Hello@123"
        var apiError: Error?
        var apiResponse: AuthDataResult?
        
        self.signinUser(email: email, password: password, isReachable: nil) { response, error in
            apiError = error
            apiResponse = response
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
        XCTAssertNil(apiError)
        XCTAssertNotNil(apiResponse)
    }
}

//
//  MyTwiLiteSignUpTests.swift
//  MyTwiLiteTests
//
//  Created by DC on 25/01/23.
//

import XCTest
import Firebase
@testable import MyTwiLite

final class MyTwiLiteSignUpTests: XCTestCase, SignUpUser {
    let viewModel = SignUpViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Sign Up user
    func createUser(_ userDetail: UserDetail, isReachable: ((Bool) -> Void)?, callBack: @escaping FirebaseCallBackType) {
        self.viewModel.createUser(userDetail, isReachable: isReachable, callBack: callBack)
    }

    // MARK: - Sign up user validation test case
    func testLogInUserValidation() {
        let email = "user12@test.com"
        let password = "Hello@123"
        let firstName = "User"
        let lastName = "Test"
        let isEmailValid = viewModel.isUserDetailValid(text: email, validationType: .email)
        let isPasswordValid = viewModel.isUserDetailValid(text: password, validationType: .password)
        let isFirstNameValid = viewModel.isUserDetailValid(text: firstName, validationType: .normalText)
        let isLastNameValid = viewModel.isUserDetailValid(text: lastName, validationType: .normalText)
        XCTAssertTrue(isEmailValid && isPasswordValid && isFirstNameValid && isLastNameValid)
    }
    
    // MARK: - Sign up user test case
    func testSignUpUserSuccess() throws {
        let expectation = self.expectation(description: "Sign Up User API Success")
        
        let email = "user12@test.com"
        let password = "Hello@123"
        let firstName = "User"
        let lastName = "Test"
        var apiError: Error?
        var apiResponse: AuthDataResult?

        if let profileImageData = UIImage(named: "ProfilePlaceholder")?.jpegData(compressionQuality: 0.6) {
            let user = UserDetail(firstName: firstName, lastName: lastName,
                                   email: email, password: password, profileImageData: profileImageData)
            self.createUser(user) { isReachable in
                XCTAssertNil(isReachable)
            } callBack: { response, error in
                apiError = error
                apiResponse = response
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertNil(apiResponse)
        XCTAssertNotNil(apiError)
    }
}

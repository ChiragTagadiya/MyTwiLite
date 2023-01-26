//
//  MyTwiLiteSignUpTests.swift
//  MyTwiLiteTests
//
//  Created by DC on 25/01/23.
//

import XCTest
import Firebase
@testable import MyTwiLite

final class MyTwiLiteSignUpTests: XCTestCase {

    let viewModel = SignUpViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateUserSuccess() throws {
        let expectation = self.expectation(description: "Create User API Success")
        
        let email = "user11@test.com"
        let password = "Test@123"
        let firstName = "User"
        let lastName = "Test"
        let profileImageData = UIImage(named: "ProfilePlaceholder")?.jpegData(compressionQuality: 0.6) ?? Data()
        
        let user = UserDetail(firstName: firstName, lastName: lastName,
                               email: email, password: password, profileImageData: profileImageData)

        var apiError: Error?
        var apiResponse: AuthDataResult?
        
        viewModel.createUser(user) { response, error in
            apiError = error
            apiResponse = response
           
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertNil(apiError)
        XCTAssertNotNil(apiResponse)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

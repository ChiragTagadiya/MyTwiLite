//
//  MyTwiLiteLogInTests.swift
//  MyTwiLiteTests
//
//  Created by DC on 26/01/23.
//

import XCTest
import Firebase
@testable import MyTwiLite

final class MyTwiLiteLogInTests: XCTestCase {
    
    let viewModel = LogInViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateUserSuccess() throws {
        let expectation = self.expectation(description: "Log In User API Success")
        
        let email = "user1@test.com"
        let password = "Hello@123"
       
        var apiError: Error?
        var apiResponse: AuthDataResult?
        
        viewModel.signinUser(email: email, password: password) { response, error in
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

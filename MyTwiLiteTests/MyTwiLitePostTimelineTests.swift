//
//  MyTwiLitePostTimelineTests.swift
//  MyTwiLiteTests
//
//  Created by DC on 28/01/23.
//

import XCTest
@testable import MyTwiLite

final class MyTwiLitePostTimelineTests: XCTestCase, PostTimeline {
    let viewModel = AddTimelineViewModel()

    // MARK: - Post timeline
    func postTimeline(_ uid: String, timelineText: String?, timlineImageData: Data?, isReachable: ((Bool) -> Void)?, callBack: @escaping (Result<Int, Error>) -> Void) {
        self.viewModel.postTimeline(uid, timelineText: timelineText, timlineImageData: timlineImageData, isReachable: isReachable, callBack: callBack)
    }
    
    // MARK: - Delete timeline
    func deleteMyTimeline(callBack: @escaping (Result<Int, Error>) -> Void) {
        self.viewModel.deleteMyTimeline(callBack: callBack)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Timeline validation
    func testLogInUserValidation() {
        self.viewModel.setTimelinePlaceholderStatus(false)
        XCTAssertTrue(self.viewModel.isTimelineValid(text: "Abc", imageData: nil))
        XCTAssertFalse(self.viewModel.isTimelineValid(text: nil, imageData: nil))
    }
    
    // MARK: - Post timeline test case
    func testPostAndDeleteTimelineSuccess() throws {
        let addExpectation = self.expectation(description: "Post Timeline API Success")
        var postTimelineResponse = 1
        var postTimelineError: Error?
        let deleteExpectation = self.expectation(description: "Delete Timeline API Success")
        var deleteTimelineResponse = 1
        var deleteTimelineError: Error?

        if let uid = FirebaseHelper.instance.currentUser()?.uid {
            self.postTimeline(uid, timelineText: "Hi", timlineImageData: nil, isReachable: nil) { result in
                switch result {
                case .success(let response):
                    postTimelineResponse = response
                    self.deleteMyTimeline { result in
                        switch result {
                        case .success(let response):
                            deleteTimelineResponse = response
                        case .failure(let error):
                            deleteTimelineError = error
                        }
                        deleteExpectation.fulfill()
                    }
                case .failure(let error):
                    postTimelineError = error
                }
                addExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10)
        XCTAssertEqual(postTimelineResponse, 0)
        XCTAssertNil(postTimelineError)
        XCTAssertEqual(deleteTimelineResponse, 0)
        XCTAssertNil(deleteTimelineError)
    }
}

//
//  MyTwiLiteTimelineDashboardTests.swift
//  MyTwiLiteTests
//
//  Created by DC on 28/01/23.
//

import XCTest
@testable import MyTwiLite

final class MyTwiLiteTimelineDashboardTests: XCTestCase, Timeline {
    let viewModel = DashboardViewModel()

    // MARK: - Fetch timelines
    func fetchTimelines(callBack: @escaping (Result<Int, Error>) -> Void) {
        self.viewModel.fetchTimelines(callBack: callBack)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Fetch my timeline test case
    func testFetchMyTimelineSuccess() throws {
        let expectation = self.expectation(description: "Fetch My Timeline API Success")
        var fetchTimelineResponse = 1
        var timelineError: Error?
        
        self.viewModel.isMyTimline = true
        self.fetchTimelines { result in
            switch result {
            case .success(let response):
                fetchTimelineResponse = response
            case .failure(let error):
                timelineError = error
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
        XCTAssertEqual(fetchTimelineResponse, 0)
        XCTAssertNil(timelineError)
    }

    // MARK: - Fetch all timeline test case
    func testFetchAllTimelineSuccess() throws {
        let expectation = self.expectation(description: "Fetch All Timeline API Success")
        var fetchTimelineResponse = 1
        var timelineError: Error?
        
        self.viewModel.isMyTimline = true
        self.fetchTimelines { result in
            switch result {
            case .success(let response):
                fetchTimelineResponse = response
            case .failure(let error):
                timelineError = error
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
        XCTAssertEqual(fetchTimelineResponse, 0)
        XCTAssertNil(timelineError)
    }
    
}

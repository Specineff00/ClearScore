//
//  ScoreViewModelTests.swift
//  ClearScoreTests
//
//  Created by Yogesh N Ramsorrrun on 18/08/2019.
//  Copyright © 2019 Nikash Ramsorrun. All rights reserved.
//

import XCTest
@testable import ClearScore

class ScoreViewModelTests: XCTestCase {
    
    let mockDao = MockDataAccessObject()
    var testViewModel: ScoreViewModel!

    override func setUp() {
        testViewModel = ScoreViewModel(dao: mockDao)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func test_fetchScoreSuccess_returnsScore(){
        testViewModel.fetchScore()
        XCTAssertEqual(testViewModel.scoreResult!.maxScore, 780)
        XCTAssertEqual(testViewModel.scoreResult!.score, 400)
    }
    
    func test_fetchScoreFail_returnsDecodeErrorAlertMessage() {
        mockDao.result = CSResult.failure(.decodeError)
        testViewModel.fetchScore()
        XCTAssertEqual(testViewModel.alertMessage, "Decode error")
    }
    
    func test_fetchScoreFail_returnsServerErrorAlertMessage() {
        mockDao.result = CSResult.failure(.serverError)
        testViewModel.fetchScore()
        XCTAssertEqual(testViewModel.alertMessage, "Server error")
    }
    
    func test_fetchScoreFail_returnsUnknownErrorAlertMessage() {
        mockDao.result = CSResult.failure(.unknown)
        testViewModel.fetchScore()
        XCTAssertEqual(testViewModel.alertMessage, "Unknown error")
    }

}

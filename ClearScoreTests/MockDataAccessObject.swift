//
//  MockDataAccessObject.swift
//  ClearScoreTests
//
//  Created by Yogesh N Ramsorrrun on 18/08/2019.
//  Copyright © 2019 Nikash Ramsorrun. All rights reserved.
//

import Foundation
@testable import ClearScore

class MockDataAccessObject: DataAccessObjectContract {
    var result = CSResult.success(CreditReportInfo(score: 400, maxScore: 780, minScore: 0))
    func getScore(onCompletion: @escaping CreditScoreClosure) {
        onCompletion(result)
    }
}

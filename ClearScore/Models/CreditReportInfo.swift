//
//  CreditScore.swift
//  ClearScore
//
//  Created by Nikash Ramsorrun on 31/07/2019.
//  Copyright © 2019 Nikash Ramsorrun. All rights reserved.
//

import Foundation

class CreditReportInfo: Decodable {
    let score: Int
    let maxScore: Int
    let minScore: Int
    
    init(score: Int, maxScore: Int, minScore: Int) {
        self.score = score
        self.maxScore = maxScore
        self.minScore = minScore
    }
    
    enum CodingKeys: String, CodingKey {
        case score
        case maxScore = "maxScoreValue"
        case minScore = "minScoreValue"
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let score: Int = try container.decode(Int.self, forKey: .score)
        let maxScore: Int = try container.decode(Int.self, forKey: .maxScore)
        let minScore: Int = try container.decode(Int.self, forKey: .minScore)
        
        self.init(score: score, maxScore: maxScore, minScore: minScore)
    }
    
}

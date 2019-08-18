//
//  ScoreViewModel.swift
//  ClearScore
//
//  Created by Yogesh N Ramsorrrun on 18/08/2019.
//  Copyright © 2019 Nikash Ramsorrun. All rights reserved.
//

import Foundation

class ScoreViewModel {
    let dao: DataAccessObjectContract
    var maxScore: Int?
    var score: Int? {
        didSet {
            self.updateScoreClosure?()
        }
    }
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var showAlertClosure: (()->())?
    var updateScoreClosure: (()->())?
    
    init(dao: DataAccessObjectContract) {
        self.dao = dao
    }
    
    func fetchScore() {
        dao.getScore {  [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let creditScore):
                strongSelf.score = creditScore.score
                strongSelf.maxScore = creditScore.maxScore
            case .failure(let error):
                strongSelf.alertMessage = error.localizedDescription
            }
            
        }
    }
}

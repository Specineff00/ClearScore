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
    var scoreResult: (score: Int, maxScore: Int)? {
        didSet {
            self.updateScoreClosure?()
        }
    }
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    private let unknownErrorString =  NSLocalizedString("unknown_error", comment: "")
    private let serverErrorString =  NSLocalizedString("server_error", comment: "")
    private let decodeErrorString =  NSLocalizedString("decode_error", comment: "")
    
    var showAlertClosure: (()->())?
    var updateScoreClosure: (()->())?
    var updateMaxScoreClosure: (()->())?
    
    init(dao: DataAccessObjectContract) {
        self.dao = dao
    }
    
    func fetchScore() {
        dao.getScore {  [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let creditScore):
                strongSelf.scoreResult = (score: creditScore.score,
                                    maxScore: creditScore.maxScore)
            case .failure(let error):
                switch error {
                case .decodeError:
                    strongSelf.alertMessage = strongSelf.decodeErrorString
                case .serverError:
                    strongSelf.alertMessage = strongSelf.serverErrorString
                case .unknown:
                    strongSelf.alertMessage = strongSelf.unknownErrorString
                }
                
            }
            
        }
    }
}

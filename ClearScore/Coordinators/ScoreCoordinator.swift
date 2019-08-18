//
//  ScoreCoordinator.swift
//  ClearScore
//
//  Created by Yogesh N Ramsorrrun on 18/08/2019.
//  Copyright © 2019 Nikash Ramsorrun. All rights reserved.
//

import UIKit

class ScoreCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private let viewModel: ScoreViewModel
    private var scoreViewController: ScoreViewController?
    
    init(presenter: UINavigationController, viewModel: ScoreViewModel) {
        self.presenter = presenter
        self.viewModel = viewModel
    }
    
    func start() {
        let scoreVC = ScoreViewController(viewModel: viewModel)
        presenter.pushViewController(scoreVC, animated: true)
        self.scoreViewController = scoreVC
    }
}

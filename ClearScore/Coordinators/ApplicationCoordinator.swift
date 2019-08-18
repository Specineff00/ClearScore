//
//  ApplicationCoordinator.swift
//  ClearScore
//
//  Created by Yogesh N Ramsorrrun on 18/08/2019.
//  Copyright © 2019 Nikash Ramsorrun. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    let rootViewController: UINavigationController
    let scoreCoordinator: ScoreCoordinator
    let url = URL(string: "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values")! //Normally would be a baseURL
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        
        let networkLayer = NetworkLayer(url: url)
        let dao = DataAccessObject(networkLayer: networkLayer)
        let viewModel = ScoreViewModel(dao: dao)
        self.scoreCoordinator = ScoreCoordinator(presenter: rootViewController, viewModel: viewModel)
    }
    
    
    func start() {
        window.rootViewController = rootViewController
        scoreCoordinator.start()
        window.makeKeyAndVisible()
    }
}

//
//  ScoreViewController.swift
//  ClearScore
//
//  Created by Yogesh N Ramsorrrun on 18/08/2019.
//  Copyright © 2019 Nikash Ramsorrun. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    
    let viewModel: ScoreViewModel
    
    init(viewModel: ScoreViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        viewModel.updateScoreClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let score = self?.viewModel.score {
                    self?.scoreLabel.text = String(score)
                }
            }
        }
        viewModel.fetchScore()
    }
    
    
    func createCircle() {
        
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

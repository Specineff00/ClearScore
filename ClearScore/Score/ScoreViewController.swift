//
//  ScoreViewController.swift
//  ClearScore
//
//  Created by Yogesh N Ramsorrrun on 18/08/2019.
//  Copyright © 2019 Nikash Ramsorrun. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var scoreButton: UIButton!
    var circleView: CircleView?
    
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
        setupLabels()
    }

    fileprivate func setupLabels() {
        topLabel.text = ""
        scoreLabel.text = ""
        bottomLabel.text = ""
        scoreButton.setTitle(NSLocalizedString("score_button", comment: ""), for: .normal)
    }
    
    
    private func setupCircle(score: Int, maxScore: Int) {
        circleView = CircleView(frame: containerView.frame)
        circleView?.center = view.center
        circleView?.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        guard let circleView = circleView  else { return }
        view.addSubview(circleView)
        circleView.animateCircle(duration: 1.0, score: score, maxScore: maxScore)
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
                if let scoreResult = self?.viewModel.scoreResult {
                    self?.scoreLabel.text = "\(scoreResult.score)"
                    self?.topLabel.text = NSLocalizedString("top_label", comment: "")
                    self?.bottomLabel.text =  NSLocalizedString("bottom_label", comment: "") + "\(scoreResult.maxScore)"
                    self?.setupCircle(score: scoreResult.score, maxScore: scoreResult.maxScore)
                    self?.scoreButton.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    @IBAction func scoreButtonTapped(_ sender: Any) {
        viewModel.fetchScore()
        circleView?.removeFromSuperview()
        circleView = nil
        setupLabels()
        scoreButton.isUserInteractionEnabled = false
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

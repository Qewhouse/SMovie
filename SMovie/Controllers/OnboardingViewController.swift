//
//  OnboardingViewController.swift
//  SMovie
//
//  Created by Alexander Altman on 01.04.2023.
//

import UIKit

protocol OnboardingViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

final class OnboardingViewController: UIViewController {
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: OnboardingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        view.addSubview(startButton)
        setConstraints()
        setup()
    }
}

extension OnboardingViewController {
    private func setup() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .primaryActionTriggered)
    }
}
    
    extension OnboardingViewController {
        @objc func startButtonTapped(_ sender: UIButton) {
            delegate?.didFinishOnboarding()
        }
    }
    
    extension OnboardingViewController {
        private func setConstraints() {
            NSLayoutConstraint.activate([
                startButton.heightAnchor.constraint(equalToConstant: 40),
                startButton.widthAnchor.constraint(equalToConstant: 150),
                startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    }

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
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "OnboardingImage")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.appColor
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = Theme.violetColor
        pageControl.currentPageIndicatorTintColor = .red
//        pageControl.
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Theme.violetColor
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: OnboardingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        view.backgroundColor = Theme.violetColor
        view.addSubview(backgroundImageView)
        view.addSubview(whiteView)
        whiteView.addSubview(startButton)
        whiteView.addSubview(pageControl)
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
                startButton.heightAnchor.constraint(equalToConstant: 56),
                startButton.widthAnchor.constraint(equalToConstant: 200),
                startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                startButton.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -20),
                
                backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                backgroundImageView.bottomAnchor.constraint(equalTo: whiteView.topAnchor),
                
                whiteView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
                whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
                whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
                whiteView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
                whiteView.heightAnchor.constraint(equalToConstant: 325),
                
                pageControl.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 20),
                pageControl.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: Theme.spacing),
                pageControl.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -Theme.spacing),
                pageControl.heightAnchor.constraint(equalToConstant: 10)
            ])
        }
    }

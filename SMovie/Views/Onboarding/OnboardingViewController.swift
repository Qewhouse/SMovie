//
//  OnboardingViewController.swift
//  SMovie
//
//  Created by Alexander Altman on 01.04.2023.
//

import UIKit
import SnapKit

protocol OnboardingViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingViewController: UIViewController {
    
    lazy var onboardingImage = UIImageView()
    lazy var personImageView = UIImageView()
    lazy var pageContainerView = UIView()
    lazy var pageScrollView = UIScrollView()
    lazy var pageButton = CustomButton(title: "Continue")
    lazy var pageIndicator = InteractivePageIndicator(pages: OnBoardingView.all.count)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .flipHorizontal
    }
    
    weak var delegate: OnboardingViewControllerDelegate?
    
    let networkService = NetworkService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.fetchMedia(.movie)
        networkService.fetchMedia(.tv)
        networkService.fetchGenre(.movie)
        networkService.fetchMedia(.tv)
        
        view.backgroundColor = Theme.violetColor
        configureBackgroundImages()
        configurepersonImage()
        configurePageContainerView()
        configurePages(OnBoardingView.all)
    }
    
    private func configureBackgroundImages() {
        view.addSubview(onboardingImage)
        onboardingImage.image = UIImage(named: "backgroundImages")
        onboardingImage.contentMode = .scaleAspectFill
        onboardingImage.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(25)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(240)
        }
    }
    
    private func configurepersonImage() {
        view.addSubview(personImageView)
        personImageView.image = UIImage(named: "personImage")
        personImageView.contentMode = .scaleAspectFill
        personImageView.snp.makeConstraints { make in
            make.height.equalTo(450)
            make.top.equalToSuperview().inset(44)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configurePageContainerView() {
        view.addSubview(pageContainerView)
        pageContainerView.addSubview(pageScrollView)
        pageContainerView.addSubview(pageButton)
        pageContainerView.addSubview(pageIndicator)
        pageButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        pageButton.layer.masksToBounds = true
        pageButton.layer.cornerRadius = 28
        pageContainerView.backgroundColor = Theme.appColor
        pageContainerView.layer.masksToBounds = true
        pageContainerView.layer.cornerRadius = 16
        pageScrollView.delegate = self
        pageScrollView.isPagingEnabled = true
        pageScrollView.showsHorizontalScrollIndicator = false
        
        pageContainerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.top.equalTo(personImageView.snp.bottom).inset(6)
            make.bottomMargin.equalToSuperview().inset(46)
        }
        pageScrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(60)
            make.bottom.equalToSuperview().inset(108)
        }
        pageButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(56)
            make.width.equalTo(200)
            make.bottom.equalToSuperview().inset(28)
        }
        pageIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(28)
        }
    }
    
    private func configurePages(_ pages: [OnBoardingView]) {
        pageScrollView.subviews.forEach { $0.removeFromSuperview() }
        let pageViews = pages.map { page in
            let pageView = OnBoardingPageView()
            pageView.configure(onboarding: page)
            return pageView
        }
        for (index, pageView) in pageViews.enumerated() {
            pageScrollView.addSubview(pageView)
            
            pageView.snp.makeConstraints { make in
                if index == 0 {
                    make.leading.equalTo(pageScrollView.contentLayoutGuide)
                    pageButton.isHidden = true
                } else {
                    make.leading.equalTo(pageViews[index - 1].snp.trailing)
                }
                make.top.bottom.equalTo(pageScrollView.contentLayoutGuide)
                make.width.height.equalToSuperview()
                if index == pageViews.count - 1 {
                    make.trailing.equalTo(pageScrollView.contentLayoutGuide)
                    pageButton.isHidden = false
                }
            }
        }
    }
    
    @objc private func continueButtonTapped() {
        let page = currentPage()
        if page < OnBoardingView.all.count - 1 {
            setPage(page + 1)
        } else {
            delegate?.didFinishOnboarding()
        }
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = calculateScrollProgress()
        pageIndicator.setPage(page)
    }
    
    func currentPage() -> Int {
        Int(calculateScrollProgress())
    }
    
    func setPage(_ page: Int) {
        let pageWidth = pageScrollView.frame.width
        pageScrollView.setContentOffset(.init(x: pageWidth * CGFloat(page), y: 0), animated: true)
    }
    
    private func calculateScrollProgress() -> Float {
        let offset = pageScrollView.contentOffset.x
        let pageWidth = pageScrollView.frame.width
        let currentPage = floor(offset / pageWidth)
        let pageDelta = offset - currentPage * pageWidth
        let page =  currentPage + pageDelta / pageWidth
        return Float(page)
    }
}

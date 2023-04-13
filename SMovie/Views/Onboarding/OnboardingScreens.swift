//
//  OnboardingScreens.swift
//  SMovie
//
//  Created by Alexander Altman on 08.04.2023.
//

import UIKit
import SnapKit

class OnBoardingPageView: UIView {
    
    var titleLabel = UILabel()
    var subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    func configure(onboarding: OnBoardingView) {
        titleLabel.text = onboarding.title
        subtitleLabel.text = onboarding.subtitle
    }
    
    private func configureUI() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        titleLabel.textColor = Theme.reversedAppColor
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 26, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        subtitleLabel.textColor = Theme.lightGrayText
        subtitleLabel.numberOfLines = 3
        subtitleLabel.font = .systemFont(ofSize: 18)
        subtitleLabel.textAlignment = .center
        subtitleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalToSuperview()
        }
        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).inset(-8)
            make.bottom.equalToSuperview()
        }
    }
}

//
//  OnboardingScreens.swift
//  SMovie
//
//  Created by Alexander Altman on 08.04.2023.
//

import UIKit

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

    func configure(onboarding: OnBoardingPage) {
        titleLabel.text = onboarding.title
        subtitleLabel.text = onboarding.subtitle
    }

    private func configureUI() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        titleLabel.textColor = UIColor(named: Resources.Colors.text)
        titleLabel.numberOfLines = 2
        titleLabel.font = .jakartaBold(size: 24)
        titleLabel.textAlignment = .center
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        subtitleLabel.textColor = UIColor(named: Resources.Colors.secondText)
        subtitleLabel.numberOfLines = 3
        subtitleLabel.font = .jakartaRegular(size: 14)
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

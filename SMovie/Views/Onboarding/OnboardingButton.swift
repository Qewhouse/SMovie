//
//  OnboardingButton.swift
//  SMovie
//
//  Created by Alexander Altman on 10.04.2023.
//

import UIKit

class CustomButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        setTitle("Continue", for: .normal)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    private func setupButton() {
        titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        setTitleColor(.white, for: .normal)
        contentMode = .center
        backgroundColor = Theme.violetColor
        layer.cornerRadius = 26
        translatesAutoresizingMaskIntoConstraints = false
    }
}

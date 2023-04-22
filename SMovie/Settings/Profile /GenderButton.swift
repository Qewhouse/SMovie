//
//  GenderButton.swift
//  SMovie
//
//  Created by Вова on 07.04.2023.
//

import UIKit

class GenderButton : UIButton {
    
    var flag = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton () {
        backgroundColor = Theme.appColor
        setTitleColor(UIColor(named: "violetColor"), for: .normal)
        layer.cornerRadius = 30
        layer.borderWidth = 2.0
        layer.borderColor = UIColor(named: "violetColor")?.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        imageView?.contentMode = .scaleAspectFit
        imageEdgeInsets = UIEdgeInsets(top: 15, left: 5, bottom: 15, right: 60)
        setImage(UIImage(named: flag ? "checked" : "unchecked"), for: .normal)
    }
}

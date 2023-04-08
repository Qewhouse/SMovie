//
//  ChangePictureButton.swift
//  SMovie
//
//  Created by Вова on 08.04.2023.
//

import UIKit

class ChangePictureButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton () {
        backgroundColor = #colorLiteral(red: 0.9607843757, green: 0.9607843757, blue: 0.9607843757, alpha: 1)
        setTitleColor(UIColor(named: "appColor"), for: .normal)
        layer.cornerRadius = 15
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .right
        imageView?.contentMode = .scaleAspectFit
        imageEdgeInsets = UIEdgeInsets(top:15, left:-170, bottom:15, right:0)
        titleEdgeInsets = UIEdgeInsets(top:0, left:-160, bottom:0, right:0)
    }
}


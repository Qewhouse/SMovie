//
//  SettingsModel.swift
//  SMovie
//
//  Created by Вова on 05.04.2023.
//

import UIKit

struct SettingsModel {
    let title: String
    let icon:  UIImage
    let handler: (()->Void)
}

struct SettingsSwitchModel {
    let title: String
    let icon:  UIImage
    let handler: (()->Void)
    let isOn:  Bool
}

enum SettingsModelType {
    case staticCell(model: SettingsModel)
    case switchCell(model: SettingsSwitchModel)
}

struct Section {
    let title: String
    let options: [SettingsModelType]
}

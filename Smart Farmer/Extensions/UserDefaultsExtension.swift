//
//  UserDefaultsExtension.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 02/06/2023.
//

import Foundation

extension UserDefaults {
    private enum userDefaultsKeys: String {
        case hasOnBoarded
    }
    
    var hasOnBoarded: Bool {
        get {
            bool(forKey: userDefaultsKeys.hasOnBoarded.rawValue)
        } set {
            setValue(newValue, forKey: userDefaultsKeys.hasOnBoarded.rawValue)
        }
    }
}

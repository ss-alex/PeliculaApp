//
//  PAColors.swift
//  PeliculaApp
//
//  Created by Лена Мырленко on 2020/5/6.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

enum PAColors {
    case customPink
    case customGrayBackground
    case customRed
    
    var color: UIColor {
        switch self {
        case .customPink:
            return UIColor(red: 255/255, green: 205/255, blue: 203/255, alpha: 1)
        case .customGrayBackground:
            return UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        case .customRed:
            return UIColor(red: 252/255, green: 97/255, blue: 97/255, alpha: 1)
        }
    }
}

//
//  Constants.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/24.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit


enum ScreenSize {
    static let width                        = UIScreen.main.bounds.size.width
    static let height                       = UIScreen.main.bounds.size.height
    static let maxLength                    = max(ScreenSize.width, ScreenSize.height)
    static let minLength                    = min(ScreenSize.width, ScreenSize.height)
}


enum DeviceTypes {
    static let idiom                        = UIDevice.current.userInterfaceIdiom /// The style of interface to use on the current device.
    static let nativeScale                  = UIScreen.main.nativeScale
    static let scale                        = UIScreen.main.scale
    
    static let isiPhoneSE                   = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard            = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed              = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard        = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed          = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                    = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr           = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                       = idiom == .phone && ScreenSize.maxLength >= 1024.0
    
    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}


enum Colors {
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





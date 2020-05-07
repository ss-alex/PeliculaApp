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


enum Images {
    static let paLogo                       = UIImage(named: "logo_pelicula")
    static let emptyStateLogo               = UIImage(named: "gray_dog2")
    static let castPlaceholder              = UIImage(named: "placeholder")
    static let backdropPlaceholder          = UIImage(named: "placeholder2")
    static let moviePosterPlaceholder       = UIImage(named: "placeholder3")
}


enum SFSymbols {
    static let calendar                     = UIImage(systemName: "calendar")
}







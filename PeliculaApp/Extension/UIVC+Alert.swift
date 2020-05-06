//
//  UIVIewController+Ext.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/17.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentPAAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC                      = PAAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle   = .overFullScreen
            alertVC.modalTransitionStyle     = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
}



//
//  UIViewController+Spinner.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/29.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

var containerView: UIView?

extension UIViewController {
    
    func showLoadingView(onView : UIView) {
        let spinnerView               = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor   = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let ai      = UIActivityIndicatorView.init(style: .large)
        ai.center   = spinnerView.center
        ai.startAnimating()
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        containerView = spinnerView
    }
    
    
    func removeLoadingView() {
        DispatchQueue.main.async {
            containerView?.removeFromSuperview()
            containerView = nil
        }
    }
}

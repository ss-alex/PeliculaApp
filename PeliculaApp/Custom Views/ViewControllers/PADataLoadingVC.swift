//
//  PADataLoadingVC.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/18.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class PADataLoadingVC: UIViewController {
    
    var containerView: UIView!

    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        view.addSubview(containerView)
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 } /// going from 0 to 0.8 transperency
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView () {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = PAEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
}

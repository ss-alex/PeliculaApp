//
//  UIVC+EmptyStateView.swift
//  PeliculaApp
//
//  Created by Лена Мырленко on 2020/4/29.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = PAEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
}

//
//  PAAlertContainerView.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/17.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class PAAlertContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configure ()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure () {
        backgroundColor      = .systemBackground
        layer.cornerRadius   = 16
        layer.borderWidth    = 2
        layer.borderColor    = UIColor.white.cgColor
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}

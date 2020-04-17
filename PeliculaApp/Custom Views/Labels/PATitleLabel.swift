//
//  PATitleLabel.swift
//  PeliculaApp
//
//  Created by Лена Мырленко on 2020/4/17.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class PATitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero) /// it connects a basic init method with that custom one
        self.textAlignment  = textAlignment
        self.font           = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    
    private func configure () {
        textColor                       = .label
        adjustsFontSizeToFitWidth       = true
        minimumScaleFactor              = 0.9 /// don't shrink font more that 90%
        lineBreakMode                   = .byTruncatingTail /// add 3 dots in the end if the label is long
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}

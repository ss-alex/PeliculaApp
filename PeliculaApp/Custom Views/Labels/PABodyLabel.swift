//
//  PABodyLabel.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/17.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class PABodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure ()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment) {
           self.init(frame: .zero)
           self.textAlignment = textAlignment
    }
    
    
    private func configure () {
        textColor                           = .secondaryLabel 
        font                                = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory   = true
        adjustsFontSizeToFitWidth           = true
        minimumScaleFactor                  = 0.75
        lineBreakMode                       = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }

}

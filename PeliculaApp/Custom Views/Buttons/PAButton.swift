//
//  PAButton.swift
//  PeliculaApp
//
//  Created by Лена Мырленко on 2020/4/16.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class PAButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(backgroundColor: UIColor, tittle: String) {
        self.init(frame: .zero) // 
        self.backgroundColor = backgroundColor
        self.setTitle(tittle, for: .normal)
    }
    
    
    private func configure() {
        layer.cornerRadius                          = 10
        titleLabel?.font                            = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints   = false
    }
    
    
    func set(backgroundColor:UIColor, title: String) {
        self.backgroundColor    = backgroundColor
        setTitle(title, for: .normal)
    }
}



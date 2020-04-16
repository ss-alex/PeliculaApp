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
        self.init(frame: .zero) // set the frame to .zero since constraints will be added later
        self.backgroundColor = backgroundColor
        self.setTitle(tittle, for: .normal)
    }
    
    
    private func configure() {
        layer.cornerRadius                          = 10
        titleLabel?.font                            = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(.systemBlue, for: .normal)
        translatesAutoresizingMaskIntoConstraints   = false
    }
    
    
    func set(backgroundColor:UIColor, title: String) { /// despite here is the init method that is appropriate for that task, sometimes it is needed to change 'backgroundColor' and 'title' in the  specific way
        self.backgroundColor    = backgroundColor
        setTitle(title, for: .normal)
    }
}



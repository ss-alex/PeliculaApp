//
//  PAEmptyStateView.swift
//  PeliculaApp
//
//  Created by Лена Мырленко on 2020/4/24.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class PAEmptyStateView: UIView {
    
    let messageLabel  = PATitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMessageLabel()
        configureLogoImageView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func configureMessageLabel() {
        addSubview(messageLabel)
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel
        
         let messageLabelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -150
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: messageLabelCenterYConstant),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func configureLogoImageView() {
        addSubview(logoImageView)
        logoImageView.image = UIImage(named: "gray_dog")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let logoImageBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 48 : 8
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -80),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoImageBottomConstant)
        ])
    }
    
}

//
//  PAHeartButton.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/21.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class PAHeartButton: UIButton {

    var isOn = true
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    
    func initButton() {
        
        addTarget(self, action: #selector(PAHeartButton.buttonPressed), for: .touchUpInside)
    }
    
    
    @ objc func buttonPressed() {
        activateButton(bool: !isOn)
    }
    
    
    func activateButton(bool: Bool) {
        isOn = bool
        let color = bool ? UIColor.systemPink : UIColor.clear
        backgroundColor = color
    }

}

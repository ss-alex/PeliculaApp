//
//  UIImageView + Ext.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/15.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

//
//  UITableView+RemoveCells.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/21.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit


extension UITableView {
    
    func removeExcessCells() {
         tableFooterView = UIView(frame: .zero)
    }
    
}

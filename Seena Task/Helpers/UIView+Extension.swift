//
//  UIView+Extension.swift
//  Seena Task
//
//  Created by Ma7rous on 17/02/2023.
//

import UIKit


extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib : UINib {
        return UINib(nibName : "\(self)",bundle : nil)
    }
}




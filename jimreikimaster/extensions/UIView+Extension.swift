//
//  UIView+Extension.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 25/09/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    
    func circleView() {
        self.layer.cornerRadius = self.frame.height/2;
    }
    
    func circleViewWithBorder() {
        self.layer.cornerRadius = self.frame.height/2;
        self.layer.borderColor = UIColor.init(red: 172/255, green: 170/255, blue: 183/255, alpha: 1).cgColor;
        self.layer.borderWidth = 1
    }

    func rounderCornerView() {
        self.layer.cornerRadius = self.frame.height/2;
    }
    
    func rounderCornerViewWithBorder() {
        self.layer.cornerRadius = self.frame.height/2;
        self.layer.borderColor = UIColor.init(red: 172/255, green: 170/255, blue: 183/255, alpha: 1).cgColor;
        self.layer.borderWidth = 1
    }
    
    func curvedCornerViewWithBorder() {
        self.layer.cornerRadius = 20;
        self.layer.borderColor = UIColor.init(red: 172/255, green: 170/255, blue: 183/255, alpha: 1).cgColor;
        self.layer.borderWidth = 1
    }
    
    func dropGradientShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.init(red: 150/255, green: 114/255, blue: 251/255, alpha: 1).cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

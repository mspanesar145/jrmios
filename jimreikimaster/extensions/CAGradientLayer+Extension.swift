//
//  CAGradientLayer+Extension.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 18/10/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import Foundation
import UIKit

extension CAGradientLayer {
    
    class func primaryGradient(on view: UIView) -> UIImage? {
        let gradient = CAGradientLayer()
        
        let flareRed = UIColor(displayP3Red: 150.0/255.0, green: 114.0/255.0, blue: 251.0/255.0, alpha: 1.0)
        
        let flareOrange = UIColor(displayP3Red: 255.0/255.0, green: 101.0/255.0, blue: 139.0/255.0, alpha: 1.0)
        var bounds = view.bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds
        gradient.colors = [flareRed.cgColor, flareOrange.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        return gradient.createGradientImage(on: view)
    }
    
    private func createGradientImage(on view: UIView) -> UIImage? {
        var gradientImage: UIImage?
        UIGraphicsBeginImageContext(view.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
}

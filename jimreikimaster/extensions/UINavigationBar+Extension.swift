//
//  UINavigationBar+Extension.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 26/09/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    func setGradientBackground(colors: [Any]) {
           let gradient: CAGradientLayer = CAGradientLayer()
           gradient.locations = [0.0 , 0.5, 1.0]
           gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
           gradient.endPoint = CGPoint(x: 1.0, y: 1.0)

           var updatedFrame = self.bounds
           updatedFrame.size.height += self.frame.origin.y
           gradient.frame = updatedFrame
           gradient.colors = colors;
           self.setBackgroundImage(self.image(fromLayer: gradient), for: .default)
       }

       func image(fromLayer layer: CALayer) -> UIImage {
           UIGraphicsBeginImageContext(layer.frame.size)
           layer.render(in: UIGraphicsGetCurrentContext()!)
           let outputImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           return outputImage!
       }
}

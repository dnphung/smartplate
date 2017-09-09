//
//  StomachIndicatorView.swift
//  SmartPlate
//
//  Created by Danh-Nhan Phung on 09.09.17.
//  Copyright © 2017 Danh-Nhan Phung. All rights reserved.
//

import UIKit


@IBDesignable
class StomachIndicatorView: UIView {
    @IBInspectable var healthyNutritionValue: CGFloat = 334
    
    override func draw(_ rect: CGRect) {
        SmartPlateKit.drawCanvas1(frame: UIScreen.main.bounds, resizing: .aspectFit, nutritionValue: healthyNutritionValue)
    }
}

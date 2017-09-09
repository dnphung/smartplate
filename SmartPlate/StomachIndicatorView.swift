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
    @IBInspectable var fatValue: CGFloat = 1
    @IBInspectable var carbsValue: CGFloat = 1
    @IBInspectable var proteinValue: CGFloat = 1
    @IBInspectable var sugarValue: CGFloat = 1
    @IBInspectable var caloriesTrackingValue = "1500 / 2500 kcal"
    
    override func draw(_ rect: CGRect) {
        SmartPlateKit.drawCanvas1(frame: UIScreen.main.bounds, resizing: .aspectFit, fatValue: fatValue, carbsValue: carbsValue, proteinValue: proteinValue, sugarValue: sugarValue, caloriesTrackingValue: caloriesTrackingValue )
    }
}

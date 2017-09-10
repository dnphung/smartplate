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
    @IBInspectable var othersValue: CGFloat = 1
    @IBInspectable var caloriesTrackingValue = "1500 / 2500 kcal"
    @IBInspectable var lastMealLabel = "Your lastmeal: "
    @IBInspectable var carbsPerc = "Carbs 30%"
    @IBInspectable var fatPerc = "Fats 12%"
    @IBInspectable var othersPerc = "Others 13%"
    @IBInspectable var proteinPerc = "Proteins 54%"
    override func draw(_ rect: CGRect) {
        SmartPlateKit.drawCanvas1(frame: UIScreen.main.bounds, resizing: .aspectFit, fatValue: fatValue, carbsValue: carbsValue, proteinValue: proteinValue, othersValue: othersValue, caloriesTrackingValue: caloriesTrackingValue, lastMealLabel: lastMealLabel, carbsPerc: carbsPerc, fatPerc:fatPerc, proteinPerc: proteinPerc)
    }
}

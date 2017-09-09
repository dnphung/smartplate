//
//  Meal.swift
//  SmartPlate
//
//  Created by Danh-Nhan Phung on 09.09.17.
//  Copyright © 2017 Danh-Nhan Phung. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Meal: Object, Mappable {
    dynamic var calories = 0.0
    dynamic var carbs = 0.0
    dynamic var fat = 0.0
    dynamic var protein = 0.0
    dynamic var foodType = ""
    
    required convenience init?(map: Map) {
        self.init()
        if map.JSON["calories"] == nil {
            print("JSON attribute 'calories' couldn't be found")
        }
        if map.JSON["carbs"] == nil {
            print("JSON attribute 'carbs' couldn't be found")
        }
        if map.JSON["fat"] == nil {
            print("JSON attribute 'fat' couldn't be found")
        }
        if map.JSON["protein"] == nil {
            print("JSON attribute 'protein' couldn't be found")
        }
    }

    
    func mapping(map: Map) {
        calories <- map["calories"]
        carbs <- map["carbs"]
        fat <- map["fat"]
        protein <- map["protein"]
    }
    
}

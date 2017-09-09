//
//  Meal.swift
//  SmartPlate
//
//  Created by Danh-Nhan Phung on 09.09.17.
//  Copyright © 2017 Danh-Nhan Phung. All rights reserved.
//

import Foundation
import ObjectMapper
class Meal: Mappable {
    var calories: Int
    required init?(map: Map) {
        if map.JSON["device_class_name"] == nil {
            print("JSON attribute 'device_class_name' couldn't be found")
        }
    }
    
    func mapping(map: Map) { }
    

}

//
//  ViewController.swift
//  SmartPlate
//
//  Created by Danh-Nhan Phung on 08.09.17.
//  Copyright © 2017 Danh-Nhan Phung. All rights reserved.
//

import UIKit
import SocketIO
import RealmSwift

class ViewController: UIViewController {
    @IBOutlet var stomachView: StomachIndicatorView!
    var fatValueTotal = 0.0
    var carbsValueTotal = 0.0
    var proteinValueTotal = 0.0
    var othersValueTotal = 0.0
    var caloriesUpToNow = 0.0
    
    var fatReference = 0.0
    var carbsReference = 0.0
    var proteinReference = 0.0
    var othersReference = 0.0
    
    var caloriesGoal = 3500.0
    
    var meals: Results<Meal>?
    var lastMeal = ""
    
    var socket: SocketIOClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // initDemo()
        loadData()
        setupValues()
        connect()
    }
    
    func loadData() {
        let realm = try! Realm()
        meals = realm.objects(Meal.self)
    }
    
    func connect() {
        socket = SocketIOClient(socketURL: URL(string: "https://polar-shelf-82300.herokuapp.com")!, config: [.log(true), .compress])
        
        guard let socket = socket else {
            print("socket not available")
            return
        }
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.on("message") {data, ack in
            print(data)
            if let cur = data[0] as? [String: Any] {
                print("This is the data: \(cur)" )
//                guard let jsonData = try? JSONSerialization.data(withJSONObject: cur, options: []) else {
//                    return
//                }
//                let jsonString = String(data: jsonData, encoding: .utf8) 
                //print(jsonString)
                guard let meal = Meal(JSON: cur) else {
                    print("couldn't parse meal")
                    return
                }
                if self.lastMeal != meal.foodType {
                    let realm = try! Realm()
                    
                    try! realm.write {
                        realm.add(meal)
                    }
                    self.lastMeal = meal.foodType
                    self.loadData()
                    self.setupValues()
                }
            }
        }
        
        socket.connect()
        
    }
    
    func initDemo() {
        let realm = try! Realm()
        let food1 = Meal()
        food1.foodType = "Meal 1"
        food1.calories = 400
        food1.carbs = 50
        food1.fat = 50
        food1.protein = 150
        let food2 = Meal()
        food2.foodType = "Meal 2"
        food2.calories = 800
        food2.carbs = 400
        food2.fat = 100
        food2.protein = 250
        let food3 = Meal()
        food3.foodType = "Meal 3"
        food3.calories = 500
        food3.carbs = 300
        food3.fat = 50
        food3.protein = 100
        try! realm.write {
            realm.add(food1)
            realm.add(food2)
            realm.add(food3)
        }
    }
    
    func setupValues() {
        self.calcTotalValues()
        self.calcPercentage()
        
        let endFatValue = self.fatReference * 347
        let endCarbsValue = self.carbsReference * 347 + endFatValue
        let endProteinValue = self.proteinReference * 347 + endCarbsValue
        let endOthersValue = self.othersReference * 347 + endProteinValue
        
        self.stomachView.fatValue = CGFloat(endFatValue)
        self.stomachView.carbsValue = CGFloat(endCarbsValue)
        self.stomachView.proteinValue = CGFloat(endProteinValue)
        self.stomachView.othersValue = CGFloat(endOthersValue)
        
        self.stomachView.caloriesTrackingValue = "\(self.caloriesUpToNow) / \(self.caloriesGoal) kcal"
        self.stomachView.lastMealLabel = "Your last meal: \(lastMeal)"
        
        self.stomachView.fatPerc = "Fats \((fatReference * 100).rounded()) %"
        self.stomachView.carbsPerc = "Carbs \((carbsReference * 100).rounded()) %"
        self.stomachView.proteinPerc = "Proteins \((proteinReference * 100).rounded()) %"
        self.stomachView.setNeedsDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calcPercentage() {
        
        
        let referenceCaloriesValue: Double = self.caloriesUpToNow / self.caloriesGoal
        
        fatReference = (fatValueTotal / caloriesUpToNow) * referenceCaloriesValue
        carbsReference = (carbsValueTotal / caloriesUpToNow) * referenceCaloriesValue
        proteinReference = (proteinValueTotal / caloriesUpToNow) * referenceCaloriesValue
    }
    
    func calcTotalValues() {
        guard let meals = meals else {
            print("No meals found")
            return
        }
        caloriesUpToNow = 0.0
        carbsValueTotal = 0.0
        fatValueTotal = 0.0
        proteinValueTotal = 0.0
        
        for meal in meals {
            caloriesUpToNow += meal.calories
            carbsValueTotal += meal.carbs * 4
            fatValueTotal += meal.fat * 9
            proteinValueTotal += meal.protein * 4
        }
        
    }
    @IBAction func clearDataButton(_ sender: UIButton) {
        fatValueTotal = 0.0
        carbsValueTotal = 0.0
        proteinValueTotal = 0.0
        caloriesUpToNow = 0.0
        
        fatReference = 0.0
        carbsReference = 0.0
        proteinReference = 0.0
        
        lastMeal = ""
        
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        loadData()
        setupValues()
    }
}


//
//  ViewController.swift
//  SmartPlate
//
//  Created by Danh-Nhan Phung on 08.09.17.
//  Copyright © 2017 Danh-Nhan Phung. All rights reserved.
//

import UIKit
import SocketIO

class ViewController: UIViewController {
    @IBOutlet var stomachView: StomachIndicatorView!
    var fatValue: Int?
    var carbsValue: Int?
    var proteinValue: Int?
    var sugarValue: Int?
    var caloriesUpToNow: Int?
    
    var caloriesGoal: Int?
    
    var meals: [Meals]?

    override func viewDidLoad() {
        super.viewDidLoad()
        initDemo()
        setupValues()
        //connect()
    }
    
    func connect() {
        let socket = SocketIOClient(socketURL: URL(string: "http://techfestmunich.herokuapp.com")!, config: [.log(true), .compress])
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.on("/") {data, ack in
            if let cur = data[0] as? Double {
                socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
                    socket.emit("update", ["amount": cur + 2.50])
                }
                
                ack.with("Got your currentAmount", "dude")
            }
        }
        
        socket.connect()
        
    }
    
    func initDemo() {
        fatValue = 23
        carbsValue = 105
        proteinValue = 90
        sugarValue = 10
        caloriesUpToNow = 500
    }
    
    func setupValues() {
        if let fat = fatValue,
            let carbs = carbsValue,
            let protein = proteinValue,
            let sugar = sugarValue {
            
            self.stomachView.fatValue = CGFloat(fat)
            self.stomachView.carbsValue = CGFloat(fat + carbs)
            self.stomachView.proteinValue = CGFloat(fat + carbs + protein)
            self.stomachView.sugarValue = CGFloat(fat + carbs + protein + sugar)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calcPercentage() {
        guard let caloriesGoal = caloriesGoal else {
            //set standard daily recommendation
            self.caloriesGoal = 2700
            return
        }
        guard let caloriesUpToNow = caloriesUpToNow else {
            self.caloriesUpToNow = 0
            return
        }
        var referenceCaloriesValue = caloriesUpToNow / caloriesGoal
    }


}


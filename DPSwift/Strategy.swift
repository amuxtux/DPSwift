//
//  Strategy.swift
//  DPSwift
//
//  Created by Amit Singhai on 4/27/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import Foundation
protocol DrivingStrategy {
    func selectedRoute() -> String
}

class TimeSavingStrategy : DrivingStrategy{
    func selectedRoute() -> String {
        return "Toll Road"
    }
}

class MoneySavingStrategy : DrivingStrategy{
    func selectedRoute() -> String {
        return "Service Road"
    }
}

class DrivingContext {
    var strategy : DrivingStrategy
    
    init(strategy : DrivingStrategy){
        self.strategy = strategy
    }
    
    func executeDrive(from: String , to : String){
        print("we are driving from \(from) to \(to) via \(self.strategy.selectedRoute())")
    }
}


func testStrategy(){
    let drivingContext = DrivingContext(strategy: TimeSavingStrategy())
    drivingContext.executeDrive(from: "Bangalore", to : "Hasan")
    
    let economicDrivingContext = DrivingContext(strategy: MoneySavingStrategy())
    economicDrivingContext.executeDrive(from: "Suwon", to : "Seoul")
}

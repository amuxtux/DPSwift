//
//  Visitor.swift
//  DPSwift
//
//  Created by Amit Singhai on 4/27/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import Foundation

protocol SpaceShip {
    func accept(visitor : Visitor)
}

protocol Visitor{
    
    func visit(ship : SpaceShip)
}

class AbstractShip : SpaceShip {
    let type : String
    
    init(_ type : String){
        self.type = type
    }
    
    func accept(visitor : Visitor){
        visitor.visit(ship: self)
    }
}

class Fighter : AbstractShip {
     init(){
        super.init("Fighter")
    }
}

class Bomber : AbstractShip {
     init(){
        super.init("Bomber")
    }
}

class Corvett : AbstractShip {
     init(){
        super.init("Corvett")
    }
}

class Carrier : AbstractShip {
     init(){
        super.init("Carrier")
    }
}

class MotherShip : AbstractShip {
     init(){
        super.init("MotherShip")
    }
}

// DashboardVisitor is concrete visitor
class DashboardVisitor : Visitor {
    var fleet : [String : Int] = [String : Int]()
    
    func visit (ship : SpaceShip){
        if let shipCount = fleet[ (ship as! AbstractShip).type] {
            fleet[(ship as! AbstractShip).type] = shipCount + 1
        } else {
            fleet[(ship as! AbstractShip).type] = 1
        }
    }
    
    func showFleet(){
        for (type , count)  in fleet{
            print("fleet has \(count) \(type) ")
        }
    }
}

func testVisitor(){
    let dashboard = DashboardVisitor()
    
    //usually there is 1 mother ship
    let motherShip  = MotherShip()
    motherShip.accept(visitor: dashboard)
    
    //10 fighters
    for _ in 1...10{
        let fighter = Fighter()
        fighter.accept(visitor: dashboard)
    }
    //5 corvetts
    for _ in 1...5{
        let corvett = Corvett()
        corvett.accept(visitor: dashboard)
    }
    
    // 1 carrier ship
    let carrier = Carrier()
    carrier.accept(visitor: dashboard)
    
    dashboard.showFleet()
}

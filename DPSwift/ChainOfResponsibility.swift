//
//  ChainOfResponsibility.swift
//  DPSwift
//
//  Created by Amit Singhai on 4/27/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import Foundation

enum BabyCondition {
    case BORED, HUNGRY , SICK , FINEandSLEEPING
}

class Baby{
    //let assume baby is by default bored most of the time
    var condition : BabyCondition = BabyCondition.BORED
}

protocol CryBabyResponder{
    func tryToCalmBabyAndExplainCrying(_ baby : Baby)
}

class Father : CryBabyResponder{
    let nextHandler : CryBabyResponder
    
    init(_ next : CryBabyResponder){
        self.nextHandler = next
    }
    
    func tryToCalmBabyAndExplainCrying(_ baby : Baby){
       if baby.condition == .BORED{
          print("Handled by Father:: action taken , swing the baby")
          print("Reason of Crying :: baby is being Bored, needed to play ")
       } else {
          nextHandler.tryToCalmBabyAndExplainCrying(baby)
       }
    }
}

class Mother : CryBabyResponder{
    let nextHandler : CryBabyResponder
    
    init(_ next : CryBabyResponder){
        self.nextHandler = next
    }
    
    func tryToCalmBabyAndExplainCrying(_ baby : Baby){
        if baby.condition == .HUNGRY{
            print("Handled by Mother:: action taken , fed tasty Cerelac ")
            print("Reason of Crying :: baby was hungry ")
        } else {
            nextHandler.tryToCalmBabyAndExplainCrying(baby)
        }
    }
}

class Doctor : CryBabyResponder{
    
    func tryToCalmBabyAndExplainCrying(_ baby : Baby){
        baby.condition = BabyCondition.FINEandSLEEPING
        print("Handled by Doctor:: action taken , given medicine")
        print("Reason of Crying :: baby has slight fever ")
    }
}

func testChainOfResponsibility(){
    let baby = Baby()
    let doctor : Doctor = Doctor()
    let mother : Mother = Mother(doctor)
    let fatherTheFirstResponder : Father = Father(mother)
    
    print("lets see who handles a bored baby")
    baby.condition = .BORED
    fatherTheFirstResponder.tryToCalmBabyAndExplainCrying(baby)
    
    print("lets see who handles a hungry baby")
    baby.condition = .HUNGRY
    fatherTheFirstResponder.tryToCalmBabyAndExplainCrying(baby)
    
    print("lets see who handles a sick baby")
    baby.condition = .SICK
    fatherTheFirstResponder.tryToCalmBabyAndExplainCrying(baby)
}

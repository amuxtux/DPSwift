//
//  Composite.swift
//  DPSwift
//
//  Created by Amit Singhai on 4/27/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import Foundation

class ComputerComponent{
    let name : String
    var parts  : [ComputerComponent]?
    
    fileprivate init(_ name : String) {
        self.name = name
        self.parts = nil
    }
    
    func addPart(aPart : ComputerComponent){
        //check if child list is nil than create a new list
        self.parts = self.parts ?? [ComputerComponent]()
        self.parts?.append(aPart)
    }
    
    func powerOn(){
        if let childParts = parts {
            for aPart in childParts{
               aPart.powerOn()
            }
        }
        print("\(name) powered on ")
    }
    
    func powerOff(){
        if let childParts = parts {
            for aPart in childParts{
                aPart.powerOff()
            }
        }
        print("\(name) powered off ")
    }
    
}


class Computer : ComputerComponent{

    override init(_ name : String ){
        super.init(name)
        self.addPart(aPart: ComputerComponent("SSD(256)"))
        self.addPart(aPart: ComputerComponent("Process(i7)"))
        self.addPart(aPart: ComputerComponent("Motherboard"))
        self.addPart(aPart: ComputerComponent("RAM"))
    }
}

func testComposite(){

    let macBookPro : ComputerComponent = Computer("Apple Mac Book Pro")
    macBookPro.powerOn()
    macBookPro.powerOff()
}

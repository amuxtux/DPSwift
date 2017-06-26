//
//  Command.swift
//  DPSwift
//
//  Created by Amit Singhai on 4/27/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import Foundation


//Command interface
protocol Command{
    func execute()
}

enum ApplianceState{
  case ON , OFF, HIGHPOWER, LOWPOWER
}

//Receiver
class Appliance{
    
    private var state:ApplianceState = ApplianceState.OFF
    
    func powerOn(){
      state = ApplianceState.ON;
      print("appliance is On with default setting")
    }
    func powerOff(){
        state = ApplianceState.OFF;
        print("appliance is Off")
    }
    func setOnHighPower(){
        if state == .OFF{
          return
        }
        state = ApplianceState.HIGHPOWER;
        print("appliance is now moving fast")
    }
    func setOnLowPower(){
        if state == .OFF{
            return
        }
        state = ApplianceState.LOWPOWER;
        print("appliance is now moving slowly")
    }
}

//Concrete Commands
class OnCommand : Command{
    //reference to the receiver which is Appliance
    let reciever : Appliance
    
    init(appliance:Appliance) {
        self.reciever = appliance
    }
    
    func execute(){
        reciever.powerOn()
    }
}

class OffCommand : Command{
    //reference to the receiver which is Appliance
    let reciever : Appliance
    
    init(appliance:Appliance) {
        self.reciever = appliance
    }
    
    func execute(){
        reciever.powerOff()
    }
}

class MoveFastCommand : Command{
    //reference to the receiver which is Appliance
    let reciever : Appliance
    
    init(appliance:Appliance) {
        self.reciever = appliance
    }
    
    func execute(){
        reciever.setOnHighPower()
    }
}

class MoveSlowCommand : Command{
    //reference to the receiver which is Appliance
    let reciever : Appliance
    
    init(appliance:Appliance) {
        self.reciever = appliance
    }
    
    func execute(){
        reciever.setOnLowPower()
    }
}

//Invoker
class ControlPanel{
    private var commands: [String:Command] = [String:Command]()
    
    func addACommand(command:Command , name :String ){
      self.commands[name] = command;
    }
    
    func pressButton(withLabel : String){
       commands[withLabel]!.execute();
    }
}

//Client : Client could be a class , here this test code acts as client
func testCommandPattern(){
    
    let fan : Appliance = Appliance()
    let controlPanel : ControlPanel = ControlPanel()
    controlPanel.addACommand(command: OnCommand(appliance: fan), name: "on")
    controlPanel.addACommand(command: OffCommand(appliance: fan), name: "off")
    controlPanel.addACommand(command: MoveFastCommand(appliance: fan), name: "high")
    controlPanel.addACommand(command: MoveSlowCommand(appliance: fan), name: "low")
    
    controlPanel.pressButton(withLabel: "on")
    controlPanel.pressButton(withLabel: "high")
    controlPanel.pressButton(withLabel: "low")
    controlPanel.pressButton(withLabel: "off")

}


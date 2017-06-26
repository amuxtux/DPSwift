//
//  Flyweight.swift
//  DPSwift
//
//  Created by Amit Singhai on 4/27/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import Foundation

//instance of this class would be shared among many objects
class RaceTheme{
    let raceName : String
    let raceLogo : String
    let hullPaintColor : String
    let engineExhaustColor : String
    
    init(name:String,logo:String,hullColor:String, exhaustColor:String) {
        self.raceName = name
        self.raceLogo = logo
        self.hullPaintColor = hullColor
        self.engineExhaustColor = exhaustColor
    }
}

class Ship {
    let raceTheme : RaceTheme
    var health : Int = 100
    var fuel : Int = 100
    
    init(raceTheme : RaceTheme){
        self.raceTheme = raceTheme
    }
    func fire(){
    }
    
    func move(){
      self.fuel -= 1
    }
}

class FighterCraft : Ship{

}

class CarrierCraft : Ship {

    var dockedShips : Int = 0;
    
    func dockShip() {
      self.dockedShips += 1
    }
    
    func launchShip() {
        self.dockedShips -= 1
    }

}

class ThemeStore{
    static var allRaceThemes : [String : RaceTheme] = [String : RaceTheme]()
    
    static func getThemeForRace(raceName : String) -> RaceTheme? {
        
        
        switch raceName {
        case "human":
            if let alreadyAvailableTheme = allRaceThemes[raceName] {
               print("using flyweight for human race theme")
               return alreadyAvailableTheme
            }else {
               let humanTheme  = RaceTheme(name: raceName, logo: "Earth.png", hullColor: "blue", exhaustColor: "white")
               allRaceThemes[raceName] = humanTheme
                print("first time access, creating human race theme")
               return humanTheme
            }
        case "beast":
            if let alreadyAvailableTheme = allRaceThemes[raceName] {
                print("using flyweight for beast race theme")
                return alreadyAvailableTheme
            }else {
                let beastTheme  = RaceTheme(name: raceName, logo: "Skull.png", hullColor: "gray", exhaustColor: "red")
                allRaceThemes[raceName] = beastTheme
                print("first time access, creating human race theme")
                return beastTheme
            }
        default:
            return nil
        }
    }
}

protocol Shipard{

   func buildCarrier() -> CarrierCraft
   func buildFighter() -> FighterCraft
}

class HumanRaceShipyard : Shipard{
    func buildCarrier() -> CarrierCraft{
       return CarrierCraft(raceTheme: ThemeStore.getThemeForRace(raceName: "human")!)
    }
    func buildFighter() -> FighterCraft {
      return FighterCraft(raceTheme: ThemeStore.getThemeForRace(raceName: "human")!)
    }
}

class BeastRaceShipyard : Shipard{
    func buildCarrier() -> CarrierCraft{
        return CarrierCraft(raceTheme: ThemeStore.getThemeForRace(raceName: "beast")!)
    }
    func buildFighter() -> FighterCraft {
        return FighterCraft(raceTheme: ThemeStore.getThemeForRace(raceName: "beast")!)
    }
}


func testFlyweight(){
    let humanShipyard : HumanRaceShipyard = HumanRaceShipyard()
    let beastShipyard : BeastRaceShipyard = BeastRaceShipyard()
    
    var humanFleet : [Ship] = []
    var beastFleet : [Ship] = []
    
    humanFleet.append( humanShipyard.buildCarrier() )
    humanFleet.append(humanShipyard.buildFighter() )
    humanFleet.append(humanShipyard.buildFighter() )
    humanFleet.append(humanShipyard.buildFighter() )
    humanFleet.append(humanShipyard.buildFighter() )
    
    beastFleet.append( beastShipyard.buildCarrier() )
    beastFleet.append( beastShipyard.buildFighter() )
    beastFleet.append( beastShipyard.buildFighter() )
    beastFleet.append( beastShipyard.buildFighter() )
    
    print("human fleet size \(humanFleet.count) Vs beast fleet size \(beastFleet.count)")
  
}

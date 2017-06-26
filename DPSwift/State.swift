//
//  State.swift
//  DPSwift
//
//  Created by Amit Singhai on 4/27/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import Foundation


protocol SelfRotatingPlanet{
   func rotateOnAxis()
}

protocol State{
    func next(planet : Planet)
}

class Planet : SelfRotatingPlanet{
    var state : State {
        willSet {
            print("Its \(String(describing: type(of:state)))")
            print("Its going to be \(String(describing: type(of:newValue)))")
        }
    }

    init() {
        self.state = Morning()
    }
    
    internal func rotateOnAxis() {
        self.state.next(planet:self)
    }
}

class Morning : State{
    internal func next(planet: Planet) {
        planet.state = Afternoon()
    }
}

class Afternoon : State{
    internal func next(planet: Planet) {
        planet.state = Evening()
    }
}

class Evening : State{
    internal func next(planet: Planet) {
        planet.state = Night()
    }
}

class Night : State{
    internal func next(planet: Planet) {
        planet.state = Morning()
    }
}

func testState(){

    let earth = Planet()
    earth.rotateOnAxis()
    earth.rotateOnAxis()
    earth.rotateOnAxis()
    earth.rotateOnAxis()
    
}


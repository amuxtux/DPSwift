//
//  Memento.swift
//  DPSwift
//
//  Created by Amit Singhai on 4/27/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import Foundation

class Memento {
    let state:String
    
    init(state:String) {
       self.state = state
    }
    
}

class Originator {
    var state:String
    
    init(state:String) {
        self.state = state
    }
    
    func setState(state:String){
       print("Originator:: set state = " + state)
       self.state = state
    }
    
    func getState() -> Memento {
        print("Originator:: creating memento with state = " + state)
        return Memento(state: self.state)
    }
    
    func restore(memento : Memento) {
       state = memento.state
       print("Originator:: restored from memento to state = " + state)
    }
}

class Caretaker {
    var  mementos : [Memento] = []
    
    func addMemento(memento : Memento) {
       mementos.append(memento)
    }
    
    func  getMemento() -> Memento {
       
       return mementos.popLast()!
    }
}


func testMemento() {
    let caretaker =  Caretaker()
    let originator =  Originator(state: "State1:RED")
    originator.setState(state:"State2:BLUE")
    originator.setState(state:"State3:GREEN")
    caretaker.addMemento( memento: originator.getState() )
    originator.setState(state: "State4:GRAY");
    caretaker.addMemento( memento: originator.getState() )
    originator.setState(state: "State5:ORANGE");
    originator.restore( memento: caretaker.getMemento() )
    originator.restore( memento: caretaker.getMemento() )
}

//
//  Protocol.swift
//  DPSwift
//
//  Created by Amit Singhai on 4/15/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import Foundation

//if required NSCopying can be used
class CustomButton {

    var colorHex:Int = 0x00ff00  //green
    var borderRadius : Int = 5 //round corner
    var buttonTitle : String = "Go"
    var clickHandler : (Void) -> (Void)
    
    init( clickClosure:@escaping (Void) -> (Void)) {
        self.clickHandler = clickClosure
    }
    
    func cloneWithActionHandler(clickClosure:@escaping (Void) -> (Void)) -> CustomButton {
        //all remaining properties remain the same
        let aButton = CustomButton(clickClosure: clickClosure)
        return aButton
    }
    
    func touchupInside(){
       self.clickHandler()
    }

}

func testPrototype(){

    let searchButton = CustomButton(clickClosure: {
      print("search button clicked")
    })
    
    let signupButton = searchButton.cloneWithActionHandler (clickClosure: { (Void) -> (Void) in
        print("signup button clicked")
    })
    signupButton.buttonTitle = "Signup"
    
    searchButton.touchupInside()
    signupButton.touchupInside()
}

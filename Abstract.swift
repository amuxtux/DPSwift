//
//  Abs.swift
//  DPSwift
//
//  Created by Amit Singhai on 5/4/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import Foundation

protocol ItemFactory {
  func createItem()
}

class AbstractItemFactory : ItemFactory{

    func gatherRawMaterial(){
      //emtpy body
    }
    func createComponents(){
        //emtpy body
    }
    func assembleComponents(){
        //emtpy body
    }
    
    //compelte method for some factories, partial for others
    // mark it final if no modifications allowed
    func createItem() {
        gatherRawMaterial()
        createComponents()
        assembleComponents()
        print("item created")
    }
    
    //private designated initializer
    fileprivate init(){
    }
}
class TelevisionFactory : AbstractItemFactory{
    
    override func gatherRawMaterial(){
        print("gather pcb, chips, screen etc.")
    }
    override func createComponents(){
        print("create mother board, display unit, power unit etc.")
    }
    
    override func assembleComponents(){
        print("assembled Television")
    }
    
    
    //private designated initializer
    override init(){
        super.init()
    }
}


class WoodenChairFactory : AbstractItemFactory{
    
    override func gatherRawMaterial(){
        print("gather wooden pieces, machines, nails etc.")
    }
    override func createComponents(){
        print("created chair parts")
    }
    
    override func assembleComponents(){
        print("assembled chair")
    }
    
    //extra code in derived classe's method
    override func createItem() {
        super.createItem()
        print("chair painted")
    }
    //private designated initializer
    override init(){
        super.init()
    }
}





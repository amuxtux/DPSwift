//
//  Iterator.swift
//  DPSwift
//
//  Created by Amit Singhai on 4/27/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import Foundation


var myArray = [1,2,3,4,5,6,7,8]

var myArrayIterator = myArray.makeIterator()

func testIterator(){
    while let anItem = myArrayIterator.next() {
        print(anItem)
    }
}


//
//  Facade.swift
//  DPSwift
//
//  Created by Amit Singhai on 4/27/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import Foundation

let MAX_SCREEN_WIDTH : UInt32 = 50
let MAX_SCREEN_HEIGHT : UInt32 = 50


protocol ChildBubbleInteface{
    func addBubble()
    func burstBubble(x:Int, y:Int)
}
//sub system 1
protocol RandomizerServiceInterface{
    //bound to screen rect
    func getRandomLocation() -> (x:Int,y:Int)
    func getRandomSize() -> Int
    
}

class RandomizerService : RandomizerServiceInterface{
    func getRandomLocation() -> (x:Int,y:Int){
        return (Int(arc4random_uniform(MAX_SCREEN_WIDTH)), Int(arc4random_uniform(MAX_SCREEN_HEIGHT)))
    }
    func getRandomSize() -> Int{
       return Int(arc4random_uniform(MAX_SCREEN_WIDTH))
    }
   
}

//sub system 2
protocol MediaPlayerInterface{
    //bound to screen rect
    func play(file : String)
}

class MediaPlayer : MediaPlayerInterface{
    
    func getMediaDirectory() -> String {
       return "~\\document\\audio\\"
    }
    func play(file : String){
        let filePath  = getMediaDirectory() + file
         print("playing file \(filePath)")
    }
}

struct Widget{
    var x : Int
    var y : Int
    var width : Int
    var height : Int
    var radius : Int
    var color : String = "red"

    //for circle drawing
    init(x:Int,y:Int,radius:Int){
        self.x = x
        self.y = y
        self.height = 2*radius
        self.width = 2*radius
        self.radius = radius
    }
    //for rect drawing
    init(x:Int,y:Int,w:Int, h:Int){
        self.x = x
        self.y = y
        self.height = w
        self.width = h
        self.radius = max(w, h)/2
    }
    
}

class Canvas{
    var widgets : [Widget] = [Widget]()
    func drawCircle(atX:Int, atY:Int, radius:Int ) {
        let aBubble = Widget(x:atX,y:atY,radius:radius)
        self.widgets.append(aBubble)
        
        print("a circle drawn at x \(atX) y \(atY) radius \(radius)")
    }
    
    func removeWidgetAtTouchPoint(x:Int,y:Int) -> Bool {
        var count = 0
        for awidget in widgets {
            if x <= (awidget.x + awidget.width) && x >= awidget.x && y <= (awidget.y + awidget.height) && y >= awidget.y{
               widgets.remove(at: count)
                return true
            }else{
              count = count + 1
            }
        }
        return false
    }
}

class ChildGameFacade:ChildBubbleInteface{
    
    let gameCanvas : Canvas
    let randomizerService : RandomizerServiceInterface
    let mediaPlayer : MediaPlayerInterface
    
    init(gc:Canvas,rs:RandomizerServiceInterface,mp:MediaPlayerInterface) {
        self.gameCanvas = gc
        self.randomizerService = rs
        self.mediaPlayer = mp
    }

    //methods for child
    internal func burstBubble(x: Int, y: Int) {
        if self.gameCanvas.removeWidgetAtTouchPoint(x: x, y: y) {
           mediaPlayer.play(file: "boomboom.mp3")
           print("bubble bursted")
        }else{
           mediaPlayer.play(file: "dingding.mp3")
            print("focus baby focus")
        }
    }

    internal func addBubble() {
        let loc : (x:Int, y:Int) = self.randomizerService.getRandomLocation()
        let radius =  self.randomizerService.getRandomSize()
        self.gameCanvas.drawCircle(atX: loc.x, atY: loc.y, radius: radius)
        self.mediaPlayer.play(file: "tringtring.mp3")
    }


}

func playGameWithFacade(){
    let gameCanvas : Canvas =  Canvas()
    let randomizerService : RandomizerServiceInterface = RandomizerService()
    let mediaPlayer : MediaPlayerInterface = MediaPlayer()
    
    let childInterfaceFacade = ChildGameFacade(gc: gameCanvas, rs: randomizerService, mp: mediaPlayer)
    
    childInterfaceFacade.addBubble()
    childInterfaceFacade.addBubble()
    childInterfaceFacade.addBubble()
    childInterfaceFacade.addBubble()
    
    
    childInterfaceFacade.burstBubble(x: randomizerService.getRandomLocation().x, y: randomizerService.getRandomLocation().x)
    childInterfaceFacade.burstBubble(x: randomizerService.getRandomLocation().x, y: randomizerService.getRandomLocation().x)
    childInterfaceFacade.burstBubble(x: randomizerService.getRandomLocation().x, y: randomizerService.getRandomLocation().x)
    childInterfaceFacade.burstBubble(x: randomizerService.getRandomLocation().x, y: randomizerService.getRandomLocation().x)
    childInterfaceFacade.burstBubble(x: randomizerService.getRandomLocation().x, y: randomizerService.getRandomLocation().x)
    
}

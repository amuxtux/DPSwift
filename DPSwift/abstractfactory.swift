//
//  abstractfactory.swift
//  DPSwift
//
//  Created by Amit Singhai on 4/15/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import Foundation

struct Rect{
    var x:Int
    var y:Int
    var width:Int
    var height:Int
}

//product base classes
class UITextLabel{
    var rect:Rect
    var title:String
    fileprivate init(_ title:String, _ rect:Rect) {
        self.title=title
        self.rect=rect
        
    }
}
class UITextEdit{
    var rect:Rect
    var placeHolder:String?

    fileprivate init(_ rect:Rect, _ placeHolder:String) {
        self.rect=rect
        self.placeHolder=placeHolder
    }
}


//product concrete classes
class UIRectCornerTextLabel:UITextLabel{
    
    override init(_ title:String, _ rect:Rect){
       super.init(title, rect)
       print("added rectangular label")
    }
}

class UIRectCornerTextEdit : UITextEdit{
    init(_ rect:Rect) {
        super.init(rect, "please type here")
        print("added rectangular text field")
    }
}

class UIRoundCornerTextLabel:UITextLabel{
    let cornerRadius : Int
    override init(_ title:String, _ rect:Rect){
        self.cornerRadius = 5
        super.init(title, rect)
        print("added found label")
    }
}

class UIRoundCornerTextEdit: UITextEdit{
    let cornerRadius : Int
    init(_ rect:Rect) {
        self.cornerRadius = 6
        super.init(rect, "please type here")
        print("added round text field")
    }
}


//concrete factory(Kit) Interface
protocol UIWdigetFactory{
    func getTextLabel(x:Int, y:Int, width:Int, height:Int, title:String) -> UITextLabel
    func getTextEdit(x:Int, y:Int, width:Int, height:Int) -> UITextEdit
}


//concrete factory(Kit) implementations
//usually
class  RectUIWidgetFactory : UIWdigetFactory{
    
    private static var  _instance: RectUIWidgetFactory? = nil
    
    private init(){
        print("rect widget factory loaded")
    }
    
    public static func instance()  -> UIWdigetFactory{
        if _instance == nil{
           _instance = RectUIWidgetFactory()
        }
        return _instance!
        
    }
    func getTextLabel(x:Int, y:Int, width:Int, height:Int, title:String) -> UITextLabel{
        let rect : Rect = Rect(x:x,y:y,width:width,height:height)
        return UIRectCornerTextLabel(title,rect)
    }
    func getTextEdit(x:Int, y:Int, width:Int, height:Int) -> UITextEdit{
        let rect : Rect = Rect(x:x,y:y,width:width,height:height)
        return UIRectCornerTextEdit(rect)
    }
}

class  RoundUIWidgetFactory : UIWdigetFactory{
    
    private static var  _instance: RoundUIWidgetFactory? = nil
    
    private init(){
        print("round widget factory loaded")
    }
    
    public static func instance()  -> UIWdigetFactory{
        if _instance == nil{
            _instance = RoundUIWidgetFactory()
        }
        return _instance!
        
    }
    func getTextLabel(x:Int, y:Int, width:Int, height:Int, title:String) -> UITextLabel{
        let rect : Rect = Rect(x:x,y:y,width:width,height:height)
        return UIRoundCornerTextLabel(title,rect)
    }
    func getTextEdit(x:Int, y:Int, width:Int, height:Int) -> UITextEdit{
        let rect : Rect = Rect(x:x,y:y,width:width,height:height)
        return UIRoundCornerTextEdit(rect)
    }
}


func testKit(){
    print("framework initializing")
    let rectWidgetKit = RectUIWidgetFactory.instance()
    let roundWdigetKit = RoundUIWidgetFactory.instance()
    
    print("app-1 all widgets rect corner")
    rectCornerThemeApp(rectWidgetKit)
    print("app-2 all widgets round corner")
    roundCornerThemeApp(roundWdigetKit)

}

func rectCornerThemeApp(_ kit:UIWdigetFactory){
    var appWindow : [Any] = []
    let nameLabel = kit.getTextLabel(x: 0, y: 0, width: 50, height: 20,title: " please enter name")
    let nameField = kit.getTextEdit(x: 0, y: 25, width: 50, height: 20)
    let passwordLabel = kit.getTextLabel(x: 0, y: 0, width: 50, height: 20,title: " please enter password")
    let passwordField = kit.getTextEdit(x: 0, y: 25, width: 50, height: 20)
    appWindow.append(nameLabel)
    appWindow.append(nameField)
    appWindow.append(passwordLabel)
    appWindow.append(passwordField)
    print("screen ready")
}

func roundCornerThemeApp(_ kit:UIWdigetFactory){
    var appWindow : [Any] = []
    let nameLabel = kit.getTextLabel(x: 0, y: 0, width: 50, height: 20,title: " please enter name")
    let nameField = kit.getTextEdit(x: 0, y: 25, width: 50, height: 20)
    let passwordLabel = kit.getTextLabel(x: 0, y: 0, width: 50, height: 20,title: " please enter password")
    let passwordField = kit.getTextEdit(x: 0, y: 25, width: 50, height: 20)
    appWindow.append(nameLabel)
    appWindow.append(nameField)
    appWindow.append(passwordLabel)
    appWindow.append(passwordField)
    print("screen ready")
}


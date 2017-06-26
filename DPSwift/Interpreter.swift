//
//  Interpreter.swift
//  DPSwift
//
//  Created by Amit Singhai on 4/27/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import Foundation

protocol  Context {
    func PSTNCall(phoneNumber:String) -> String
    func voipCall(userId:String) -> String
    func chat(toUserId:String, message:String) -> String
}

protocol  Expression {
    func interpret(context:Context) -> String
}

class Messanger : Context{
    
    let loggedInUser = "John"
    
    func PSTNCall(phoneNumber:String) -> String {
        print("calling \(phoneNumber) on telephony network")
        return "ringing tring tring"
    }
    
    func voipCall(userId:String) -> String{
        print("calling \(userId) on data network")
        return "ringing turr turr"
    }
    
    func chat(toUserId:String, message:String) -> String{
        print("opened chat room with \(toUserId) ")
        print("\(loggedInUser) says \(message) ")
        return "message sent"
    }
}

class ChatExpression : Expression{
    
    var toUserId : String
    var message : String
    
    init(to:String, msg:String){
       self.toUserId = to
       self.message = msg
    }
    
    internal func interpret(context: Context) -> String {
       return context.chat(toUserId: toUserId, message: message)
    }
}

class CallExpression : Expression{
    
    var toPhoneNumberOrId : String
    
    init(to:String){
        self.toPhoneNumberOrId = to
    }
    
    internal func interpret(context: Context) -> String {
        
        if self.toPhoneNumberOrId.hasPrefix("+"){
            return context.PSTNCall(phoneNumber: toPhoneNumberOrId)
        }else{
           return context.voipCall(userId: toPhoneNumberOrId)
        }
    }
}

//assuming it interprets voice messages
class InterpreterClient{
    
    let context : Context
    var exp : Expression?
    
    init() {
        self.context = Messanger()
    }

    func interprete(sentence : String ){
        let identifier = sentence.components(separatedBy: " ").last
        
        if sentence.contains("call") {
            exp = CallExpression(to: identifier!)
        } else {
            exp = ChatExpression(to: identifier!, msg: "Hi")
        }
        
        print(exp?.interpret(context: self.context) ?? "Sorry all sessions busy")
    }
}

//client
func testInterpreter(){
    
    let client =  InterpreterClient()
    client.interprete(sentence: "please call Amit")
    
    client.interprete(sentence: "plz call +911234567890")
    
    client.interprete(sentence: "Hi Can you please ping Amit")
}





//
//  factorymethod.swift
//  DPSwift
//
//  Created by Amit Singhai on 4/15/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import Foundation
/*
protocol Parser{
    func parse(strData:String)
}

class JsonParser : Parser{

    func parse(strData:String){
       print("received data \(strData)")
       print("interpred json ")
    }

}

class XmlParser : Parser{
    
    func parse(strData:String){
        print("received data \(strData)")
        print("interpred xml ")
    }
    
}

class MessagePackParser : Parser{
    
    func parse(strData:String){
        print("received data \(strData)")
        print("interpred MessagePack ")
    }
    
}


protocol ApiInvoker{
   func parseAndInterpretResponse(response:String)
   //factory method
    func getParser() -> Parser
}

//subclasses take care of which Class to instantiate
//first subclass
class JsonRestApiInvoker : ApiInvoker{
    func parseAndInterpretResponse(response:String){
       self.getParser().parse(strData: response)
    }
    //factory method impl
    func getParser() -> Parser{
       return JsonParser()
    }
}


//second subclass
class XmlRestApiInvoker : ApiInvoker{
    func parseAndInterpretResponse(response:String){
        self.getParser().parse(strData: response)
    }
    //factory method impl
    func getParser() -> Parser{
        return XmlParser()
    }
}

//third subclass
class MessagePackRestApiInvoker : ApiInvoker{
    func parseAndInterpretResponse(response:String){
        self.getParser().parse(strData: response)
    }
    //factory method impl
    func getParser() -> Parser{
        return MessagePackParser()
    }
}

func dummyJsonService() -> String {
    return "{\"id\":1}"
}

func dummyXmlService() -> String {
    return "<id>1</id>"
}
func dummyMessagePackService() -> String {
    return "81 A2 69 64 01"
}


func testFactoryMethod(){
    //calling api 1
    var apiInvoker:ApiInvoker = JsonRestApiInvoker()
    apiInvoker.parseAndInterpretResponse(response: dummyJsonService())
    
    apiInvoker = XmlRestApiInvoker()
    apiInvoker.parseAndInterpretResponse(response: dummyXmlService())
    
    apiInvoker = MessagePackRestApiInvoker()
    apiInvoker.parseAndInterpretResponse(response: dummyMessagePackService())
   
}
 
 */

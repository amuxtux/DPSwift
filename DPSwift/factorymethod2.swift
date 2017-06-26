//
//  factorymethod.swift
//  DPSwift
//
//  Created by Amit Singhai on 4/15/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import Foundation

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

enum ServiceType {
    case JSON,XML,MESSAGEPACK
}

class ApiInvoker{
    //factory method
    static func parseAndInterpretResponse(response:String, for type:ServiceType){
    
        switch  type{
        case .JSON:
            JsonParser().parse(strData: response)
        case .XML:
            XmlParser().parse(strData: response)
        case .MESSAGEPACK:
            MessagePackParser().parse(strData: response)
        default:
            print("other content types not supported")
        }
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
    ApiInvoker.parseAndInterpretResponse(response: dummyJsonService(), for: ServiceType.JSON)
    //calling api 1
    ApiInvoker.parseAndInterpretResponse(response: dummyXmlService(), for: ServiceType.XML)
    //calling api 3
    ApiInvoker.parseAndInterpretResponse(response: dummyMessagePackService(), for: ServiceType.MESSAGEPACK)
}

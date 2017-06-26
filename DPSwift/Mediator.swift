//
//  Mediator.swift
//  DPSwift
//
//  Created by Amit Singhai on 4/27/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import Foundation

protocol TaxyCustomerMediator{

    //customer side communication
    func registerCustomer(customer:Customer)
    func bookCab(type:String, atLocation:String)
    
    
    //taxi side communication
    func registerTaxi(type:String, taxi:Taxi)
    func acceptBooking(taxiId:Int)
    func available(taxiId:Int)
    func busy(taxiId:Int)
}

protocol TaxiInterface {
    func inComingBooking(forLocation:String)
    func acceptBooking()
}

class Taxi : TaxiInterface{

    let id : Int
    var location : String?
    let mediator : TaxyCustomerMediator
    var isAvailable : Bool = true
    let type : String

    init( id:Int, type:String, taxiService : TaxyCustomerMediator) {
        self.id = id
        self.mediator = taxiService
        self.type = type
        taxiService.registerTaxi(type: type, taxi: self)
    }
    
    func inComingBooking(forLocation:String){
        print("Taxi \(id) :: received notification for booking")
        if forLocation == self.location {
           acceptBooking()
        }
    }
    
    func acceptBooking(){
        print("Taxi \(id) :: accepted booking moving on to customer location")
        self.isAvailable = false
        mediator.acceptBooking(taxiId: self.id)
    }
}

class Customer{
    
    let id : Int
    let mediator : TaxyCustomerMediator

    
    init( id:Int, taxiService : TaxyCustomerMediator) {
        self.id = id
        self.mediator = taxiService
        self.mediator.registerCustomer(customer: self)
    }
    
    func travelFrom(location:String, inCarType:String){
       print("Customer:: calling taxi Service(the mediator)")
       mediator.bookCab(type:inCarType, atLocation:location)
    }
}


class TaxyService : TaxyCustomerMediator{
    

    var customers : [Customer] = []
    var taxies : [String:Taxi] = [String:Taxi]()

    //customer side communication
    func registerCustomer(customer:Customer){
        customers.append(customer)
    }
    func bookCab(type:String, atLocation:String){
        print("TaxiService:: Customer want to book a \(type) cab at \(atLocation)")
        for (preferredType,aTaxi) in taxies{
            if type == preferredType && aTaxi.isAvailable == true {
                print("TaxiService:: found location match calling taxi with id \(aTaxi.id)")
                aTaxi.inComingBooking(forLocation: atLocation)
            }
        }
    }
    
    
    //taxi side communication
    func registerTaxi(type: String, taxi: Taxi) {
        self.taxies[type] = taxi
    }
    func acceptBooking(taxiId:Int){
       print("TaxiService:: taxy \(taxiId) is dispatched to customer ")
    }
    func available(taxiId:Int){
        for (_,aTaxi) in taxies{
            if  aTaxi.id == taxiId {
                aTaxi.isAvailable = true
            }
        }
    }
    func busy(taxiId:Int){
        for (_,aTaxi) in taxies{
            if  aTaxi.id == taxiId {
                aTaxi.isAvailable = false
            }
        }
    }

}

func testMediator(){

    

    let cabMediator = TaxyService()
    let acustomer = Customer(id:1,taxiService:cabMediator)
    
    let miniTaxi  = Taxi(id: 1,type:"mini",taxiService: cabMediator)
    miniTaxi.location = "Electronic City"
    let largeTaxi  = Taxi(id: 2,type:"large",taxiService: cabMediator)
    largeTaxi.location = "Air Port"
    let microTaxi = Taxi(id: 3,type:"micro",taxiService: cabMediator)
    microTaxi.location = "Railway Station"
    
    acustomer.travelFrom(location: "Electronic City", inCarType: "mini")

}



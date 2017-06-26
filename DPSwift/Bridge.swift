//
//  Bridge.swift
//  DPSwift
//
//  Created by Amit Singhai on 4/27/17.
//  Copyright © 2017 Amit. All rights reserved.
//

import Foundation

//this protocol is exposed to user
protocol BrowserBookMarkAbstractionAPI{

    func addBookMark(url:String)
    func showBookMarks() -> [String]
    func removeBookMark(url : String)
}

//here ImplementorAPI may or may not adhere to AbstractionAPI
//this protocol is exposed to concrete provider or vendor
protocol BrowserBookMarkImplementorAPI{
    func persistBookMark(_ url : String)
    func getAllBookMarks() -> [String]
    func deleteBookMark(_ url : String)

}


class BookMarkAbstraction : BrowserBookMarkAbstractionAPI{

    var implementor : BrowserBookMarkImplementorAPI
    
    init(vendor : BrowserBookMarkImplementorAPI) {
        self.implementor = vendor
    }
    
    func addBookMark(url:String){
        implementor.persistBookMark(url)
    }
    func showBookMarks() -> [String]{
        return implementor.getAllBookMarks()
    }
    func removeBookMark(url : String){
        implementor.deleteBookMark(url)
    }
    
}


class LocalBookMarkPersister : BrowserBookMarkImplementorAPI{
    
    var dummyLocalStore = Set<String>()
    
    func persistBookMark(_ url : String){
        dummyLocalStore.insert(url)
        print("bookmark saved locally")
    }
    func getAllBookMarks() -> [String]{
       print("returning all \(dummyLocalStore.count) bookmarks from local db")
       return dummyLocalStore.sorted()
    }
    func deleteBookMark(_ url : String){
       dummyLocalStore.remove(url)
       print("now total bookmarks saved locally = \(dummyLocalStore.count)")
    }
}


class CloudBookMarkPersister : BrowserBookMarkImplementorAPI{
    
    let dummyRESTServer  = DummyRESTServer()
    
    func persistBookMark(_ url : String){
        dummyRESTServer.save(url)
        print("bookmark saved on cloud")
    }
    func getAllBookMarks() -> [String]{
        let retrievedBookMarks = dummyRESTServer.fetchAll()
        print("returning all \(retrievedBookMarks.count) bookmarks from server db")
        return retrievedBookMarks
    }
    func deleteBookMark(_ url : String){
        dummyRESTServer.delete(url)
        let retrievedBookMarks = dummyRESTServer.fetchAll()
        print("now total bookmarks saved on server = \(retrievedBookMarks.count)")
    }
}

class DummyRESTServer{
    
    var dummyDatabase : Set<String> = Set<String>()
    
    func save(_ url : String){
        dummyDatabase.insert(url)
    }
    func fetchAll() -> [String]{
        
        return dummyDatabase.sorted()
    }
    func delete(_ url : String){
        dummyDatabase.remove(url)
    }
}


func testBridgeWithLocalImplementor(){

    let abstractAPI = BookMarkAbstraction(vendor: LocalBookMarkPersister())
    abstractAPI.addBookMark(url: "https://swift.org")
    abstractAPI.addBookMark(url: "https://infosys.com")
    abstractAPI.addBookMark(url: "https://www.facebook.com")
    abstractAPI.showBookMarks()
    abstractAPI.removeBookMark(url: "https://www.facebook.com")
}


func testBridgeWithRemoteImplementor(){
    
    let abstractAPI = BookMarkAbstraction(vendor: CloudBookMarkPersister())
    abstractAPI.addBookMark(url: "https://swift.org")
    abstractAPI.addBookMark(url: "https://infosys.com")
    abstractAPI.addBookMark(url: "https://www.facebook.com")
    abstractAPI.showBookMarks()
    abstractAPI.removeBookMark(url: "https://www.facebook.com")
}

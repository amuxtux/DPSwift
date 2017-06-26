// consider categories or extesions in swift they show some similarity 
//but they are not decorators exactly

protocol LegacyComponentProtocol{

   func greet(toUser: String)
   func addSalutation(toUser: String)
}


class LegacyComponent : LegacyComponentProtocol{
     func greet(toUser: String) {
         print("Hello \(toUser)")
    }

    func addSalutation(toUser:String){
        print("Mr./Ms. \(toUser)")
    }
}

//ModernComponet as decorator to legacy component

class ModernComponent : LegacyComponentProtocol{
    internal func greet(toUser: String) {
        legacyComponent.greet(toUser: toUser)
        print(" we welcome you!!")
    }

   let legacyComponent : LegacyComponentProtocol

   init(_ aLegacyComponent:LegacyComponentProtocol){
       self.legacyComponent = aLegacyComponent
   }

    func addSalutation(toUser:String){
        print("Dr./")
        legacyComponent.addSalutation(toUser: toUser)
    }
}

func testDecorator(){
    let aLegacyComponent = LegacyComponent()
    let modernComponent = ModernComponent(aLegacyComponent)

    print("legacy greeting .......")
    aLegacyComponent.greet(toUser : "Stuti")
    print("decorated greeting .......")
    modernComponent.greet(toUser : "Stuti")
    print("legacy salutations .......")
    aLegacyComponent.addSalutation(toUser : "Stuti")
    print("decorated salutations .......")
    modernComponent.addSalutation(toUser : "Stuti")
}






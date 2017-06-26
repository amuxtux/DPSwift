//create complex object
import Foundation


protocol MealBuilder {
    func prepareTray()
    func addDrink()
    func addMajor()
    func addMinor()
    func addExtra()
    func buildMeal()
}

//abstract class emulation
class AbstractMealBuilder : MealBuilder{
    
    var orderNumber : String
    
    init(_ orderNum:String) {
        self.orderNumber = orderNum
    }
    
    internal func addMinor() {
        //do nothing
    }

    internal func addDrink() {
        //do nothing
    }

    //full implementation of method
    internal func buildMeal()  {
        prepareTray()
        addDrink()
        addMajor()
        addMinor()
        addExtra()
        print("meal ready for order number \(orderNumber)")
    }

    internal func addExtra() {
        
    }

    internal func addMajor() {
        //do nothing
    }

    //full implementation of method, for any kind of meal
    internal func prepareTray() {
        print("fetch a tray")
        print("put branding paper")
        print("put paper towels")
    }
}

//first crew as AdultMealBuilder
class AdultMealBuilder : AbstractMealBuilder{
  
    override init(_ orderNum:String) {
        super.init(orderNum)
    }
    
    override func addDrink() {
        print("add Pepsi")
    }
    
    override func addMajor() {
        print("add Burger with spicy sauce")
    }
    
    override func addMinor(){
       print("add french fries")
    }
}

//first crew as AdultMealBuilder
class KidsMealBuilder : AbstractMealBuilder{
    
    override init(_ orderNum:String) {
        super.init(orderNum)
    }
    
    override func addDrink() {
        print("add Mango juice")
    }
    
    override func addMajor() {
        print("add Burger with spicy Sauce")
    }
    
    override func addMinor(){
        print("add french fries")
    }
    
    override func addExtra() {
        print("add a toy gift")
    }
}

class Director{
    
    static func getMeal(mealFor:String) {
        
        switch mealFor {
        case "kid":
            let orderNum = "Kid_\(arc4random())"
             KidsMealBuilder(orderNum).buildMeal()
        case "adult":
            let orderNum = "Adult_\(arc4random())"
            AdultMealBuilder(orderNum).buildMeal()
        default:
            print("NA")
        }
    }
    
}

func builderTest(){
   Director.getMeal(mealFor: "kid")
   Director.getMeal(mealFor: "adult")
}

/**
class RoomReservation{
    var startDateTime:Date
    var endDateTime:Date
    var venue:String
    var agenda:String?
    var chairPerson:String
    
    init(begin:Date , end:Date, venue:String, owner:String) {
        self.startDateTime = begin
        self.endDateTime = end
        self.venue = venue
        self.chairPerson = owner
        self.agenda = "Meeting with \(self.chairPerson)"
    }
}
*/

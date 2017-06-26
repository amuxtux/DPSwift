//  Write some awesome Swift code, or import libraries like "Foundation",
//  "Dispatch", or "Glibc"


protocol Observer{
    func update(_ eventData:String)
}

protocol Subject{

    func registerAnObserver(_ anObserver:Observer)
    func unRegisterAnObserver(_ anObserver:Observer)
    
}

class IOSBuildAndReleaseBot : Subject {
    //list of observers which are observing me 
    var myObservers : [Observer]
    
    var eventData : String {
        willSet {
            // implement it if you want to notify your observer prior to change
            print("Apple:: about to release \(newValue)")
        }
        
        didSet {
            for anObserver in myObservers{
                anObserver.update(eventData)
            }
        }
    }
    
    
    init() {
        self.myObservers = []
        self.eventData = ""
    }
    
    //MARK:- Observer methods
    func registerAnObserver(_ anObserver:Observer){
        myObservers.append(anObserver)
    }

    func unRegisterAnObserver(_ anObserver:Observer){
       // remove the observer from array
    }


}

class IOSDeveloper : Observer{
    func update(_ eventData:String){
        print("DEVELOPER:: i should update my app for \(eventData) soon ")
    }
}

class UXDesigner : Observer{
    func update(_ eventData:String){
        print("DESIGNER:: i should check new UI widges in  \(eventData) and update my designs ")
    }
}

func testObserver(){
   let iosReleaseNewsBot : IOSBuildAndReleaseBot = IOSBuildAndReleaseBot()

   let amit : IOSDeveloper = IOSDeveloper()

   let maria : UXDesigner = UXDesigner()

   iosReleaseNewsBot.registerAnObserver(amit)
   iosReleaseNewsBot.registerAnObserver(maria)

   var currentRelease : String = "10.1"
   // ios 10.1 release
   iosReleaseNewsBot.eventData = currentRelease
   currentRelease = "10.2"
   iosReleaseNewsBot.eventData = currentRelease
   currentRelease = "11.0"
   iosReleaseNewsBot.eventData = currentRelease
}



/*

Swift Ver. 3.1 (Release)
Platform: Linux (x86_64)

i should update my app for 10.1 soon 
i should check new UI widges in  10.1 and update my designs 
i should update my app for 10.2 soon 
i should check new UI widges in  10.2 and update my designs 
i should update my app for 11.0 soon 
i should check new UI widges in  11.0 and update my designs

*/

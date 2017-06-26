
class AppModel{
    private static var  _instance:AppModel? = nil
    
    private var email:String
    private var buddies:[String]
    
    private init(){
        email = ""
        buddies = []
        print("initializing...it should be printed only once")
    }
    
    public static func getAppModelSharedInstance() -> AppModel {
        if AppModel._instance == nil{
            _instance =  AppModel()
        }
        return _instance!
    }
    
    public func addBuddie(_ abuddyEmail:String){
        self.buddies.append(abuddyEmail)
    }
    public func setEmail(_ email:String){
        self.email = email
    }
    
    public func getEmail() -> String {
        return self.email
    }
    
    public func getBuddies() -> [String] {
        return self.buddies
    }
    
}

func testSingleTon(){
    
    AppModel.getAppModelSharedInstance().setEmail("a@a.com")
    print(AppModel.getAppModelSharedInstance().getEmail())
    
    AppModel.getAppModelSharedInstance().addBuddie("b@a.com")
    AppModel.getAppModelSharedInstance().addBuddie("c@a.com")
    
    print(AppModel.getAppModelSharedInstance().getBuddies())
    print(AppModel.getAppModelSharedInstance().getEmail())
}



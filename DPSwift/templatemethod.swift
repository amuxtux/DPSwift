
struct ReqComponents{
    var url:String
    var type:String = "GET"
    var body:String?
    var headers: [String:String]?

    init(withUrl:String){
      self.url = withUrl
    }
}

class DummyServer{

    public static func performHttpRequest(request:ReqComponents) -> (Int,String){
        
        let apiPath = request.url.components(separatedBy: "/").last ?? ""
        
        switch apiPath {
        case "signin":
            return signInAPI(request: request)
        case "signout":
            return signOutAPI(request: request)
        case "static":
            return getAppData(request: request)
        default:
            return (400, "check request please")
        }
    }

    private static func signInAPI(request:ReqComponents) -> (Int,String){
        return (200, "user signed in")
    }
    private static func signOutAPI(request:ReqComponents) -> (Int,String){
        return (200, "user signed out")
    }
    private static func getAppData(request:ReqComponents) -> (Int,String){
        return (200, "{'color':'red', 'background':'a.png', 'font':'arial' }")
    }
}


class HttpRequestSender{
    //steps
    func getUrl() -> String { return "" }
    func getType() -> String {return "GET"}
    func getHeaders() -> [String:String]? {return nil}
    func getBody() -> String? {return nil }
    
    //template method
    func prepareAndSend() -> (Int,String) {
         var requestComponents : ReqComponents = ReqComponents(withUrl: getUrl())
         requestComponents.type = getType()
         requestComponents.body = getBody()
         requestComponents.headers = getHeaders()
        let response : (status:Int,  body:String) = DummyServer.performHttpRequest(request:requestComponents)
        
        print("http response \(response.body)")
        return response
    }
}


//derived classes
class StaticDataRequestSender : HttpRequestSender{
     override func getUrl() -> String { return "http://localhost:3000/static" }
}

class SignInRequestSender : HttpRequestSender{
     override func getUrl() -> String { return "http://localhost:3000/signin" }
     override func getHeaders() -> [String:String]? {
         var hdrs : [String:String] = [:]
         hdrs["user"] = "Stuti"
         hdrs["password"] = "123456"
         return hdrs
     }
}

class SignoutRequestSender : HttpRequestSender{
    override func getUrl() -> String { return "http://localhost:3000/signout" }
    override func getHeaders() -> [String:String]? {
        var hdrs : [String:String] = [:]
        hdrs["user"] = "Stuti"
        return hdrs
    }
}

//test function by calling template method 
func testTemplateMethod(){
     StaticDataRequestSender().prepareAndSend()
     SignInRequestSender().prepareAndSend()
     SignoutRequestSender().prepareAndSend()
}


/*
 
 There are some objects and methods we would like to protect from unwanted calls such as
 a persistence service class loads and returns data in form of model classes from a database for a given sql. Since this object
 does lot of io , sql result parsing , preparing model class object etc we do not want unautorized user access this object,
 also we would like to control the access in case the given parameters or sql is malformed in such cases we use
 another object which surrogates this critical object and becomes an interface to the caller or clients.
 This surrogate class / object is called proxy.
 Proxy can be very helpful in filtering, caching responses, authentication and autorization even sometimes in load
 balancing.
 As per GoF , proxy pattern is defined as : Provide a surrogate or placeholder for another object to control access to it.
 
 Proxy feels similar to wrapper or adapter but its not , the motive behine proxy is to provide access control where
 adapter's motive is to provide a common way to interact between two different interfaces.
 */
import Foundation

protocol API{
    func executeJob(_ inputParam: String ) -> String
}

class JobExecutor : API{

     func executeJob(_ inputParam: String) -> String {
          print("Executor executing job with "+inputParam)
          return "running "+inputParam
     }
}

//enforce policy, authentication, access control , resouce locking and tracing etc
class Proxy : API{
     //proxy usually own refernce to object its wrapping up
     let criticalExecutor : JobExecutor = JobExecutor()
     
     func isRequestAllowedInCurrentHour() -> Bool{
         let hour = Calendar.current.component(.hour, from: Date())
         if hour >= 9 && hour <= 17 {
             return true
         }
         return false
     }

     func executeJob(_ inputParam: String) -> String {
          print("proxy trying to executing job :: "+inputParam)

          if isRequestAllowedInCurrentHour() == true {
              return criticalExecutor.executeJob(inputParam)
          }else {
              return "Please call between 9AM to 5Pm"
          }
          
     }
}

func testProxy(){
   let clientProxy = Proxy()
   let result =  clientProxy.executeJob("purchage order for item id=3 ")
   print(result)

}





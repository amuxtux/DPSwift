
import Foundation

/*
 Adapter is also knows as wrapper. This is one of the most used patterns across software engineering
 verticals. As name suggests it adapts between a given protocol and the one caller or client
 expects. A very classical example of adapter in real life is power adapter for electrical devices.
 A smart phone power adapter adapts between 220 Volt AC to 5 volt DC.
 In software field there are numerous examples of adapter pattern some are listed below
 1. in iOS table view data source adapts from view controller owned arrays or dictionaries to the table view constructs.
 2. in Android ArrayListAdapter do the same job which data sources does in iOS
 3. on server side Spring JDBC adapter wraps the native java db calls
 4. Java Persistence API (JPA) is a generic wrapper for many ORM frameworks such as hibernate, eclipse link etc
 
 for a sample implementation we will take example of a table view and see how it prepares and presents data in UI.
 
 TableView : its a class having many TableRow instances
 TableRow :  protocol to present a label on ui as a row in TableView,
 ConcreteTableRow : presents a String in that TableRow the presented string is left aligned to the screen.
 TableView and TableRow are unchangable
 
 we first present existing code and later adapt the code to new data model.
 */
protocol TableRow{
    func show()
}

//unchangable legacy class
class ConcreteTableRow : TableRow{
    var label : String
    init(_ rowData:String){
        self.label = rowData
    }
    
     func show(){
        print(" \(label) ")
    }
}

//unchangable legacy class
class TableView{
    var tableRows : [ConcreteTableRow] = []
    
    func showDataOnUI(){
        print("=====TableViewUI=====")
        for aTableRow in tableRows {
            aTableRow.show()
        }
    }
}

func runApplication(){
    print("without adapter legacy code.....")
    let tableView = TableView()
    tableView.tableRows.append(ConcreteTableRow("b1@acomp.com"))
    tableView.tableRows.append(ConcreteTableRow("b2@acomp.com"))
    tableView.tableRows.append(ConcreteTableRow("b3@acomp.com"))
    tableView.showDataOnUI()
}

class ApplicationModel{
    static var  _instance:ApplicationModel? = nil
    var buddies:[String:[String:String]]
    
    private init(){
        buddies = [String:[String:String]]()
        buddies["b1@acomp.com"] = ["name":"Jone Doe","phone":"+911122334455"]
        buddies["b2@acomp.com"] = ["name":"Jane Doe","phone":"+911122334456"]
        buddies["b3@acomp.com"] = ["name":"Amit Singhai","phone":"+911122334457"]
    }
    public static func getAppModelSharedInstance() -> ApplicationModel {
        if ApplicationModel._instance == nil{
            _instance =  ApplicationModel()
        }
        return _instance!
    }
}

class ConcreteRowAdapter : TableRow {
    var underlyingLegacyRow :ConcreteTableRow
    var dataToAdapt : [String:String]
    
    //new interface takes a dictionary having contact details
    init(_ rowData:[String:String]){

        self.dataToAdapt = rowData
        let label = "\(self.dataToAdapt["name"]!) , \((self.dataToAdapt["phone"]!) )"
        underlyingLegacyRow = ConcreteTableRow(label)
    }
    
     func show(){
        print(" \(underlyingLegacyRow.label) ")
    }
}

func runApplicationWithAdapter(){
    print("with adapter between new interface and legacy TableRows.....")
    let tableView = TableView()
    let appModel = ApplicationModel.getAppModelSharedInstance()
    tableView.tableRows.append(ConcreteRowAdapter(appModel.buddies["b1@acomp.com"]!).underlyingLegacyRow)
    tableView.tableRows.append(ConcreteRowAdapter(appModel.buddies["b2@acomp.com"]!).underlyingLegacyRow)
    tableView.tableRows.append(ConcreteRowAdapter(appModel.buddies["b3@acomp.com"]!).underlyingLegacyRow)

    tableView.showDataOnUI()
}


func testAdapter(){
    runApplication()
    runApplicationWithAdapter()
}

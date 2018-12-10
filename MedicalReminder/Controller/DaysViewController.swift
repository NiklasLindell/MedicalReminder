import UIKit
import CoreData

class DaysViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var daysTableView: UITableView!
    
    var daysCell: String = "daysCell"
    
    let days: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CheckedDay.monday = false
        CheckedDay.tuesday = false
        CheckedDay.wednesday = false
        CheckedDay.thursday = false
        CheckedDay.friday = false
        CheckedDay.saturday = false
        CheckedDay.sunday = false
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: daysCell, for: indexPath)
        
        cell1.textLabel?.text = days[indexPath.row]
        cell1.textLabel?.textColor = UIColor.white
        cell1.textLabel?.font = UIFont(name: "Hiragino Sans", size: 20)
        cell1.selectionStyle = .none
        
        return cell1
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            
            if(indexPath.row == 0){
                
                CheckedDay.monday = false
            }
            if(indexPath.row == 1){
                
                CheckedDay.tuesday = false
            }
            if(indexPath.row == 2){
                
                CheckedDay.wednesday = false
            }
            if(indexPath.row == 3){
                
                CheckedDay.thursday = false
            }
            if(indexPath.row == 4){
                
                CheckedDay.friday = false
            }
            if(indexPath.row == 5){
                
                CheckedDay.saturday = false
            }
            if(indexPath.row == 6){
                
                CheckedDay.sunday = false
            }
            
            
        } else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            
            if(indexPath.row == 0){
                
                CheckedDay.monday = true
            }
            if(indexPath.row == 1){
               
                 CheckedDay.tuesday = true
            }
            if(indexPath.row == 2){
                
                CheckedDay.wednesday = true
                
            }
            if(indexPath.row == 3){
          
                CheckedDay.thursday = true
            }
            if(indexPath.row == 4){
      
                CheckedDay.friday = true
            }
            if(indexPath.row == 5){
           
                CheckedDay.saturday = true
            }
            if(indexPath.row == 6){
        
                CheckedDay.sunday = true
            }
        }
        
    }
    
}

struct CheckedDay {
    static var monday: Bool = false
    static var tuesday: Bool = false
    static var wednesday: Bool = false
    static var thursday: Bool = false
    static var friday: Bool = false
    static var saturday: Bool = false
    static var sunday: Bool = false
}




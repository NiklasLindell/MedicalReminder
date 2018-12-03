import UIKit
import CoreData

class DaysViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var daysTableView: UITableView!
    
    var daysCell: String = "daysCell"
    
    let days: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var checked: [Bool] = [false, false, false, false, false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                let unChecked = false
                CheckedDay.monday = unChecked
            }
            if(indexPath.row == 1){
                let unChecked = false
                CheckedDay.tuesday = unChecked
            }
            if(indexPath.row == 2){
                let unChecked = false
                CheckedDay.wednesday = unChecked
            }
            if(indexPath.row == 3){
                let unChecked = false
                CheckedDay.thursday = unChecked
            }
            if(indexPath.row == 4){
                let unChecked = false
                CheckedDay.friday = unChecked
            }
            if(indexPath.row == 5){
                let unChecked = false
                CheckedDay.saturday = unChecked
            }
            if(indexPath.row == 6){
                let unChecked = false
                CheckedDay.sunday = unChecked
            }
            
            
        } else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            
            if(indexPath.row == 0){
                let checked = true
                CheckedDay.monday = checked
            }
            if(indexPath.row == 1){
                let checked = true
                 CheckedDay.tuesday = checked
            }
            if(indexPath.row == 2){
                let checked = true
                CheckedDay.wednesday = checked
                
            }
            if(indexPath.row == 3){
                let checked = true
                CheckedDay.thursday = checked
            }
            if(indexPath.row == 4){
                let checked = true
                CheckedDay.friday = checked
            }
            if(indexPath.row == 5){
                let checked = true
                CheckedDay.saturday = checked
            }
            if(indexPath.row == 6){
                let checked = true
                CheckedDay.sunday = checked
            }
        }
        
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
        print("Mån \(CheckedDay.monday)")
        print("Tis \(CheckedDay.tuesday)")
        print("Ons \(CheckedDay.wednesday)")
        print("Tor \(CheckedDay.thursday)")
        print("Fre \(CheckedDay.friday)")
        print("Lör \(CheckedDay.saturday)")
        print("Sön \(CheckedDay.sunday)")
        
        
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



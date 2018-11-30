import UIKit
import CoreData

class DaysViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var daysTableView: UITableView!
    
    var daysCell: String = "daysCell"
    
    let days: [String] = ["Måndag", "Tisdag", "Onsdag", "Torsdag", "Fredag", "Lördag", "Söndag"]
    var checked: [Bool] = [false, false, false, false, false, false, false]
    var checkedDays: Int = 0
    
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
                checked[0] = false
            }
            if(indexPath.row == 1){
                checked[1] = false
            }
            if(indexPath.row == 2){
                checked[2] = false
            }
            if(indexPath.row == 3){
                checked[3] = false
            }
            if(indexPath.row == 4){
                checked[4] = false
            }
            if(indexPath.row == 5){
                checked[5] = false
            }
            if(indexPath.row == 6){
                checked[6] = false
            }
            
            
        } else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            
            if(indexPath.row == 0){
                checked[0] = true
            }
            if(indexPath.row == 1){
                checked[1] = true
            }
            if(indexPath.row == 2){
                checked[2] = true
            }
            if(indexPath.row == 3){
                checked[3] = true
            }
            if(indexPath.row == 4){
                checked[4] = true
            }
            if(indexPath.row == 5){
                checked[5] = true
            }
            if(indexPath.row == 6){
                checked[6] = true
            }
        }
        
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
    }
}



import UIKit
import CoreData
import UserNotifications

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var homeTableView: UITableView!
    
    var todaysMedicine: [Medicine] = []
    
    let date = Date()
    let formatter = DateFormatter()
    let homeCell = "homeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        
        homeTableView.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "cell")
        
        let fetchRequest: NSFetchRequest<Medicine> = Medicine.fetchRequest()
        do {
            let medicine = try PersistenceService.context.fetch(fetchRequest)
            medicineList = medicine
            homeTableView.reloadData()
        } catch {}
        
        dayLabel.text = date.toString(dateFormat: "dd")
        monthLabel.text = date.toString(dateFormat: "LLLL")
        weekdayLabel.text = date.toString(dateFormat: "EEEE")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        todaysMedicine = []
        getMedicineForDay()
        homeTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todaysMedicine.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.timeLabel.text = "\(todaysMedicine[indexPath.row].hour):\(todaysMedicine[indexPath.row].minute)"
        cell.nameLabel?.text = todaysMedicine[indexPath.row].name
        cell.amountLabel.text = ("\(todaysMedicine[indexPath.row].quantity)pcs per intake")
        cell.textLabel?.textColor = UIColor.white
//        cell.detailTextLabel?.textColor = UIColor.white
//        cell.textLabel?.font = UIFont(name: "Hiragino Sans", size: 20)
//        cell.detailTextLabel?.font = UIFont(name: "Hiragino Sans", size: 15)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 87
    }

    func getMedicineForDay() {
        
        let dayName = date.toString(dateFormat: "EEEE")
        
        if dayName == "Monday" {
    
            for medicine in medicineList{
                
                if medicine.monday == true {
        
                    if todaysMedicine.contains(medicine){
                        print("Finns redan i listan")
                    }else{
                        todaysMedicine.append(medicine)
                    }
                }
                
            }
   
        }
        if dayName == "Tuesday" {
            for medicine in medicineList{
                
                if medicine.tuesday == true {
                    
                    if todaysMedicine.contains(medicine){
                        print("Finns redan i listan")
                    }else{
                        todaysMedicine.append(medicine)
                    }
                }
                
            }
        }
        if dayName == "Wednesday"{
            for medicine in medicineList{
                
                if medicine.wednesday == true {
                    
                    if todaysMedicine.contains(medicine){
                        print("Finns redan i listan")
                    }else{
                        todaysMedicine.append(medicine)
                    }
                }
                
            }
        }
        if dayName == "Thursday" {
            for medicine in medicineList{
                
                if medicine.thursday == true {
                    
                    if todaysMedicine.contains(medicine){
                        print("Finns redan i listan")
                    }else{
                        todaysMedicine.append(medicine)
                    }
                }
                
            }
        }
        if dayName == "Friday" {
            for medicine in medicineList{
                
                if medicine.friday == true {
                    
                    if todaysMedicine.contains(medicine){
                        print("Finns redan i listan")
                    }else{
                        todaysMedicine.append(medicine)
                    }
                }
                
            }
        }
        if dayName == "Saturday" {
            for medicine in medicineList{
                
                if medicine.saturday == true {
                    
                    if todaysMedicine.contains(medicine){
                        print("Finns redan i listan")
                    }else{
                        todaysMedicine.append(medicine)
                    }
                }
                
            }
        }
        if dayName == "Sunday" {
            for medicine in medicineList{
                
                if medicine.sunday == true {
                    
                    if todaysMedicine.contains(medicine){
                        print("Finns redan i listan")
                    }else{
                        todaysMedicine.append(medicine)
                    }
                }
                
            }
        }
    }
}

extension Date
{
    func toString(dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    
}


import UIKit
import CoreData
import UserNotifications
import MBCircularProgressBar

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var progressCircle: MBCircularProgressBarView!
    
    var todaysMedicine: [Medicine] = []
    var checkedMedicine: CGFloat = 0
    
    let date = Date()
    let formatter = DateFormatter()
    let homeCell = "homeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        
        homeTableView.register(UINib(nibName: "CellForHome", bundle: nil), forCellReuseIdentifier: "cell")
        
        let fetchRequest: NSFetchRequest<Medicine> = Medicine.fetchRequest()
        do {
            let medicine = try PersistenceService.context.fetch(fetchRequest)
            medicineList = medicine
            homeTableView.reloadData()
        } catch {}
        
        dayLabel.text = date.toString(dateFormat: "dd")
        monthLabel.text = date.toString(dateFormat: "LLLL")
        weekdayLabel.text = date.toString(dateFormat: "EEEE")
        self.progressCircle.value = checkedMedicine
    }
    
    override func viewWillAppear(_ animated: Bool) {
        todaysMedicine = []
        getMedicineForDay()
        homeTableView.reloadData()
        self.progressCircle.maxValue = CGFloat(todaysMedicine.count)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.5) {
            self.progressCircle.value = self.checkedMedicine
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todaysMedicine.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        
        if todaysMedicine[indexPath.row].minute < 10{
            cell.timeLabel.text = "\(todaysMedicine[indexPath.row].hour):0\(todaysMedicine[indexPath.row].minute)"
        } else{
            cell.timeLabel.text = "\(todaysMedicine[indexPath.row].hour):\(todaysMedicine[indexPath.row].minute)"
        }
        
        cell.nameLabel?.text = todaysMedicine[indexPath.row].name
        cell.amountLabel.text = ("\(todaysMedicine[indexPath.row].quantity)pcs per intake")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == homeTableView {
            if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
                self.checkedMedicine = self.checkedMedicine - 1
                self.viewDidAppear(true)
                let totalQuantity = todaysMedicine[indexPath.row].totalQuantity
                let newTotalQuantity = totalQuantity + todaysMedicine[indexPath.row].quantity // Changing totalQuantaty for
                medicineList[indexPath.row].totalQuantity = newTotalQuantity                  // object in CoreData
                PersistenceService.saveContext()
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
                self.checkedMedicine = self.checkedMedicine + 1
                self.viewDidAppear(true)
                let totalQuantity = todaysMedicine[indexPath.row].totalQuantity
                let newTotalQuantity = totalQuantity - todaysMedicine[indexPath.row].quantity  // Changing totalQuantaty for
                medicineList[indexPath.row].totalQuantity = newTotalQuantity                   // object in CoreData
                PersistenceService.saveContext()
            }
        }
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


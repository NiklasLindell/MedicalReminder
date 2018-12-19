import UIKit
import CoreData
import UserNotifications
import AudioToolbox
import MBCircularProgressBar

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var progressCircle: MBCircularProgressBarView!
    
    
    var todaysMedicine: [Medicine] = []
    var checkedMedicine: [Medicine] = []
    
    var date = Date()
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
        
        todaysMedicine = []
        getMedicineForDay()
        progressCircleMove()
        homeTableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateDate), userInfo: self, repeats: true)
        
        NotificationCenter.default.addObserver(self, selector:#selector(calendarDayDidChange), name:.NSCalendarDayChanged, object:nil)
        
        progressCircleMove()
        getMedicineForDay()
        homeTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        progressCircleMove()
        
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
        
        if todaysMedicine[indexPath.row].taken == true{
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
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
                AudioServicesPlayAlertSound(1519)
                let totalQuantity = todaysMedicine[indexPath.row].totalQuantity
                let newTotalQuantity = totalQuantity + todaysMedicine[indexPath.row].quantity // Changing totalQuantaty for
                medicineList[indexPath.row].totalQuantity = newTotalQuantity                  // object in CoreData
                todaysMedicine[indexPath.row].taken = false
                progressCircleMove()
                PersistenceService.saveContext()
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
                AudioServicesPlayAlertSound(1519)
                let totalQuantity = todaysMedicine[indexPath.row].totalQuantity
                let newTotalQuantity = totalQuantity - todaysMedicine[indexPath.row].quantity  // Changing totalQuantaty for
                medicineList[indexPath.row].totalQuantity = newTotalQuantity                   // object in CoreData
                todaysMedicine[indexPath.row].taken = true
                progressCircleMove()
                PersistenceService.saveContext()
            }
            
            homeTableView.reloadData()
        }
    }

    func getMedicineForDay() {
        let dayName = date.toString(dateFormat: "EEEE")
        if dayName == "Monday" {
            for medicine in medicineList{
                if medicine.monday == true {
                    if todaysMedicine.contains(medicine){
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
                    }else{
                        todaysMedicine.append(medicine)
                    }
                }
            }
        }
    }
    
    @objc func updateDate(){
        date = Date()
        dayLabel.text = date.toString(dateFormat: "dd")
        monthLabel.text = date.toString(dateFormat: "LLLL")
        weekdayLabel.text = date.toString(dateFormat: "EEEE")
        todaysMedicine = []
        getMedicineForDay()
        homeTableView.reloadData()
        
    }
    @objc func calendarDayDidChange()
    {
        todaysMedicine = []
        progressCircleMove()
    }
    
    func progressCircleMove() {
        self.progressCircle.maxValue = CGFloat(todaysMedicine.count)
        checkedMedicine.removeAll()
        for medicines in todaysMedicine{
            if medicines.taken == true{
                self.checkedMedicine.append(medicines)
            }
        }
        UIView.animate(withDuration: 1.5) {
            self.progressCircle.value = CGFloat(self.checkedMedicine.count)
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


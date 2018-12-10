import UIKit
import CoreData
import UserNotifications

class SaveMedicineViewController: UIViewController {
    
    var quantityShow: Int = 1
    var totalQuantity: Int = 25
    var checkedDayArray: [Int] = []
    let identifire = UUID().uuidString
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalQuantityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quantityLabel?.text = "1st"
        totalQuantityLabel?.text = "25st"
        checkedDayArray = []
        CheckedDayConverter()
    }
    
    @IBAction func minusQuantityButtonPressed(_ sender: UIButton) {
        if quantityShow > 1 {
            quantityShow -= 1
            quantityLabel.text = "\(quantityShow)st"
        }
    }
    
    @IBAction func plusQuantityButtonPressed(_ sender: UIButton) {
        quantityShow += 1
        quantityLabel.text = "\(quantityShow)st"
    }
    
    @IBAction func quantityButton(_ sender: Any) {
        Quantity.newQuantity = quantityShow
    }
    
    @IBAction func minusTotalQuantityButton(_ sender: UIButton) {
        if totalQuantity > 1 {
            totalQuantity -= 1
            totalQuantityLabel.text = "\(totalQuantity)st"
        }
    }
    
    @IBAction func plusTotalQuantityButton(_ sender: UIButton) {
        totalQuantity += 1
        totalQuantityLabel.text = "\(totalQuantity)st"
    }
    
    @IBAction func finishButtonPressed(_ sender: UIButton) {
        
        let medicine = Medicine(context: PersistenceService.context)
        medicine.name = Name.medicineName
        medicine.quantity = Int16(Quantity.newQuantity)
        medicine.totalQuantity = Int16(totalQuantity)
        medicine.monday = CheckedDay.monday
        medicine.tuesday = CheckedDay.tuesday
        medicine.wednesday = CheckedDay.wednesday
        medicine.thursday = CheckedDay.thursday
        medicine.friday = CheckedDay.friday
        medicine.saturday = CheckedDay.saturday
        medicine.sunday = CheckedDay.sunday
        medicine.hour = Int16(Time.hour)
        medicine.minute = Int16(Time.minute)
        medicine.identifire = identifire
        
        PersistenceService.saveContext()
        medicineList.append(medicine)
        setNotificationTime()
        performSegue(withIdentifier: "goToList", sender: self)
        self.dismiss(animated: false, completion: nil)
    }
    
    func setNotificationTime(){
        let content = UNMutableNotificationContent()
        content.title = "Time to take your medicine!"
        content.body = "Go to Medical Reminder and check your medicine"
        content.sound = UNNotificationSound.default
        content.badge = 1
        var dateComponents = DateComponents()
        for days in checkedDayArray{
            dateComponents.weekday = days
            dateComponents.hour = Time.hour
            dateComponents.minute = Time.minute
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: identifire, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    
    func CheckedDayConverter() {
        if CheckedDay.monday == true {
            checkedDayArray.append(2)
        }
        if CheckedDay.tuesday == true {
            checkedDayArray.append(3)
        }
        if CheckedDay.wednesday == true {
            checkedDayArray.append(4)
        }
        if CheckedDay.thursday == true {
            checkedDayArray.append(5)
        }
        if CheckedDay.friday == true {
            checkedDayArray.append(6)
        }
        if CheckedDay.saturday == true {
            checkedDayArray.append(7)
        }
        if CheckedDay.sunday == true {
            checkedDayArray.append(1)
        }
    }
}

struct Quantity {
    static var newQuantity: Int = 0
}







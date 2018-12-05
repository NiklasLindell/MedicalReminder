import UIKit
import CoreData
import UserNotifications

class QuantityViewController: UIViewController {
    
    var quantityShow: Int = 1
    var totalQuantity: Int = 25
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalQuantityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quantityLabel?.text = "1st"
        totalQuantityLabel?.text = "25st"
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
        medicine.time = Time.timeList
        
        PersistenceService.saveContext()
        medicineList.append(medicine)
        
        
        
        
        
        

        performSegue(withIdentifier: "goToList", sender: self)
        self.dismiss(animated: false, completion: nil)
    }
}

struct Quantity {
    static var newQuantity: Int = 0
}







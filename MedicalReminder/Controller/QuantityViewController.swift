import UIKit
import CoreData

struct Quantity {
    static var newQuantity: Int = 0
}

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
        
        PersistenceService.saveContext()
        
        medicineList.append(medicine)
        
        print(medicineList[0].name!)
        print(medicineList[0].quantity)
        print(medicineList[0].totalQuantity)
        
        performSegue(withIdentifier: "goToList", sender: self)
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
}







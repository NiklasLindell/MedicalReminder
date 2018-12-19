import UIKit
import CoreData
import AudioToolbox

class RefillMedicineViewController: UIViewController {

    @IBOutlet weak var totalQuantityLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var refillButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var cancelButtonWhenRefill: UIButton!
    
    
    var selectedMedicine: Medicine!
    var totalQuantityShow: Int16 = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalQuantityLabel.isHidden = true
        minusButton.isHidden = true
        plusButton.isHidden = true
        doneButton.isHidden = true
        cancelButtonWhenRefill.isHidden = true
       
        tabBarController?.tabBar.isHidden = true
        totalQuantityLabel.text = "100pcs"
    }
    
    
    @IBAction func refillButton(_ sender: UIButton) {
        totalQuantityLabel.isHidden = false
        minusButton.isHidden = false
        plusButton.isHidden = false
        doneButton.isHidden = false
        cancelButtonWhenRefill.isHidden = false
        

        
        refillButton.isHidden = true
        cancelButton.isHidden = true
    }
   
    
    
    @IBAction func cancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func minusButton(_ sender: UIButton) {
        if totalQuantityShow > 1 {
            totalQuantityShow -= 1
            totalQuantityLabel.text = "\(totalQuantityShow)pcs"
             AudioServicesPlayAlertSound(1519)
        }
    }

    @IBAction func plusButton(_ sender: UIButton) {
        totalQuantityShow += 1
        totalQuantityLabel.text = "\(totalQuantityShow)pcs"
         AudioServicesPlayAlertSound(1519)
    }
    
    @IBAction func finishButton(_ sender: UIButton) {
        selectedMedicine.totalQuantity = totalQuantityShow
        PersistenceService.saveContext()
        self.dismiss(animated: true, completion: nil)
    }
}

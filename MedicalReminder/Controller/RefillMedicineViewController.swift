import UIKit
import CoreData

class RefillMedicineViewController: UIViewController {

    @IBOutlet weak var totalQuantityLabel: UILabel!
    var selectedMedicine: Medicine!
    var totalQuantityShow: Int16 = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        totalQuantityLabel.text = "100pcs"
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
 
    @IBAction func minusButton(_ sender: UIButton) {
        if totalQuantityShow > 1 {
            totalQuantityShow -= 1
            totalQuantityLabel.text = "\(totalQuantityShow)pcs"
        }
    }

    @IBAction func plusButton(_ sender: UIButton) {
        totalQuantityShow += 1
        totalQuantityLabel.text = "\(totalQuantityShow)pcs"
    }
    
    @IBAction func finishButton(_ sender: UIButton) {
        selectedMedicine.totalQuantity = totalQuantityShow
        PersistenceService.saveContext()
        self.dismiss(animated: true, completion: nil)
    }
}

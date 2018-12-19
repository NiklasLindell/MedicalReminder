import UIKit
import AudioToolbox

let defaults = UserDefaults.standard

class RefillSettingViewController: UIViewController {
    
    @IBOutlet weak var totalQuantityLabel: UILabel!
    
    var totalQuantity = defaults.integer(forKey: "RefillReminder")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if totalQuantity != defaults.integer(forKey: "RefillReminder"){
            totalQuantity = 10
        }
        
        totalQuantityLabel.text = ("\(defaults.integer(forKey: "RefillReminder"))")
    }

    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func minusButton(_ sender: UIButton) {
        if totalQuantity > 1 {
            totalQuantity -= 1
            totalQuantityLabel.text = "\(totalQuantity)"
             AudioServicesPlayAlertSound(1519)
            defaults.set(totalQuantity, forKey: "RefillReminder")
        }
    }
    @IBAction func plusButton(_ sender: UIButton) {
        totalQuantity += 1
        totalQuantityLabel.text = "\(totalQuantity)"
         AudioServicesPlayAlertSound(1519)
        defaults.set(totalQuantity, forKey: "RefillReminder")
    }
    
   
}

import UIKit

class TimesViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIDatePicker!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.datePickerMode = .time
        pickerView.setValue(UIColor.white, forKey: "textColor")
   
    }
    
    
    @IBAction func nextButton(_ sender: UIButton) {
        let date = pickerView.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        Time.hour = components.hour!
        Time.minute = components.minute!
       
    }
    

}

struct Time {
    static var hour = 0
    static var minute = 0
}




import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    
    let date = Date()
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayLabel.text = date.toString(dateFormat: "dd")
        monthLabel.text = date.toString(dateFormat: "LLLL")
        yearLabel.text = date.toString(dateFormat: "yyyy")
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//
//        UIView.animate(withDuration: 3.0) {
//            self.progressView.value = 60
//        }
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        self.progressView.value = 0
//    }
    
}



extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}


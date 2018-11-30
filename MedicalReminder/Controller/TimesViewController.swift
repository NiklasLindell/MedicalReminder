import UIKit

class TimesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var pickerView: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    
    var timesList: [String] = []
    var time: String = ""
    
    var timesCell: String = "timesCell"
    
    var hour: Int = 0
    var minute: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.datePickerMode = .time
        pickerView.setValue(UIColor.white, forKey: "textColor")
        pickerView.addTarget(self, action: #selector(TimesViewController.dateChanged(pickerView:)) , for: .valueChanged)
    }
    
    @objc func dateChanged(pickerView: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let selectedTime = dateFormatter.string(from: pickerView.date)
        time = selectedTime
        
        print(time)
    }
    
    
    
    
    @IBAction func addTime(_ sender: Any) {
        timesList.append(time)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: timesCell, for: indexPath)
        cell.textLabel?.text = timesList[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: "Hiragino Sans", size: 20)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            timesList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}


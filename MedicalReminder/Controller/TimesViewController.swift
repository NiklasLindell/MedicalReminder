import UIKit
import UserNotifications

class TimesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var pickerView: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    
    
    var timesCell: String = "timesCell"
    var showingTime = Date()
    var hour: Int = 0
    var minute: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        Time.timeList = []
        
        pickerView.datePickerMode = .time
        pickerView.setValue(UIColor.white, forKey: "textColor")
        pickerView.addTarget(self, action: #selector(TimesViewController.dateChanged(pickerView:)) , for: .valueChanged)
    }
    
    @objc func dateChanged(pickerView: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let selectedTime = dateFormatter.string(from: pickerView.date)
        let selectedTimeDate = dateFormatter.date(from: selectedTime)
        showingTime = selectedTimeDate! // To show in tableview
    }
    
    func setNotificationTime(){
        let content = UNMutableNotificationContent()
        content.title = "Time to take your medicine!"
        content.body = "Go to Medical Reminder and check your medicine"
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        var dateComponents = DateComponents()
       
        
        for times in Time.timeList{
            
            let triggerTime = Calendar.current.dateComponents([.hour, .minute], from: times)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerTime, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        }
        
       
    }
    
    @IBAction func addTime(_ sender: Any) {
        Time.timeList.append(showingTime)
        tableView.reloadData()
        setNotificationTime()
        print(showingTime)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Time.timeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: timesCell, for: indexPath)
        cell.textLabel?.text = Time.timeList[indexPath.row].toString(dateFormat: "HH:mm")
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: "Hiragino Sans", size: 20)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            Time.timeList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

struct Time {
    static var timeList: [Date] = []
}




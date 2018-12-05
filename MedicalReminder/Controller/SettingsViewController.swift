import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let settingsCell = "settingsCell"
    let goToReminder = "goToReminderSettings"
    let goToImage = "goToImageSettings"
    
    var settingsLabel: [String] = ["Refill reminder", "Profile picture"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: settingsCell, for: indexPath)
        
        cell.textLabel?.text = settingsLabel[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: "Hiragino Sans", size: 20)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            performSegue(withIdentifier: goToReminder, sender: self)
        }
        if indexPath.row == 1{
            performSegue(withIdentifier: goToImage, sender: self)
        }
    }
    
}

import UIKit
import CoreData
import UserNotifications

var medicineList = [Medicine]()

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    
    var selectedMedicine: Medicine!
    
    let center = UNUserNotificationCenter.current()
    let goToAdd = "goToAddMedicine"
    let goToRefill = "goToRefill"
    let listCell = "listCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.register(UINib(nibName: "CellForList", bundle: nil), forCellReuseIdentifier: "listCell")
        let fetchRequest: NSFetchRequest<Medicine> = Medicine.fetchRequest()
        do {
            let medicine = try PersistenceService.context.fetch(fetchRequest)
            medicineList = medicine
            listTableView.reloadData()
        } catch {}     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        listTableView.reloadData()
        if medicineList.count == 0{
            textLabel.text = "You have no medicines. Click on the add-button to add your first."
        }else if medicineList.count != 0{
            textLabel.text = "You have \(medicineList.count) medicines added. Click on the add-button to add more"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicineList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListViewCell
        
        cell.nameLabel.text = medicineList[indexPath.row].name
        cell.totalQuantityLabel.text = ("\(medicineList[indexPath.row].totalQuantity)pcs left")
        if medicineList[indexPath.row].minute < 10{
            cell.timeLabel.text = "\(medicineList[indexPath.row].hour):0\(medicineList[indexPath.row].minute)"
        } else{
            cell.timeLabel.text = "\(medicineList[indexPath.row].hour):\(medicineList[indexPath.row].minute)"
        }
        
        if medicineList[indexPath.row].totalQuantity < defaults.integer(forKey: "RefillReminder") {
            cell.accessoryType = .detailButton
            cell.totalQuantityLabel.textColor = UIColor.red
        }else{
            cell.accessoryType = .none
            cell.totalQuantityLabel.textColor = UIColor.white
        }
        
        if medicineList[indexPath.row].totalQuantity <= 0 {
            cell.totalQuantityLabel.text = "You have no pills left"
        }
        
        
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        selectedMedicine = medicineList[indexPath.row]
        self.performSegue(withIdentifier: goToRefill, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == goToRefill) {
            let navigationDestination = segue.destination as! UINavigationController
            let destination = navigationDestination.topViewController as! RefillMedicineViewController
            destination.selectedMedicine = selectedMedicine
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            for i in 1...7{
                center.removePendingNotificationRequests(withIdentifiers: [medicineList[indexPath.row].identifier! + String(i)]) // Deleting notification
            }
            let commit = medicineList[indexPath.row]
            PersistenceService.persistentContainer.viewContext.delete(commit) //Deleting from CoreData
            medicineList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            PersistenceService.saveContext()
            self.viewWillAppear(true)
        }
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        listTableView.isEditing = !listTableView.isEditing
        sender.title = (listTableView.isEditing) ? "Done" : "Edit"
    }
    
    @IBAction func addMedicineButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add medicine", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name..."
        }
        let continueAction = UIAlertAction(title: "Continue", style: .default) { (_) in
            if alert.textFields?.first?.text != ""{
                Name.medicineName = alert.textFields!.first!.text!
                self.performSegue(withIdentifier: self.goToAdd, sender: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (action) in
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(cancelAction)
        alert.addAction(continueAction)
        present(alert, animated: true, completion: nil)
    }
}

struct Name {
    static var medicineName: String = ""
}


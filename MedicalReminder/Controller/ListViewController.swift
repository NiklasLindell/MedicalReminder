import UIKit
import CoreData
import UserNotifications

var medicineList = [Medicine]()

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    
    let center = UNUserNotificationCenter.current()
    let goToAdd: String = "goToAddMedicine"
    let listCell = "listCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: listCell, for: indexPath)
        cell.textLabel?.text = medicineList[indexPath.row].name
        cell.detailTextLabel?.text = ("\(medicineList[indexPath.row].totalQuantity)pcs left")
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: "Hiragino Sans", size: 20)
        cell.detailTextLabel?.font = UIFont(name: "Hiragino Sans", size: 15)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let commit = medicineList[indexPath.row]
            print(medicineList[indexPath.row].name!)
            center.removePendingNotificationRequests(withIdentifiers: [medicineList[indexPath.row].identifire!]) // Deleting notification
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
    
    @IBAction func addMedicineButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add medicine", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name..."
        }
        let continueAction = UIAlertAction(title: "Continue", style: .default) { (_) in
            Name.medicineName = alert.textFields!.first!.text!
            self.performSegue(withIdentifier: self.goToAdd, sender: nil)
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


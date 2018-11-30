import UIKit
import CoreData

var medicineList = [Medicine]()

class ListViewController: UIViewController, UITabBarDelegate, UITableViewDataSource{
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    
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
            textLabel.text = "Du har inga mediciner inlagda. Klicka på knappen längra ner för att lägga till fler."
        }else if medicineList.count != 0{
            textLabel.text = "Du har nu \(medicineList.count) mediciner tillagda. Klicka på knappen längre ner för att lägga till fler."
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicineList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listCell, for: indexPath)
        cell.textLabel?.text = medicineList[indexPath.row].name
        cell.detailTextLabel?.text = ("\(medicineList[indexPath.row].totalQuantity)st kvar")
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: "Hiragino Sans", size: 20)
        cell.detailTextLabel?.font = UIFont(name: "Hiragino Sans", size: 15)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let commit = medicineList[indexPath.row]
            PersistenceService.persistentContainer.viewContext.delete(commit) //Deleting from CoreData
            medicineList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            PersistenceService.saveContext()
        }
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        listTableView.isEditing = !listTableView.isEditing
        sender.title = (listTableView.isEditing) ? "Klar" : "Redigera"
    }
    
    @IBAction func addMedicineButtonPressed(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Lägg till ny medicin", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Namn på medicin..."
        }
        
        let continueAction = UIAlertAction(title: "Fortsätt", style: .default) { (_) in
            Name.medicineName = alert.textFields!.first!.text!
            self.performSegue(withIdentifier: self.goToAdd, sender: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Avsluta", style: .cancel, handler: {
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


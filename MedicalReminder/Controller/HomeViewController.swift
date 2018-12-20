import UIKit
import CoreData
import UserNotifications
import AudioToolbox
import MBCircularProgressBar

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var progressCircle: MBCircularProgressBarView!
    
    var checkedMedicine: [Medicine] = []
    
    var date = Date()
    let formatter = DateFormatter()
   
    let homeCell = "homeCell"
    
    var fetchResultsController : NSFetchedResultsController<Medicine>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        
        homeTableView.register(UINib(nibName: "CellForHome", bundle: nil), forCellReuseIdentifier: "cell")
        
        setupFetchedResultsController()
        progressCircleMove()
        homeTableView.reloadData()
    }
    
    func setupFetchedResultsController(){
        var dayName = date.toString(dateFormat: "EEEE")
        dayName = dayName.lowercased()
        let predicate = NSPredicate(format: "\(dayName) == %@", NSNumber(value: true))
        let request : NSFetchRequest<Medicine> = Medicine.fetchRequest()
        request.predicate = predicate
        let sortBy = NSSortDescriptor(key: "hour", ascending: true)
        request.sortDescriptors = [sortBy]
        self.fetchResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: PersistenceService.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        do{
            let medicine = try PersistenceService.context.fetch(request)
            medicineList = medicine
            try fetchResultsController?.performFetch()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateDate), userInfo: self, repeats: true)
        
        NotificationCenter.default.addObserver(self, selector:#selector(calendarDayDidChange), name:.NSCalendarDayChanged, object:nil)
        
        setupFetchedResultsController()
        progressCircleMove()
        homeTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        progressCircleMove()
        print(checkedMedicine.count)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return todaysMedicine.count
        return fetchResultsController?.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        if medicineList[indexPath.row].minute < 10{
            cell.timeLabel.text = "\(medicineList[indexPath.row].hour):0\(medicineList[indexPath.row].minute)"
        } else{
            cell.timeLabel.text = "\(medicineList[indexPath.row].hour):\(medicineList[indexPath.row].minute)"
        }
        cell.nameLabel?.text = medicineList[indexPath.row].name
        cell.amountLabel.text = ("\(medicineList[indexPath.row].quantity)pcs per intake")

        if medicineList[indexPath.row].taken == true{
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == homeTableView {
            if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
                AudioServicesPlayAlertSound(1519)
                let newTotalQuantity = medicineList[indexPath.row].totalQuantity + medicineList[indexPath.row].quantity
                fetchResultsController.object(at: indexPath).totalQuantity  = newTotalQuantity // Updating CoreData
                medicineList[indexPath.row].taken = false
                progressCircleMove()
                PersistenceService.saveContext()
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
                AudioServicesPlayAlertSound(1519)
                let newTotalQuantity =  medicineList[indexPath.row].totalQuantity - medicineList[indexPath.row].quantity
                fetchResultsController.object(at: indexPath).totalQuantity  = newTotalQuantity // Updating Coredata
                medicineList[indexPath.row].taken = true
                progressCircleMove()
                PersistenceService.saveContext()
            }
            
            homeTableView.reloadData()
        }
    }

    @objc func updateDate(){
        date = Date()
        dayLabel.text = date.toString(dateFormat: "dd")
        monthLabel.text = date.toString(dateFormat: "LLLL")
        weekdayLabel.text = date.toString(dateFormat: "EEEE")
        homeTableView.reloadData()
        
    }
    @objc func calendarDayDidChange()
    {
        for medicines in checkedMedicine{
            if medicines.taken == true{
                medicines.taken = false
            }
        }
        progressCircleMove()
    }
    
    func progressCircleMove() {
        self.progressCircle.maxValue = CGFloat((fetchResultsController?.fetchedObjects?.count)!)
        checkedMedicine.removeAll()
        for medicines in medicineList{
            if medicines.taken == true{
                self.checkedMedicine.append(medicines)
            }
        }
        UIView.animate(withDuration: 1.5) {
            self.progressCircle.value = CGFloat(self.checkedMedicine.count)
        }
    }
}

extension Date
{
    func toString(dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}


//
//  FactsVC.swift
//  Funny
//
//  Created by Macbook Air on 20/04/22.
//

import UIKit
import SSNeumorphicView
import SoftButton
import CoreData

class FactsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "FactsTVCTableViewCell", bundle: nil), forCellReuseIdentifier: "FactsTVCTableViewCell")
        }
    }
    
    @IBOutlet weak var getBtn: SoftButton! {
    didSet {
        getBtn.makeNeuromorphic()
    }
        
}
    
    @IBOutlet weak var factLbl: UILabel!
    
    @IBOutlet weak var saveBtn: SoftButton! {
        didSet {
            saveBtn.makeNeuromorphic()
        }
    }
    
    var data = [FactDM]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Fact"
        getFact()
        getItems()
    }
    
    @IBAction func getNewTap(_ sender: Any) {
        self.factLbl.text = "Wait..."
        saveBtn.isHidden = false
        getFact()
    }
    
    @IBAction func saveTap(_ sender: Any) {
        saveBtn.isHidden = true
        let item = FactDM(context: self.context)
        item.date = Date()
        item.title = self.factLbl.text
        
        do {
            try self.context.save()
            print("SAVED")
            getItems()
        } catch {
            print("SAVING ERROR")
        }
    }
    
    
    
    func getFact() {
        API.shared.CatsFact { fact in
            self.factLbl.text = fact
        }
    }

}

//MARK: - TABLEVIEW METHODS
extension FactsVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "saved facts"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FactsTVCTableViewCell", for: indexPath) as! FactsTVCTableViewCell
        cell.updateCell(fact: self.data[indexPath.row], index: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "remove") { _, _, _ in
            self.deleteItem(item: self.data[indexPath.row])
           print("removed")
        }
        
        delete.image = UIImage(named: "")
        
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
        
    }
    
}

//MARK: - CORE DATA METHODS
extension FactsVC {
    
    func getItems() {
        let request = NSFetchRequest<FactDM>.init(entityName: "FactDM")
        
        let sortByDone = NSSortDescriptor(key: "date", ascending: true)
        let sortByTitle = NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        request.sortDescriptors = [sortByDone, sortByTitle]
        do {
            self.data = try context.fetch(request)
            tableView.reloadData()
        } catch {}
    }
    
    func deleteItem(item : FactDM) {
        context.delete(item)
        try!  context.save()
        getItems()
    }
    
    func searchItem(text : String) {
        
        let request = NSFetchRequest<FactDM>.init(entityName: "FactDM")
        
        let sortByDone = NSSortDescriptor(key: "date", ascending: true)
        let sortByTitle = NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        let pradicate = NSPredicate(format: "title BEGINSWITH[c] %@", text)
        request.predicate = pradicate
        request.sortDescriptors = [sortByDone, sortByTitle]
        do {
            self.data = try context.fetch(request)
            tableView.reloadData()
        } catch {}
    }
}

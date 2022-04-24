//
//  ListViewController.swift
//  Traveler
//
//  Created by Samim Hakimi on 4/9/22.
//

import UIKit
import FirebaseFirestore

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ListTableViewCellDelagate {
    
    var observer: NSObjectProtocol?
    var db = Firestore.firestore()
    public var sliderValue: String?
    
    var itemList = [ItemModel]()
    var locationName: String?
    public var gender: String?
    var days: Int?
    
    public let listTable: UITableView = {
        let table = UITableView()
        table.register(ListTableViewCell.self , forCellReuseIdentifier: ListTableViewCell.identifier)
        return table
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(listTable)
        listTable.delegate = self
        listTable.dataSource = self
        listTable.translatesAutoresizingMaskIntoConstraints = false
        self.getData()
        self.listTable.reloadData()
    }
   
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        listTable.frame = view.bounds
        
    }

    func getNotification() {
        let name = Notification.Name("colorChanged")
        observer = NotificationCenter.default.addObserver(forName: name, object: nil, queue: .main) { notification in
            guard let object = notification.object as? [String: String] else {
                return
            }
            
            guard let daysTraveling = object["days"] else {
                return
            }
            
            print("Days received Notification \(daysTraveling)")
    
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell
        
        cell?.delegate = self
        
        let model = itemList[indexPath.row]
        cell?.configure(with: ItemViewModel(id: model.id, name: model.name, qty: model.quantity, isComplete: model.isComplete))
//        cell?.itemsLabel.text = itemList[indexPath.row].name
//        cell?.itemsCountLabel.text = String(itemList[indexPath.row].quantity)
       // cell?.checkBox.isSelected = itemList[indexPath.row].isComplete
        
      
        return cell!
        
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            itemList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)

        }
    }
    
    func checkBoxtoggle(sender: ListTableViewCell) {
        
        if let selectedIndexPath = listTable.indexPath(for: sender) {
            itemList[selectedIndexPath.row].isComplete = !itemList[selectedIndexPath.row].isComplete
            
        }
    }
    
    //delete items from the list
    func delete(itemsToDelete: ItemModel){
        db.collection("females").document(itemsToDelete.id).delete { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.itemList.removeAll { item in
                        return item.id == itemsToDelete.id
                        
                    }
                }
            }
        }
    }
    
    //add data to the database
    func addData(name:String, quantity:Int,isComplete:Bool){
        db.collection("females").addDocument(data: ["name":name, "quantity":quantity, "isComplete":isComplete]) { error in
            if error == nil {
                self.getData()
            }else {
                print("error saving data")
            }
        }
    }
    
    // get data from the database
    func getData(){
        
        //TODO: check if the user selected male or female
        // get the data accordingly.
        
        db.collection("females").addSnapshotListener { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                       
                        self.itemList = snapshot.documents.map { doc in
                                
                            let qty = doc["quantity"] as? Int ?? 0
                            let name = doc["name"] as? String ?? ""
                            let completed = doc["isComplete"] as? Bool ?? false
                           
                          
                            return ItemModel(id: doc.documentID,
                                             name: name,
                                             quantity: qty,
                                             isComplete: completed
                                             )
                            
                        }
                        self.listTable.reloadData()
                     
                    }
                  
                }
            }else {
                print("error geting data")
            }
        }
        
    }
    
   
    
}


extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            
            value: NSUnderlineStyle.single.rawValue,
            range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
}

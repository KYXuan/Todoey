//
//  ViewController.swift
//  Todoey
//
//  Created by 宣柯宇 on 2018-07-20.
//  Copyright © 2018 keyu xuan. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    
    var itemArray = [Item]()
   
    var selectedCategory : Category? {
        //this will happen as soon as selectedCategory has a value
        didSet{
            loadItems()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
       
//       print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

    }

   //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true) // want to flash the grey
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //this textfield has the scope of entire "addButtonPressed" ib action
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item Button on our UIAlert
           
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            
           self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Manupulation Methods
    func saveItems() {
       
        
        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
        
        
        self.tableView.reloadData()
    }
    
    //use external and interval parameter here
    //internal will be used inside this code
    //external will be used when we call the function
    //if we call this method without parameter we will use the default value
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(),predicate: NSPredicate? = nil) {
       
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
       
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//
//        request.predicate = compoundPredicate
      
        do {
            //output will be an array of items stored in the container
           itemArray =  try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
        
    }
}

//MARK: - Search bar methods

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        //in order to query objects using Core Data we need to use NSPredicate
        //args is what we print out in the print statement
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
    
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)

        
    }
    
    //when go from all text to no text, this one will be triggered , for examplw when you click the cross button
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //when the text changed and goes to zero
        if searchBar.text?.count == 0 {
            loadItems()
            
            //who assigns projects to different threads
            //ask the dispatcher to get the main queue and run this method in the main queue
            DispatchQueue.main.async {
                
                //no longer be the thing been selected
                searchBar.resignFirstResponder()
            }
            
           
        }
    }
    
    
    
}













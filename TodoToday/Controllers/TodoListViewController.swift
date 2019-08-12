//
//  ViewController.swift
//  TodoToday
//
//  Created by Everett  Sprenger on 2019-08-10.
//  Copyright © 2019 Everett  Sprenger. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
    
    let defaults = UserDefaults.standard
    var itemArray = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem1 = Item()
        newItem1.title = "Jinx"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Kai sa"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Caitlyn"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
              }
        // Do any additional setup after loading the view.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        

        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add to list", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
           textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}


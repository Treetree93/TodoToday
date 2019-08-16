//
//  ViewController.swift
//  TodoToday
//
//  Created by Everett  Sprenger on 2019-08-10.
//  Copyright © 2019 Everett  Sprenger. All rights reserved.
//

import UIKit
import RealmSwift
class TodoListViewController: UITableViewController, UISearchBarDelegate {


let realm = try! Realm()
    var todoItems : Results<Item>?
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "no items.... yet"
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(item)
//                    item.done = !item.done
                }
            } catch {
                print("error\(error)")
            }
tableView.reloadData()
        }
        //print(itemArray[indexPath.row])

//        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
//
//        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add to list", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("error loading\(error)")
                }
            }
    
                self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
           textField = alertTextField
            
        }
        alert.addAction(action)
            
        present(alert, animated: true, completion: nil)
        
    }


func loadItems() {
    
    todoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)
    tableView.reloadData()
    
    
}


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
}
}



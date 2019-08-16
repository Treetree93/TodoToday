//
//  CategoryViewController.swift
//  TodoToday
//
//  Created by Everett  Sprenger on 2019-08-14.
//  Copyright © 2019 Everett  Sprenger. All rights reserved.
//

import UIKit
import RealmSwift
class CategoryViewController: UITableViewController {
    
    
    let realm = try! Realm()

    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories..... yet"
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    func loadCategories() {
        
    categories = realm.objects(Category.self)

        tableView.reloadData()
    }
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
            
        } catch {
            print("error saving categories\(error)")
        }
   tableView.reloadData()
    }
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
            
        }
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new Category"
        }
        
                present(alert, animated: true, completion: nil)
            
        }


}

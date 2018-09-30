//
//  ViewController.swift
//  Checklists
//
//  Created by imac on 2017/6/25.
//  Copyright © 2017年 Individual. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
    var checkList: Checklist!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = checkList.name
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkList.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        
        let item = checkList.items[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = checkList.items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // This method enables swipe to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // remove the row from the data model
        checkList.items.remove(at: indexPath.row)
        
        // remove the row from the tableView
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
    }
    
    // Prepare for segue
    // 1. because there could be more than one segue for each viewController, identify each segue with a name.
    // 2. the new view controller can be found in segue.destination.
    // 3. to find the ItemDetailViewController, look at the navigation Controller's topViewController property, which refers to the screen that is currently active inside the navigation controller.
    // 4. Once you get a reference to teh ItemDetailViewController object, you set its delegate property to self.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ItemDetailViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = checkList.items[indexPath.row]
            }
        }
    }
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        let newRowIndex = checkList.items.count
        checkList.items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        if let index = checkList.items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                configureText(for: cell, with: item)
            }
        }
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
       let label = cell.viewWithTag(1001) as! UILabel
        if item.checked
        {
            label.text = "√"
        } else {
            label.text = ""
        }
        label.textColor = view.tintColor
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem){
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = "\(item.text)"
    }
    
        
}


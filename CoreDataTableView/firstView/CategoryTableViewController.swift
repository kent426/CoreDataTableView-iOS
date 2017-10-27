//
//  CategoryTableViewController.swift
//  CoreDataTableView
//
//  Created by kenth on 2017-10-26.
//  Copyright © 2017 kenth. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController , NSFetchedResultsControllerDelegate{
    
    
    var context : NSManagedObjectContext! = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var fetchedResultsController: NSFetchedResultsController<Category>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up the NSFetchRequest for the tableView
        
        //create a request
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(
            key: "creationDate",
            ascending: false
            )]

        //set up the fetchedResultsController
        fetchedResultsController = NSFetchedResultsController<Category>(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        //set delegate
        fetchedResultsController.delegate = self
        do{
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
        tableView.reloadData()
        

        //set up the logn-press context menu   
        //delete menuitem
        let deleteMenuItem = UIMenuItem(title: "Delete", action: #selector(CategoryTableViewCell.deleteCell(_:)))
        
        //MoveToTop menuitem
        let moveTopMenuItem = UIMenuItem(title: "Move To Top", action: #selector(CategoryTableViewCell.moveTop(_:)))
        
        let menuController = UIMenuController.shared
        var newItems = menuController.menuItems ?? [UIMenuItem]()
        newItems.append(deleteMenuItem)
        newItems.append(moveTopMenuItem)
        menuController.menuItems = newItems
 

 
 
    }




}

// related to NSFetchedResultsControllerDelegate
extension CategoryTableViewController {
    
    
    public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert: tableView.insertSections([sectionIndex], with: .fade)
        case .delete: tableView.deleteSections([sectionIndex], with: .fade)
        default: break
        }
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        }
    }
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}


//table view stuff
extension CategoryTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else {
            fatalError("The dequeued cell is not an instance of CategoryTableViewCell.")
        }
        let category = fetchedResultsController.object(at: indexPath)
        //get the category name
        cell.label.text = category.categoryName!
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let sections = fetchedResultsController.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    

}



 
//for the itemMenu in table cell
extension CategoryTableViewController {
    //long-press menu
    override func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //long-press menu
    override func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return action == #selector(CategoryTableViewCell.deleteCell(_:))
            || action == #selector(CategoryTableViewCell.moveTop(_:))
        
    }
    
    //long-press menu
    override func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        //You can handle standard actions here, but custom actions never trigger this. It still needs to be present for the menu to display, though.
    }
}





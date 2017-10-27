//
//  AddViewController.swift
//  CoreDataTableView
//
//  Created by kenth on 2017-10-26.
//  Copyright © 2017 kenth. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    
    //var container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    var context: NSManagedObjectContext! = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var textfield: UITextField!
    
    @IBAction func saveCategory(_ sender: UIBarButtonItem) {
        
        if let categoryinput = textfield.text{
            if categoryinput.count != 0 {
                if Category.CreateCategory(CategoryName: categoryinput, in: context ) != nil {
                    do {
                        try context.save()
                        print( "save")
                        self.navigationController?.popViewController(animated: true)
                    } catch {
                        print(error)
                        fatalError("fail to add category.")
                    }
                }
            }
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textfield.layer.borderWidth = 1
    }


}

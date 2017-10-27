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
        
        //check if the text is nil
        if let categoryinput = textfield.text{
            
            //check if the text field is empty
            if categoryinput.count != 0 {
                
                //check if db already had the same name(duplicate)
                //call db create func
                
                if Category.CreateCategory(CategoryName: categoryinput, in: context ) != nil {
                    do {
                        //remember to save
                        try context.save()
                        print( "save")
                        //back to previous page 
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

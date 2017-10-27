//
//  CategoryTableViewCell.swift
//  CoreDataTableView
//
//  Created by kenth on 2017-10-26.
//  Copyright © 2017 kenth. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {


    @IBOutlet weak var label: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    /*
    
    //delete method
    @objc func deleteCell(_ sender:AnyObject?){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        Category.Delete(CategoryName: label.text!,context: context)
    }
    
    
    //move to top method
    @objc func moveTop(_ sender:AnyObject?){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        Category.UpdateDate(CategoryName: label.text!,context: context)
    }
 */

}

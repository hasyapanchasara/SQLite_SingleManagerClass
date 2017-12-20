//
//  ViewController.swift
//  ExampleWithFMDB
//
//  Created by Hasya.Panchasra on 28/12/2016.
//  Copyright © 2015 HP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
       
        super.viewDidLoad()
        
       
    }

    @IBAction func insertButtonTapEvent(_ sender: AnyObject) {
        
        
      
        
        LocalDatabase.sharedInstance.methodToInsertUpdateDeleteData("INSERT INTO CONTACTS_TABLE (name, address, phone) VALUES ('Satyam Mall', 'Brainvire', 0085)", completion: { (completed) in
            if completed
            {
                print("Data updated successfully")
            }
            else
            {
                print("Fail while data updation")
            }
        })
        
    }


    
    @IBAction func getFromDatabase(_ sender: AnyObject) {

      
        LocalDatabase.sharedInstance.methodToSelectData("SELECT * FROM CONTACTS_TABLE", completion: { (dataReturned) in
            print(dataReturned)
        })
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


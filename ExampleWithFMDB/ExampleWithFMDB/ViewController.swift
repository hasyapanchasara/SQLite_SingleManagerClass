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
        
        
        if LocalDatabase.sharedInstance.methodToInsertUpdateDeleteData("INSERT INTO CONTACTS_TABLE (name, address, phone) VALUES ('Satyam Mall', 'Brainvire', 0085)")
        {
            NSLog("Store Successfully.")
        }
        else
        {
            NSLog("Failled to store in database.")
        }
        
    }


    
    @IBAction func getFromDatabase(_ sender: AnyObject) {

        NSLog("%@",LocalDatabase.sharedInstance.methodToSelectData("SELECT * FROM CONTACTS_TABLE"))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  LocalDatabase.swift
//  ExampleWithFMDB
//
//  Created by Hasya.Panchasra on 28/12/2016.
//  Copyright © 2015 HP. All rights reserved.
//

import Foundation
class LocalDatabase: NSObject {
    
    
    //sharedInstance
    static let sharedInstance = LocalDatabase()
    

    
        func methodToCreateDatabase() -> NSURL? {
        
        let fileManager = NSFileManager.defaultManager()
        
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        if let documentDirectory:NSURL = urls.first { // No use of as? NSURL because let urls returns array of NSURL
            
            // exclude cloud backup
            do {
                try documentDirectory.setResourceValue(true, forKey: NSURLIsExcludedFromBackupKey)
            } catch _{
                print("Failed to exclude backup")
            }
            
            // This is where the database should be in the documents directory
            let finalDatabaseURL = documentDirectory.URLByAppendingPathComponent("contact.db")
            
            if finalDatabaseURL.checkResourceIsReachableAndReturnError(nil) {
                // The file already exists, so just return the URL
                return finalDatabaseURL
            } else {
                // Copy the initial file from the application bundle to the documents directory
                if let bundleURL = NSBundle.mainBundle().URLForResource("contact", withExtension: "db") {
                    
                    do {
                        try fileManager.copyItemAtURL(bundleURL, toURL: finalDatabaseURL)
                    } catch _ {
                        print("Couldn't copy file to final location!")
                    }
                    
                } else {
                    print("Couldn't find initial database in the bundle!")
                }
            }
        } else {
            print("Couldn't get documents directory!")
        }
        
        return nil
    }
    
        func methodToInsertUpdateDeleteData(strQuery : String) -> Bool
        {
            
           // print("%@",String(methodToCreateDatabase()!.absoluteString))
            
            let contactDB = FMDatabase(path: String(methodToCreateDatabase()!.absoluteString) )
            
            if contactDB.open() {
                
                let insertSQL = strQuery
                
                let result = contactDB.executeUpdate(insertSQL,
                    withArgumentsInArray: nil)
                
                if !result {
                    print("Failed to add contact")
                    print("Error: \(contactDB.lastErrorMessage())")
                    return false
                } else {
                    print("Contact Added")
                    return true
                }
            } else {
                print("Error: \(contactDB.lastErrorMessage())")
                return false
            }

        }

        func methodToSelectData(strQuery : String) -> NSMutableArray
        {
            
            let arryToReturn : NSMutableArray = []
            
            print("%@",String(methodToCreateDatabase()!.absoluteString))
            
            let contactDB = FMDatabase(path: String(methodToCreateDatabase()!.absoluteString) )
            
            if contactDB.open() {
                let querySQL = strQuery
                
                let results:FMResultSet? = contactDB.executeQuery(querySQL,
                    withArgumentsInArray: nil)

                while results?.next() == true
                {
                    arryToReturn.addObject(results!.resultDictionary())
                }
                
                // NSLog("%@", arryToReturn)
                
                if arryToReturn.count == 0
                {
                    print("Record Not Found")
                    
                }
                else
                {
                    print("Record Found")

                }
                

                contactDB.close()
            } else {
                print("Error: \(contactDB.lastErrorMessage())")
            }
            
            return arryToReturn

        }
}
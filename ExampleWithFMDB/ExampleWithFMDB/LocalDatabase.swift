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
    

    
        func methodToCreateDatabase() -> URL? {
        
        let fileManager = FileManager.default
        
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        if let documentDirectory:URL = urls.first { // No use of as? NSURL because let urls returns array of NSURL
            
            // exclude cloud backup
            do {
                try (documentDirectory as NSURL).setResourceValue(true, forKey: URLResourceKey.isExcludedFromBackupKey)
            } catch _{
                print("Failed to exclude backup")
            }
            
            // This is where the database should be in the documents directory
            let finalDatabaseURL = documentDirectory.appendingPathComponent("contact.db")
            
            if (finalDatabaseURL as NSURL).checkResourceIsReachableAndReturnError(nil) {
                // The file already exists, so just return the URL
                return finalDatabaseURL
            } else {
                // Copy the initial file from the application bundle to the documents directory
                if let bundleURL = Bundle.main.url(forResource: "contact", withExtension: "db") {
                    
                    do {
                        try fileManager.copyItem(at: bundleURL, to: finalDatabaseURL)
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
    
        func methodToInsertUpdateDeleteData(_ strQuery : String) -> Bool
        {
            
           // print("%@",String(methodToCreateDatabase()!.absoluteString))
            
            let contactDB = FMDatabase(path: String(methodToCreateDatabase()!.absoluteString) )
            
            if (contactDB?.open())! {
                
                let insertSQL = strQuery
                
                let result = contactDB?.executeUpdate(insertSQL,
                    withArgumentsIn: nil)
                
                if !result! {
                    print("Failed to add contact")
                    print("Error: \(contactDB?.lastErrorMessage())")
                    return false
                } else {
                    print("Contact Added")
                    return true
                }
            } else {
                print("Error: \(contactDB?.lastErrorMessage())")
                return false
            }

        }

        func methodToSelectData(_ strQuery : String) -> NSMutableArray
        {
            
            let arryToReturn : NSMutableArray = []
            
            print("%@",String(methodToCreateDatabase()!.absoluteString) ?? "")
            
            let contactDB = FMDatabase(path: String(methodToCreateDatabase()!.absoluteString) )
            
            if (contactDB?.open())! {
                let querySQL = strQuery
                
                let results:FMResultSet? = contactDB?.executeQuery(querySQL,
                    withArgumentsIn: nil)

                while results?.next() == true
                {
                    arryToReturn.add(results!.resultDictionary())
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
                

                contactDB?.close()
            } else {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            
            return arryToReturn

        }
}

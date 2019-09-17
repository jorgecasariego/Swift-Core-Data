//
//  CustomMigrationPolicy.swift
//  CoreData2019Project
//
//  Created by Jorge Casariego on 9/16/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import CoreData

class CustomMigrationPolicy: NSEntityMigrationPolicy {
    
    // type our transformation function here in just a bit
    
    @objc func transformNumEmployees(forNum: NSNumber) -> String {
        if forNum.intValue < 150 {
            return "small"
        } else {
            return "very large"
        }
    }
    
}

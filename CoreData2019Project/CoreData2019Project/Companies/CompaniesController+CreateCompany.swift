//
//  CompaniesController+CreateCompany.swift
//  CoreData2019Project
//
//  Created by Jorge Casariego on 8/29/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit

extension CompaniesController: CreateCompanyControllerDelegate {
    func didAddCompany(company: Company) {
        // 1. Modify your array
        companies.append(company)
        
        // 2. Insert a new index path to the tableview
        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    func didEditCompany(company: Company) {
        let row = companies.firstIndex(of: company)
        let reloadIndexPath = IndexPath(item: row!, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .middle)
    }
}

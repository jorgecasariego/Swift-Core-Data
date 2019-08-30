//
//  EmployeesController.swift
//  CoreData2019Project
//
//  Created by Jorge Casariego on 8/29/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit

class EmployeesController: UITableViewController {
    
    var company: Company? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = company?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.darkBlue
        
        setupPlusButtonInNavBar(selector: #selector(handleAddEmployee))
    }
    
    @objc private func handleAddEmployee() {
        let employeeController = CreateEmployeeController()
        let navController = UINavigationController(rootViewController: employeeController)
        present(navController, animated: true)
    }
}

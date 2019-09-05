//
//  EmployeesController.swift
//  CoreData2019Project
//
//  Created by Jorge Casariego on 8/29/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit
import CoreData

class EmployeesController: UITableViewController {
    
    var company: Company? = nil
    var employees = [Employee]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = company?.name
        fetchEmployees()
    }
    
    private func fetchEmployees() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let request = NSFetchRequest<Employee>(entityName: "Employee")
        
        do {
            let employees = try context.fetch(request)
            employees.forEach{ print("Employee name: ", $0.name ?? "")}
            
        } catch let fetchEmployeeError {
            print(fetchEmployeeError)
        }
        
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

//
//  ViewController.swift
//  CoreData
//
//  Created by Jorge Casariego on 6/13/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit
import CoreData


class CompaniesController: UITableViewController {
    let cellId = "cellId"
    var companies = [Company]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.companies = CoreDataManager.shared.fetchCompanies()
        
        view.backgroundColor = .white
        navigationItem.title = "Companies"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
        
        tableView.backgroundColor = UIColor.rgb(red: 9, green: 45, blue: 64)
        tableView.separatorStyle = .none
        tableView.register(CompanyCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .white
        
    }
    
    @objc private func handleReset() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        // Opcion 1
//        companies.forEach { (company) in
//            context.delete(company)
//        }
        
        // Opcion 2
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        
        do {
            try context.execute(batchDeleteRequest)
            
            var indexPathsToRemove = [IndexPath]()
            for (index, _) in companies.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                indexPathsToRemove.append(indexPath)
            }
            
            companies.removeAll()
            // Opcion 1 para borrar
//            tableView.reloadData()
            
            //OPcion 2 para borrar con animación
            tableView.deleteRows(at: indexPathsToRemove, with: .left)
            
        } catch let deleteError {
            print("Failed to delete companies: ", deleteError)
        }
        
    }

    
    @objc fileprivate func handleAddCompany() {
        let createCompanyController = CreateCompanyController()
        let navController = CustomNavigationController(rootViewController: createCompanyController)
        
        createCompanyController.delegate = self
        
        present(navController, animated: true, completion: nil)
    }
    
}


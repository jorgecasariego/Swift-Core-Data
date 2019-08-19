//
//  ViewController.swift
//  CoreData
//
//  Created by Jorge Casariego on 6/13/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit

class CompaniesController: UITableViewController {
    let cellId = "cellId"
    let companies: [Company] = [
        Company(name: "Apple", founded: Date()),
        Company(name: "Google", founded: Date()),
        Company(name: "Microsoft", founded: Date()),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Companies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
        
        tableView.backgroundColor = UIColor.rgb(red: 9, green: 45, blue: 64)
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .white
    }
    
    @objc fileprivate func handleAddCompany() {
        let createCompanyController = CreateCompanyController()
        let navController = CustomNavigationController(rootViewController: createCompanyController)
        present(navController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 218, green: 235, blue: 243)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.rgb(red: 48, green: 164, blue: 182)

        let company = companies[indexPath.item]
        cell.textLabel?.text = company.name
        return cell
    }
    
    // OJO: Con solo esto no cambiamos el status bar color a blanco
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }


}


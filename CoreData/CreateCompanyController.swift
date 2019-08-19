//
//  CreateCompanyController.swift
//  CoreData
//
//  Created by Jorge Casariego on 6/13/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit

//Custom Delegation
protocol CreateCompanyControllerDelegate {
    func didAddCompany(company: Company)
}

class CreateCompanyController: UIViewController {
    var delegate: CreateCompanyControllerDelegate?
    
    //var companiesController: CompaniesController?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        //enable auto layout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    @objc fileprivate func handleSave() {
        print("trying to save company")
        dismiss(animated: true) {
            guard let name = self.nameTextField.text else { return }
            
            let company = Company(name: name, founded: Date())
            self.delegate?.didAddCompany(company: company)
        }
        
        
    }
    
    fileprivate func setupUI() {
        let lightBlueBackgroundView = UIView()
        lightBlueBackgroundView.backgroundColor = UIColor.lightBlue
        lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lightBlueBackgroundView)
        
        lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        lightBlueBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        lightBlueBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameLabel)
        
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        
        nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 0).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    
}

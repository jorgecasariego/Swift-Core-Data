//
//  CreateEmployeeController.swift
//  CoreData2019Project
//
//  Created by Jorge Casariego on 8/29/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit

class CreateEmployeeController: UIViewController {
    
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
        
        navigationItem.title = "Create Employee"
        view.backgroundColor = UIColor.darkBlue
        setupCancelButton()
        _ = setupLightBlueBackgroundView(height: 50)
        
        setupViews()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    @objc private func handleSave() {
        guard let employeeName = nameTextField.text else { return }
        let error = CoreDataManager.shared.createEmployee(name: employeeName)
        
        if let error = error {
            // Aqui mostraremos el error de alguna manera
            print(error)
        } else {
            dismiss(animated: true, completion: nil)
        }
        
        
        
    }
    
    
    func setupViews() {
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
}

//
//  CreateCompanyController.swift
//  CoreData
//
//  Created by Jorge Casariego on 6/13/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit
import CoreData

//Custom Delegation
protocol CreateCompanyControllerDelegate {
    func didAddCompany(company: Company)
    func didEditCompany(company: Company)
}

class CreateCompanyController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var company: Company? {
        didSet {
            nameTextField.text = company?.name
            guard let founded = company?.founded else { return }
            datePicker.date = founded
            
            if let imageData = company?.imageData {
                companyImageView.image = UIImage(data: imageData)
            }
            
        }
    }
    
    
    var delegate: CreateCompanyControllerDelegate?
    
    
    lazy var companyImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.darkBlue.cgColor
        imageView.layer.borderWidth = 2
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    @objc private func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true // esto permite editar la foto
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            // Esta es la imagen editada
            companyImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // Esta es la imagen original
            companyImageView.image = originalImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
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
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.translatesAutoresizingMaskIntoConstraints = false
        
        return dp
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Ternary syntax
        
        navigationItem.title = company == nil ? "Create Company" : "Edit Company"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        setupCancelButton()
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    @objc fileprivate func handleSave() {
        if company == nil {
            createCompany()
        } else {
            saveCompanyChanges()
        }
    }
    
    private func saveCompanyChanges() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        company?.name = nameTextField.text
        company?.founded = datePicker.date
        
        if let companyImage = companyImageView.image {
            let imageData = companyImage.jpegData(compressionQuality: 0.8)
            company?.imageData = imageData
        }
        
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didEditCompany(company: self.company!)
            })
        } catch let saveError {
            print("Failed to save company: ", saveError)
        }
        
        
    }
    
    private func createCompany() {
        // 1. Perform the save
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(nameTextField.text, forKey: "name")
        company.setValue(datePicker.date, forKey: "founded")
        
        if let companyImage = companyImageView.image {
            let imageData = companyImage.jpegData(compressionQuality: 0.8)
            company.setValue(imageData, forKey: "imageData")
        }
        
        
        do {
            try context.save()
            
            // Success
            dismiss(animated: true) {
                self.delegate?.didAddCompany(company: company as! Company)
            }
        } catch let saveError {
            print("Failed to save company: ", saveError)
        }
    }
    
    fileprivate func setupUI() {
        let lightBlueBackgroundView = setupLightBlueBackgroundView(height: 350)
        
        view.addSubview(companyImageView)
        
        companyImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        companyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        companyImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        companyImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(nameLabel)
        
        nameLabel.topAnchor.constraint(equalTo: companyImageView.bottomAnchor, constant: 0).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        
        nameTextField.topAnchor.constraint(equalTo: companyImageView.bottomAnchor, constant: 0).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 0).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(datePicker)
        
        datePicker.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        datePicker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        datePicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: lightBlueBackgroundView.bottomAnchor).isActive = true
        
        
    }
    
//    @objc func handleCancel() {
//        dismiss(animated: true, completion: nil)
//    }
    
    
}

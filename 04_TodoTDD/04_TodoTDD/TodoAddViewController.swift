//
//  TodoAddViewController.swift
//  04_TodoTDD
//
//  Created by rae on 2021/11/23.
//

import UIKit
import CoreData

class TodoAddViewController: UIViewController {
    let textFieldMultiplier: CGFloat = 1/2
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Title"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    private let addressTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Address"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    private let descTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Description"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date"
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(touchCancelButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.isEnabled = false
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(touchSaveButton(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setViews()
    }
    
    func setViews() {
        view.addSubview(titleTextField)
        NSLayoutConstraint.activate([
            titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: textFieldMultiplier),
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
        ])
        
        view.addSubview(addressTextField)
        NSLayoutConstraint.activate([
            addressTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addressTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: textFieldMultiplier),
            addressTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
        ])
        
        view.addSubview(descTextField)
        NSLayoutConstraint.activate([
            descTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: textFieldMultiplier),
            descTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20),
        ])
        
        view.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: descTextField.bottomAnchor, constant: 40)
        ])
        
        view.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.widthAnchor.constraint(equalTo: view.widthAnchor),
            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
        ])
        
        view.addSubview(cancelButton)
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -60),
            cancelButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor),
            
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 60),
            saveButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor),
        ])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    @objc func touchCancelButton(_ button: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func touchSaveButton(_ button: UIButton) {
        let context = PersistenceManager.shared.context
        let entity = NSEntityDescription.entity(forEntityName: "TodoEntity", in: context)
        
        if let entity = entity {
            let todoObject = NSManagedObject(entity: entity, insertInto: context)
            
            guard let titleText = titleTextField.text else { return }
            guard let addressText = addressTextField.text else { return }
            guard let descText = descTextField.text else { return }
            
            let todo = Todo(title: titleText, address: addressText, desc: descText)
            todoObject.setValue(todo.title, forKey: "title")
            todoObject.setValue(todo.address, forKey: "address")
            todoObject.setValue(todo.desc, forKey: "desc")
            
            do {
                try context.save()
                navigationController?.popViewController(animated: true)
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func checkTextFieldsIsNotEmpty() -> Bool {
        guard let titleText = titleTextField.text else { return false }
        guard let addressText = addressTextField.text else { return false }
        guard let descText = descTextField.text else { return false }
        if titleText.isEmpty || addressText.isEmpty || descText.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if checkTextFieldsIsNotEmpty() {
            saveButton.isEnabled = true
            saveButton.setTitleColor(.systemBlue, for: .normal)
        } else {
            saveButton.isEnabled = false
            saveButton.setTitleColor(.lightGray, for: .normal)
        }
    }
}

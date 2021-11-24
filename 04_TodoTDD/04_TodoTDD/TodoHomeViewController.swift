//
//  TodoHomeViewController.swift
//  04_TodoTDD
//
//  Created by rae on 2021/11/23.
//

import UIKit

class TodoHomeViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
        tableView.rowHeight = 100
        return tableView
    }()
    
    private var todoData: [TodoEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapRightBarButton))
        
        setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTodoData()
        tableView.reloadData()
    }
    
    func setViews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    @objc func tapRightBarButton() {
        let nextVC = TodoAddViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func updateTodoData() {
        todoData = PersistenceManager.shared.fetch(request: TodoEntity.fetchRequest())
    }
}

extension TodoHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as? TodoTableViewCell else {
            fatalError("Unable dequeue TodoCell")
        }
 
        cell.titleLabel.text = todoData[indexPath.row].title
        cell.addressLabel.text = todoData[indexPath.row].address
        cell.timeLabel.text = todoData[indexPath.row].date
        
        return cell
    }
}

extension TodoHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let todo = todoData[indexPath.row]
        
        let nextVC = TodoDetailViewController()
        nextVC.todo = todo
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if PersistenceManager.shared.remove(object: todoData[indexPath.row]) == true {
                updateTodoData()
                tableView.reloadData()
            }
        }
    }
}

//
//  TasksViewController.swift
//  Task Tracker
//
//  Created by MongoDB on 2020-05-07.
//  Copyright © 2020 MongoDB, Inc. All rights reserved.
//

import UIKit
import RealmSwift

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    let realm: Realm
    var notificationToken: NotificationToken?

    required init(realm: Realm, title: String) {
        self.realm = realm
        

        super.init(nibName: nil, bundle: nil)

        self.title = title

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
    }

    override func viewDidLoad() {
        // Configure the view.
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = self.view.frame
        view.addSubview(tableView)

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonDidClick))

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // This defines how the Tasks in the list look.
        // We want the task name on the left and some indication of its status on the right.
        let task = tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.selectionStyle = .none
        cell.textLabel?.text = task.name
        switch task.statusEnum {
        case .Open:
            cell.accessoryView = nil
            cell.accessoryType = UITableViewCell.AccessoryType.none
        case .InProgress:
            let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
            label.text = "In Progress"
            cell.accessoryView = label
        case .Complete:
            cell.accessoryView = nil
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        return cell
    }

    @objc func addButtonDidClick() {
        let alertController = UIAlertController(title: "Add Task", message: "", preferredStyle: .alert)

        // When the user clicks the add button, present them with a dialog to enter the task name.
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: {
            _ -> Void in
            let textField = alertController.textFields![0] as UITextField

            
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addTextField(configurationHandler: { (textField: UITextField!) -> Void in
            textField.placeholder = "New Task Name"
        })

        // Show the dialog.
        self.present(alertController, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // User selected a task in the table. We will present a list of actions that the user can perform on this task.
        let task = tasks[indexPath.row]

        // Create the AlertController and add its actions.
        let actionSheet: UIAlertController = UIAlertController(title: task.name, message: "Select an action", preferredStyle: .actionSheet)


        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
                actionSheet.dismiss(animated: true)
            })

        // Show the actions list.
        self.present(actionSheet, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        // User can swipe to delete items.
        let task = tasks[indexPath.row]

    }


}

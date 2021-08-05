//
//  ProjectsViewController.swift
//
//
//  Copyright © 2020-2021 MongoDB, Inc. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    let userRealm: Realm
    var userData: User?
    var notificationToken: NotificationToken?

    init(userRealmConfiguration: Realm.Configuration) {
        self.userRealm = try! Realm(configuration: userRealmConfiguration)
        super.init(nibName: nil, bundle: nil)
        // There should only be one user in my realm - that is myself
        let usersInRealm = userRealm.objects(User.self)
        notificationToken = usersInRealm.observe { [weak self, usersInRealm] (_) in
            self?.userData = usersInRealm.first
            guard let tableView = self?.tableView else { return }
            tableView.reloadData()
        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        // Always invalidate any notification tokens when you are done with them.
        notificationToken?.invalidate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the view.
        title = "Projects"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = self.view.frame
        view.addSubview(tableView)

        // On the top left is a log out button.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutButtonDidClick))
    }

    @objc func logOutButtonDidClick() {
        let alertController = UIAlertController(title: "Log Out", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes, Log Out", style: .destructive, handler: {
            _ -> Void in
            print("Logging out...")
            self.navigationController?.popViewController(animated: true)
            app.currentUser?.logOut { (_) in
                DispatchQueue.main.async {
                    print("Logged out!")
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // You always have at least one project (your own)
        return userData?.memberOf.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.selectionStyle = .none

        //  User data may not have loaded yet. You always have your own project.
        let projectName = userData?.memberOf[indexPath.row].name ?? "My Project"
        cell.textLabel?.text = projectName

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = app.currentUser!
        let project = userData?.memberOf[indexPath.row] ?? Project(partition: "project=\(user.id)", name: "My Project")
        let configuration = user.configuration(partitionValue: project.partition!)
        Realm.asyncOpen(configuration: configuration) { [weak self] (result) in
            switch result {
            case .failure(let error):
                fatalError("Failed to open realm: \(error)")
            case .success(let realm):
                self?.navigationController?.pushViewController(
                    TasksViewController(realmConfiguration: configuration, title: "\(project.name!)'s Tasks"),
                    animated: true
                )
            }
        }
    }
}

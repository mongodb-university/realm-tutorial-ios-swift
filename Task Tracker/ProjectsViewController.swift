//
//  ProjectsViewController.swift
//
//
//  Created by MongoDB on 2020-05-04.
//

import Foundation
import UIKit
import RealmSwift

class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    let userRealm: Realm
    var notificationToken: NotificationToken?
    var userData: User?

    init(userRealm: Realm) {
        self.userRealm = userRealm

        super.init(nibName: nil, bundle: nil)

        // TODO: Observe user realm for user objects
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        // TODO: invalidate notificationToken
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
        let alertController = UIAlertController(title: "Log Out", message: "", preferredStyle: .alert);
        alertController.addAction(UIAlertAction(title: "Yes, Log Out", style: .destructive, handler: {
            alert -> Void in
            print("Logging out...");
            // TODO: log out the app's currentUser, then, on the main thread, pop this
            // view controller from the navigation controller to navigate back to
            // the WelcomeViewController.
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Each project should have its own row. Check the userData memberOf
        // field for how many projects the user is a member of. However, the userData
        // may not have loaded in yet. If that's the case, the user always has their
        // own project, so you should always return at least 1.
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.selectionStyle = .none

        // TODO: Get project name using userData's memberOf field and indexPath.row.
        // The userData may not have loaded yet. Regardless, you always have your own project.
        let projectName = "TODO"
        cell.textLabel?.text = projectName

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: open the realm for the selected project and navigate to the TasksViewController.
        // The project information is contained in the userData's memberOf field.
        // The userData may not have loaded yet. Regardless, the current user always has their own project.
        // A user's project partition value is "project=\(user.id!)". Use the user.configuration() with
        // the project's partition value to open the realm for that project.
    }

}

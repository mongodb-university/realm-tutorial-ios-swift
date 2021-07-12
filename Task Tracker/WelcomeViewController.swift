//
//  WelcomeViewController.swift
//  Task Tracker
//
//  Created by MongoDB on 2020-04-30.
//  Copyright © 2020-2021 MongoDB, Inc. All rights reserved.
//

import UIKit
import RealmSwift

// The WelcomeViewController handles login and account creation.
class WelcomeViewController: UIViewController {
    let usernameField = UITextField()
    let signInButton = UIButton(type: .roundedRect)
    let errorLabel = UILabel()
    let activityIndicator = UIActivityIndicatorView(style: .medium)

    var username: String? {
        get {
            return usernameField.text
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Create a view that will automatically lay out the other controls.
        let container = UIStackView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.alignment = .fill
        container.spacing = 16.0
        view.addSubview(container)

        // Configure the activity indicator.
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)

        // Set the layout constraints of the container view and the activity indicator.
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            // This pins the container view to the top and stretches it to fill the parent
            // view horizontally.
            container.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16),
            container.topAnchor.constraint(equalTo: guide.topAnchor, constant: 16),
            // The activity indicator is centered over the rest of the view.
            activityIndicator.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: guide.centerXAnchor)
            ])

        // Add some text at the top of the view to explain what to do.
        let infoLabel = UILabel()
        infoLabel.numberOfLines = 0
        infoLabel.text = "Please enter a username."
        container.addArrangedSubview(infoLabel)

        // Configure the username text input field.
        usernameField.placeholder = "Username"
        usernameField.borderStyle = .roundedRect
        usernameField.autocapitalizationType = .none
        usernameField.autocorrectionType = .no
        container.addArrangedSubview(usernameField)

        
        // Configure the sign in button.
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        container.addArrangedSubview(signInButton)

        
        // Error messages will be set on the errorLabel.
        errorLabel.numberOfLines = 0
        errorLabel.textColor = .red
        container.addArrangedSubview(errorLabel)
        
    }

    // Turn on or off the activity indicator.
    func setLoading(_ loading: Bool) {
        if loading {
            activityIndicator.startAnimating()
            errorLabel.text = ""
        } else {
            activityIndicator.stopAnimating()
        }
        
        usernameField.isEnabled = !loading
        signInButton.isEnabled = !loading
    }


    @objc func signIn() {
        // TODO: Replace the following code with code to launch the tasks view.
        let alertController = UIAlertController(title: "TODO", message: "Implement sign-in functionality in WelcomeViewController.swift", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true)
    }
}

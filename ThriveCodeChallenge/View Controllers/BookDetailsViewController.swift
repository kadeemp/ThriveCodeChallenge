//
//  BookAdditionViewController.swift
//  ThriveCodeChallenge
//
//  Created by Kadeem Palacios on 10/27/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var lastCheckedOutLabel: UILabel!
    @IBOutlet weak var checkOutBtn: UIButton!

    static var book:Book!
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Book Details"
        setupShareButton()
        setupLabels()
    }

    func setupLabels() {
        if BookDetailsViewController.book != nil {
            titleLabel.text = BookDetailsViewController.book.title
            authorLabel.text = BookDetailsViewController.book.author
            publisherLabel.text = "Publisher: \(BookDetailsViewController.book.publisher)"
            tagLabel.text = "Tags: \(BookDetailsViewController.book.categories)"
            lastCheckedOutLabel.text =  "Last checked out by \(BookDetailsViewController.book.lastCheckedOutBy!) \n Date: \(String(describing: BookDetailsViewController.book.lastCheckedOut!))"
        }
    }
    func setupShareButton() {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "Share Button"), for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(shareBtnPressed), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    @objc func shareBtnPressed() {
        var activityItems:[String] = []
        
        activityItems.append(BookDetailsViewController.book.author)
        activityItems.append(BookDetailsViewController.book.categories)
        activityItems.append(BookDetailsViewController.book.lastCheckedOut!)
        activityItems.append(BookDetailsViewController.book.title)
        activityItems.append(BookDetailsViewController.book.publisher)

        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }

    @IBAction func checkOutBtnPressed(_ sender: Any) {
        
        if let name = defaults.object(forKey: "name") as? String {
            NetworkingService.updateBook(id: BookDetailsViewController.book.id, bookChecker: name) { (updatedBook) in
                self.lastCheckedOutLabel.text =  "Last checked out by \(updatedBook.lastCheckedOutBy!) \n Date:  \(String(describing: updatedBook.lastCheckedOut!))"
                }
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
        else {
            let missingNameAlert = UIAlertController(title: "Please Register", message: "To start checking out books, please enter your full name below", preferredStyle: .alert)

            let nameSubmitAction = UIAlertAction(title: "Submit", style: .default) { (action) in
                let nameTextField = missingNameAlert.textFields![0] as UITextField
                self.defaults.set(nameTextField.text, forKey: "name")
                self.dismiss(animated: true, completion: nil)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            missingNameAlert.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "Full Name"

                missingNameAlert.addAction(nameSubmitAction)
                missingNameAlert.addAction(cancelAction)
                self.present(missingNameAlert, animated: true, completion: nil)

            })
        }
    }
}

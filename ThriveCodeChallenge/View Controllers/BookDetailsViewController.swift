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

        let bookCheckoutAlert = UIAlertController(title: "Book Checkout", message: "To check out this book, enter your full name below", preferredStyle: .alert)

        let nameSubmitAction = UIAlertAction(title: "Submit", style: .default) { (action) in
            let nameTextField = bookCheckoutAlert.textFields![0] as UITextField

            if nameTextField.text !=  "" {
                NetworkingService.updateBook(id: BookDetailsViewController.book.id, bookChecker: nameTextField.text!) { (updatedBook) in
                    self.lastCheckedOutLabel.text =  "Last checked out by \(updatedBook.lastCheckedOutBy!) \n Date:  \(String(describing: updatedBook.lastCheckedOut!))"
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        bookCheckoutAlert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Full Name"

            bookCheckoutAlert.addAction(nameSubmitAction)
            bookCheckoutAlert.addAction(cancelAction)
            self.present(bookCheckoutAlert, animated: true, completion: nil)
        })
    }
}

//
//  BookAdditionViewController.swift
//  ThriveCodeChallenge
//
//  Created by Kadeem Palacios on 10/27/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import UIKit

class BookAdditionViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet var screenTappedGestureRecognizer: UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Book"
        setupCancelButton()
    }

    func setupCancelButton() {
        let button = UIButton(type: .system)
        button.sizeToFit()
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(cancelBtnPressed), for: .touchUpInside)
        button.setTitleColor(UIColor.red, for: .normal)
        button.frame.size = CGSize(width: 50, height: 30)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }

    @objc func cancelBtnPressed() {
        if (bookTitleTextField.text != "" || authorTextField.text != "" || publisherTextField.text != "" || categoryTextField.text != "") {
            let midCompletionCancelAlert = UIAlertController(title: "Cancel Confirmation", message: "Are you sure you want to cancel? Your changes will not be saved", preferredStyle: .alert)

            let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            let noAction = UIAlertAction(title: "No", style: .default) { (action) in

            }
            midCompletionCancelAlert.addAction(noAction)
            midCompletionCancelAlert.addAction(yesAction)
            self.present(midCompletionCancelAlert, animated: true, completion: nil)

        } else {
             self.dismiss(animated: true, completion: nil)
        }

    }
    //MARK:- IB Actions
    @IBAction func submitPressed(_ sender: Any) {

        if (bookTitleTextField.text == "" || authorTextField.text == "") {
            let missingInfoAlert = UIAlertController(title: "Incomplete Form", message: "At least Title and Author fields must be filled out to add a book", preferredStyle: .alert)

            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in

            }
            missingInfoAlert.addAction(okAction)
            self.present(missingInfoAlert, animated: true, completion: nil)
        } else {
            NetworkingService.addBook(author: authorTextField.text!, categories: categoryTextField.text!, title: bookTitleTextField.text!, publisher: publisherTextField.text!) {
                () in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            }
        }

    }

    @IBAction func screenTapped(_ sender: Any) {

        if bookTitleTextField.isFirstResponder {
            bookTitleTextField.resignFirstResponder()
        } else if authorTextField.isFirstResponder {
            authorTextField.resignFirstResponder()
        } else if publisherTextField.isFirstResponder {
            publisherTextField.resignFirstResponder()
        } else if categoryTextField.isFirstResponder {
            categoryTextField.resignFirstResponder()
        }
    }
    //MARK:- UITextField Delegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if bookTitleTextField.isFirstResponder {
            authorTextField.becomeFirstResponder()
        } else if authorTextField.isFirstResponder {
            publisherTextField.becomeFirstResponder()
        } else if publisherTextField.isFirstResponder {
            categoryTextField.becomeFirstResponder()
        } else if categoryTextField.isFirstResponder {
            categoryTextField.resignFirstResponder()
        }
        return true
    }
}

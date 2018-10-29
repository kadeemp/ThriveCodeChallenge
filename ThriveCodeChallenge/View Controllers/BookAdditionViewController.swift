//
//  BookAdditionViewController.swift
//  ThriveCodeChallenge
//
//  Created by Kadeem Palacios on 10/27/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import UIKit

class BookAdditionViewController: UIViewController {

    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet var screenTappedGestureRecognizer: UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Book"
    }

    @IBAction func submitPressed(_ sender: Any) {
        if (bookTitleTextField.text != "" && authorTextField.text != "" && publisherTextField.text != "" && categoryTextField.text != ""){
            NetworkingService.addBook(author: authorTextField.text!, categories: categoryTextField.text!, title: bookTitleTextField.text!, publisher: publisherTextField.text!) {
                () in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    @IBAction func screenTapped(_ sender: Any) {
        self.resignFirstResponder()
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
}

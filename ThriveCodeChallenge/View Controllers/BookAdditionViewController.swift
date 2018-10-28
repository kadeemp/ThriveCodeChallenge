//
//  BookAdditionViewController.swift
//  ThriveCodeChallenge
//
//  Created by Kadeem Palacios on 10/27/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import UIKit

class BookAdditionViewController: UIViewController {

    @IBOutlet weak var bookTitleLabel: UITextField!
    @IBOutlet weak var authorLabel: UITextField!
    @IBOutlet weak var publisherLabel: UITextField!
    @IBOutlet weak var categoryLabel: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Book"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func submitPressed(_ sender: Any) {
        if (bookTitleLabel.text != nil && authorLabel.text != nil && publisherLabel.text != nil && categoryLabel.text != nil){
            NetworkingService.addBook(author: authorLabel.text!, categories: categoryLabel.text!, title: bookTitleLabel.text!, publisher: publisherLabel.text!) {
                () in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

                self.navigationController?.popViewController(animated: true)
            }
        }

        
    }

}

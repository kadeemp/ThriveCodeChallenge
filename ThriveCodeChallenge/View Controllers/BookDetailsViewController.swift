//
//  BookAdditionViewController.swift
//  ThriveCodeChallenge
//
//  Created by Kadeem Palacios on 10/27/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Book Details"
        if BookDetailsViewController.book != nil {
            titleLabel.text = BookDetailsViewController.book.title
            authorLabel.text = BookDetailsViewController.book.author
            publisherLabel.text = "Publisher: \(BookDetailsViewController.book.publisher)"
            tagLabel.text = "Tags: \(BookDetailsViewController.book.categories)"
            lastCheckedOutLabel.text = "Last Check Out: \n \(BookDetailsViewController.book.lastCheckedOut!)"
        }


        // Do any additional setup after loading the view.
    }
   static var book:Book!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    @IBOutlet weak var publisherLabel: UILabel!

     @IBOutlet weak var tagLabel: UILabel!

    @IBOutlet weak var lastCheckedOutLabel: UILabel!

    @IBOutlet weak var checkOutBtn: UIButton!
    @IBAction func checkOutBtnPressed(_ sender: Any) {

    }
}

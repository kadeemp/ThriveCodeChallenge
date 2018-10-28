//
//  BookLibraryViewController.swift
//  ThriveCodeChallenge
//
//  Created by Kadeem Palacios on 10/27/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import UIKit

class BookLibraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {



    @IBOutlet weak var bookTableView: UITableView!
    @IBOutlet weak var addBookButton: UIButton!

    var books:[Book] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkingService.returnBooks { (returnedBooks) in
            self.books = returnedBooks
            self.bookTableView.reloadData()
        }

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addBookPressed(_ sender: Any) {

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookTableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = books[indexPath.row].title
        return cell!
    }
}

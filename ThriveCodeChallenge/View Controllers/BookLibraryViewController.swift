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
        setupDeleteButton()
        self.title = "Book Library"
        NetworkingService.returnBooks { (returnedBooks) in
            self.books = returnedBooks
            self.bookTableView.reloadData()
        }
    }

    @IBAction func addBookPressed(_ sender: Any) {
        performSegue(withIdentifier: "segueToBookAddition", sender: self)
    }

    func setupDeleteButton() {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "Delete Button"), for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }

    @objc func deleteButtonPressed() {

        let alertView = UIAlertController(title: "Delete All Books", message: "Are you sure you want to delete all books in the library?",preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Yes", style: .destructive) { (action) in
            NetworkingService.deleteAllBooks()
        }
        let cancelAction = UIAlertAction(title: "No", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertView.addAction(cancelAction)
        alertView.addAction(deleteAction)
        self.present(alertView, animated: true, completion: nil)    }

    //MARK:Tableview Datasource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookTableView.dequeueReusableCell(withIdentifier: "cell") as! BookTableViewCell
        cell.bookTitleLabel.text  = books[indexPath.row].title
        cell.bookAuthorLabel.text = books[indexPath.row].author

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToDetail", sender: self)
        BookDetailsViewController.book = books[indexPath.row]
    }

    
}

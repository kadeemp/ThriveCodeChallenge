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
    private let refreshControl = UIRefreshControl()

    var books:[Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDeleteButton()
        self.title = "Book Library"
        loadBooks()
        refreshControlSetup()
        NotificationCenter.default.addObserver(self, selector: #selector(loadBooks), name: NSNotification.Name(rawValue: "load"), object: nil)
    }

    func refreshControlSetup() {
        if #available(iOS 10.0, *) {
            bookTableView.refreshControl = refreshControl
        } else {
            bookTableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)
    }

    @objc func refreshFeed() {
       loadBooks()

    }

    @IBAction func addBookPressed(_ sender: Any) {
        performSegue(withIdentifier: "segueToBookAddition", sender: self)
    }

    @objc func loadBooks() {
        NetworkingService.returnBooks { (returnedBooks) in
            self.books = returnedBooks
            self.bookTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
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
            self.books = []
            self.bookTableView.reloadData()

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

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = books[indexPath.row]
            NetworkingService.deleteBook(bookId: book.id)
            books.remove(at: indexPath.row)
            bookTableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
}

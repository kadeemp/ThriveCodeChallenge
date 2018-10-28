//
//  BookLibraryViewController.swift
//  ThriveCodeChallenge
//
//  Created by Kadeem Palacios on 10/27/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import UIKit

class BookLibraryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let bookDetails:[String:String] = [
            "author" : "Ash Maurya",
            "categories" : "process",
            "title" : "Running Lean",
            "publisher" : "O'REILLY"
        ]
       // NetworkingService.addBook(bookDetails: bookDetails)
        NetworkingService.returnBooks { (returnedBooks) in
            //update array, reload tableview
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

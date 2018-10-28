//
//  Book.swift
//  ThriveCodeChallenge
//
//  Created by Kadeem Palacios on 10/27/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import Foundation

struct Book {
    let author: String
    let categories: String
    let id: Int
    let lastCheckedOut:String?
    let lastCheckedOutBy : String?
    let publisher: String
    let title: String

    init(author: String, title:String, categories: String, id: Int, lastCheckedOut: String?, lastCheckedOutBy : String?, publisher: String) {
        self.author = author
        self.title = title
        self.categories = categories
        self.id = id
        self.lastCheckedOut = lastCheckedOut
        self.lastCheckedOutBy = lastCheckedOutBy
        self.publisher = publisher
    }
}

//
//  NetworkingService.swift
//  ThriveCodeChallenge
//
//  Created by Kadeem Palacios on 10/27/18.
//  Copyright © 2018 Kadeem Palacios. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class NetworkingService {

    private static let baseURL = "https://ivy-ios-challenge.herokuapp.com"
    private static var urlPath = "/books"

    static func returnBooks(completion:@escaping (_ returnedBooks:[Book]) -> ()) {

        var booksToReturn:[Book] = []

        Alamofire.request(baseURL + urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default , headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch response.result {
            case .success:
                if let json = response.result.value {
                    let booksJsonArray = JSON(json).arrayValue
                    booksToReturn = parseBooks(booksJSON: booksJsonArray)
                    completion(booksToReturn)

                }
            case .failure:
                print(response.error)

            }
        }
    }
    
    static func addBook(author:String, categories:String, title:String, publisher:String, completion:@escaping () -> ()) {

        let bookDetails:Dictionary<String,String> = ["author":author, "categories":categories, "title": title, "publisher": publisher]

        Alamofire.request(baseURL + urlPath, method: .post, parameters: bookDetails, encoding: JSONEncoding.default , headers: nil).responseString { (response:DataResponse<String>) in
            switch response.result {
            case .success:
                if let json = response.result.value {
                    print(json)
                    completion()
                }
            case .failure:
                print(response.error)


            }
        }
    }

    static func updateBook(id:Int,bookChecker:String, completion: @escaping (_ updatedBook:Book) -> ()) {

        let idString =  "/" + String(id)
        let checkoutDetails:Dictionary<String,String>  = ["lastCheckedOutBy":bookChecker]

        Alamofire.request(baseURL + urlPath + idString, method: .put, parameters: checkoutDetails, encoding: JSONEncoding.default , headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch response.result {
            case .success:
                if let json = response.result.value {

                    let bookJsonDictionary = JSON(json).dictionary!

                    let author = bookJsonDictionary["author"]!.stringValue
                    let title = bookJsonDictionary["title"]!.stringValue
                    let publisher = bookJsonDictionary["publisher"]!.stringValue
                    let categories = bookJsonDictionary["categories"]!.stringValue
                    let lastCheckedOut = bookJsonDictionary["lastCheckedOut"]!.stringValue
                    let lastCheckedOutBy = bookJsonDictionary["lastCheckedOutBy"]!.stringValue
                    let id = bookJsonDictionary["id"]!.intValue

                    let updatedBook = Book(author: author, title: title, categories: categories, id: id, lastCheckedOut: lastCheckedOut, lastCheckedOutBy: lastCheckedOutBy, publisher: publisher)
                    
                    completion(updatedBook)
                }
            case .failure:
                print(response.error)

            }
        }
    }

    static func deleteBook(bookId:Int) {

        urlPath += "/\(bookId)"

        Alamofire.request(baseURL + urlPath, method: .delete, parameters: nil, encoding: JSONEncoding.default , headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch response.result {
            case .success:
                if let json = response.result.value {
                    print(json)
                }
            case .failure:
                print(response.error)

            }
        }
    }
    static func deleteAllBooks() {

        urlPath = "/clean"

        Alamofire.request(baseURL + urlPath, method: .delete, parameters: nil, encoding: JSONEncoding.default , headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch response.result {
            case .success:
                if let json = response.result.value {
                    print(json)
                }
            case .failure:
                print(response.error)

            }
        }
    }
    
    static func parseBooks(booksJSON:[JSON]) -> [Book] {
        var booksToReturn:[Book] = []

        for book in booksJSON {
            let author = book["author"].stringValue
            let categories = book["categories"].stringValue
            let lastCheckedOut = book["lastCheckedOut"].stringValue
            let lastCheckedOutBy = book["lastCheckedOutBy"].stringValue
            let id = book["id"].intValue
            let publisher = book["publisher"].stringValue
            let title = book["title"].stringValue

            let newBook = Book(author: author, title: title, categories: categories, id: id, lastCheckedOut: lastCheckedOut, lastCheckedOutBy: lastCheckedOutBy, publisher: publisher)
            booksToReturn.append(newBook)
        }

        return booksToReturn
    }

    
}

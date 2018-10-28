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

    private static let baseURL = "https://ivy-ios-challenge.herokuapp.com/"
    private static var urlPath = "/books"



    static func returnBooks(completion:(_ returnedBooks:[Book]) -> ()) {

        Alamofire.request(baseURL + urlPath, method: .get, parameters: nil, encoding: JSONEncoding.default , headers: nil).responseJSON { (response:DataResponse<Any>) in
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
    static func addBook(bookDetails:Dictionary<String,String>) {

         Alamofire.request(baseURL + urlPath, method: .post, parameters: bookDetails, encoding: JSONEncoding.default , headers: nil).responseJSON { (response:DataResponse<Any>) in
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


    
}

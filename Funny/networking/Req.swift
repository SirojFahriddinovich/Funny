//
//  Req.swift
//  Funny
//
//  Created by Macbook Air on 20/04/22.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias DataComplationHandler = (JSON?) -> Void

class Req {
    
    static var `default` = Req()
    
    func getFactsCats(baseUrl : URL, responseJSON : @escaping DataComplationHandler) {
        
        AF.request(baseUrl, method: .get).response { response in
            if let data = response.data {
                let json = JSON(data)
                print(json)
                responseJSON(json)
            } else {
                responseJSON(nil)
            }
        }
    }
    
    
    func getCatsImages(url: URL, method : HTTPMethod, responseJSON : @escaping DataComplationHandler) {
        
        let header : HTTPHeaders = [
            "Accept-Version" : "v1",
            "Authorization"  : "Client-ID fkjhdZIW1oFXqD9zgenBjbIZ2DI8ru2utBoH8P3BLlM"
        ]
        
        let param = [
            "page" : "1",
            "per_page" : "10",
            "query" : "cat"
        ]
        
        AF.request(url, method: method, parameters: param, headers: header).response { response in
            if let data = response.data {
                let json = JSON(data)
                responseJSON(json)
            } else {
                responseJSON(nil)
            }
        }
    }
    
}

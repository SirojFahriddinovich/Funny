//
//  API.swift
//  Funny
//
//  Created by Macbook Air on 20/04/22.
//

import Foundation


class API {
    
   static let shared = API()
    
    let baseUrl = URL(string: "https://catfact.ninja/fact")!
    
    let catsImg = URL(string: "https://api.unsplash.com/search/photos")!
    
    func CatsFact(factCompleation : @escaping (String) -> Void) {
        Req.default.getFactsCats(baseUrl: baseUrl) { json in
            if let fact = json {
                let factStr = fact["fact"].stringValue
                factCompleation(factStr)
            } else {
                factCompleation("Server not working")
            }
        }
    }
    
    
    func getCatsImages(imagesURL : @escaping ([String]) -> Void) {
        Req.default.getCatsImages(url: catsImg, method: .get) { imgs in
            
            if let json = imgs {
               print("👍🏻👍🏻👍🏻👍🏻👍🏻👍🏻👍🏻👍🏻")
                var images = [String]()
                for i in json["results"].arrayValue {
                    print("☝🏻☝🏻☝🏻☝🏻☝🏻☝🏻☝🏻☝🏻")
                    images.append(i["urls"]["small"].stringValue)
                }
                imagesURL(images)
            } else {
                imagesURL([])
            }
        }
    }
    
}

//
//  Newsapi.swift
//  News App
//
//  Created by Aly Essam on 12/19/19.
//  Copyright © 2019 Aly Essam. All rights reserved.
//

import Foundation
import UIKit

class Newsapi {
        static let apiKey = "00f17d7e9da94b5ebc93f71bfe2928f2"

        enum Endpoints {

            static let base = "https://newsapi.org/v2/"

            case topHeadlines
            case everyThing

            var stringValue: String {
                switch self {
                case .topHeadlines:
                    return Endpoints.base + "top-headlines?country=us&pageSize=10&apiKey=\(Newsapi.apiKey)"
                    //Future Work
                case .everyThing:
                     return Endpoints.base + "everything?country=us&pageSize=10&apiKey=\(Newsapi.apiKey)"
                }
            }
                var url: URL {
                    return URL(string: stringValue)!
                }
    }
    
     class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void){
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in

                func sendError(_ error: String) {
                    let userInfo = [NSLocalizedDescriptionKey : error]
                    DispatchQueue.main.async {
                      completion(nil, NSError(domain: "taskForGETRequest", code: 1, userInfo: userInfo))
                    }
                }
                guard error == nil else {
                    print("Error")
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                    sendError("Request did not return a valid response.")
                    return
                }
                
                switch (statusCode) {

                case 400:
                sendError("Bad Request. The request was unacceptable, often due to a missing or misconfigured parameter.")
                case 401:
                sendError("Unauthorized. Your API key was missing from the request, or wasn't correct.")
                case 429:
                sendError("Too Many Requests. You made too many requests within a window of time and have been rate limited. Back off for a while.")
                case 500:
                sendError("Server Error. Something went wrong on our side.")

                default: break
                    
                }
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                
               
                let decoder = JSONDecoder()

                do {
                     let responseObject = try decoder.decode(ResponseType.self, from: data)
                     DispatchQueue.main.async {
                     completion(responseObject, nil)
                    }
                } catch {
                     DispatchQueue.main.async {
                     completion(nil, error)
                        }
                }
            }
        task.resume()
    }
    
    
    
    
    //Getting the Topheadlines
    class func getTopheadlines(completion: @escaping ([Articles], Error?) -> Void){
         taskForGETRequest(url: Endpoints.topHeadlines.url, responseType: NewsResponse.self) { (responseType, error) in
            if let responseType = responseType {
                completion(responseType.articles, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    
    //Future Work
    class func getEverything(completion: @escaping ([Articles], Error?) -> Void){
        
        taskForGETRequest(url: Endpoints.everyThing.url, responseType: NewsResponse.self) { (responseType, error) in
            if let responseType = responseType {
                completion(responseType.articles, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    
    
    
}

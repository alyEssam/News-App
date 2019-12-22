//
//  NewsRequest.swift
//  News App
//
//  Created by Aly Essam on 12/19/19.
//  Copyright © 2019 Aly Essam. All rights reserved.
//

import Foundation

struct NewsRequest : Codable {

    var news = [String : String]()
    
    init (country: String ,category: String, sources: String ,q: String, pageSize: String ,page: String)
    {
        news = ["country" : country , "category" : category, "sources" : sources, "q" : q, "pageSize" : pageSize, "page" : page]
    }
    
}


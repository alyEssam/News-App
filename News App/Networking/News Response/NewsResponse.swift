//
//  NewsResponse.swift
//  News App
//
//  Created by Aly Essam on 12/19/19.
//  Copyright © 2019 Aly Essam. All rights reserved.
//

import Foundation

struct Articles : Codable {
    let source : source
    let author : String?
    let title: String?
    let description : String?
    let publishedAt : String?
    let urlToImage: String?
    let url: String?
}

struct source : Codable {
    let id : String?
    let name : String?
}

struct NewsResponse :Codable {
    
    let articles : [Articles]
    
}


 
/*
 {
 "status": "ok",
 "totalResults": 38,
 "articles": [
         {
         "source": {
         "id": null,
         "name": "Youtube.com"
         },
         "author": null,
         "title": "Live: Sen. Mitch McConnell slams Dem impeachment on Senate floor - Fox News",
         "description": "Enjoy the videos and music you love, upload original content, and share it all with friends, family, and the world on YouTube.",
         "url": "https://www.youtube.com/watch?v=cv5vhF77f_I",
         "urlToImage": null,
         "publishedAt": "2019-12-19T14:35:10Z",
         "content": "[[getSimpleString(data.title)]]\r\n[[getSimpleString(data.description)]]\r\n[[getSimpleString(data.videoCountText)]]"
         }
 }
 */

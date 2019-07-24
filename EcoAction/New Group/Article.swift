//
//  Article.swift
//  EcoAction
//
//  Created by Shirley Wang on 10/7/19.
//  Copyright © 2019 Orbital2019Team1952. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class Article {
    var title: String
    var url: String
    
    init(title: String, url: String) {
        self.title = title
        self.url = url
    }
    
    class func createArticleArray() -> [Article] {
        var tempArticles: [Article] = []
        
        let article1 = Article(title: "Plastics Explained, From A to Z",
                               url: "https://news.nationalgeographic.com/2018/05/plastics-explained/")
        
        let article2 = Article(title: "Why carrying your own fork and spoon helps solve the plastic crisis",
                               url: "https://www.nationalgeographic.com/environment/2019/06/carrying-your-own-fork-spoon-help-plastic-crisis/")
        
        let article3 = Article(title: "Sustainable Earth: Water",
                               url: "https://www.nationalgeographic.com/environment/sustainable-earth/water/")
        
        let article4 = Article(title: "Europe has had five 500-year summers in 15 years. And now this",
                               url: "https://www.nationalgeographic.com/environment/2019/06/europe-has-had-five-500-year-summers-in-15-years/")
        
        tempArticles.append(article1)
        tempArticles.append(article2)
        tempArticles.append(article3)
        tempArticles.append(article4)
        
        return tempArticles
    }
    
}

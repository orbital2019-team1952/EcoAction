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
    var image: UIImage
    var url: String
    
    init(title: String, image: UIImage, url: String) {
        self.title = title
        self.image = image
        self.url = url
    }
    
    class func createArticleArray() -> [Article] {
        var tempArticles: [Article] = []
        
        let article1 = Article(title: "Plastics Explained, From A to Z",
                               image: #imageLiteral(resourceName: "plastic-1"),
                               url: "https://news.nationalgeographic.com/2018/05/plastics-explained/")
        
        let article2 = Article(title: "Why carrying your own fork and spoon helps solve the plastic crisis",
                               image: #imageLiteral(resourceName: "cutlery"),
                               url: "https://www.nationalgeographic.com/environment/2019/06/carrying-your-own-fork-spoon-help-plastic-crisis/")
        
        let article3 = Article(title: "Sustainable Earth: Water",
                               image: #imageLiteral(resourceName: "drop"),
                               url: "https://www.nationalgeographic.com/environment/sustainable-earth/water/")
        
        let article4 = Article(title: "Europe has had five 500-year summers in 15 years. And now this",
                               image: #imageLiteral(resourceName: "hot"),
                               url: "https://www.nationalgeographic.com/environment/2019/06/europe-has-had-five-500-year-summers-in-15-years/")
        let article5 = Article(title: "Eating meat has ‘dire’ consequences for the planet, says report",
                               image: #imageLiteral(resourceName: "no-meat (1)"),
                               url: "https://www.nationalgeographic.com/environment/2019/01/commission-report-great-food-transformation-plant-diet-climate-change/")
        
        tempArticles.append(article1)
        tempArticles.append(article2)
        tempArticles.append(article3)
        tempArticles.append(article4)
        tempArticles.append(article5)
        
        return tempArticles
    }
    
}

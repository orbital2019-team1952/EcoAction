//
//  ArticleCell.swift
//  EcoAction
//
//  Created by Shirley Wang on 5/7/19.
//  Copyright © 2019 Orbital2019Team1952. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var articleTitleLabel: UILabel!
    
    func setArticle(article: Article) {
        articleTitleLabel.text = article.title
        
    }
}

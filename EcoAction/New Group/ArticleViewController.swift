//
//  ArticleViewController.swift
//  EcoAction
//
//  Created by Shirley Wang on 29/6/19.
//  Copyright © 2019 Orbital2019Team1952. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SafariServices

class ArticleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var point: UILabel!
    var ref: DatabaseReference! = Database.database().reference()
    
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        
        articles = Article.createArticleArray()
        // Do any additional setup after loading the view.
    }
    

    func setLabel() {
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        ref.child("users").child(userID).observe( DataEventType.value, with: { (snapshot) in
            
            guard let dict = snapshot.value as? [String:AnyObject] else { return }
            
            guard let nicknameText = dict["nickname"] as? String else { return }
            
            guard let pointNum = dict["points"] as? Int else { return }
            
            self.nickname.text = nicknameText
            
            self.point.text = "\(pointNum)"
        })
        
    }

}

extension ArticleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = articles[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleCell
        
        cell.setArticle(article: article)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        let articleURL = URL(string: article.url)!
        let safariVC = SFSafariViewController(url: articleURL)
        present(safariVC, animated: true, completion: nil)
    }
    
}

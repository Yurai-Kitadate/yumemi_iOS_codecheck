//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var repoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!
    
    var vc1: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repo = vc1.repo[vc1.selectedRowIdx]
        
        setLabelsText(repo: repo)
        getImage()
        
    }
    
    func setLabelsText(repo:[String : Any]){
        languageLabel.text = "Written in \(repo["language"] as? String ?? "")"
        starsLabel.text = "\(repo["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(repo["watchers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(repo["forks_count"] as? Int ?? 0) forks"
        issuesLabel.text = "\(repo["open_issues_count"] as? Int ?? 0) open issues"
    }
    
    func getImage(){
        
        let repo = vc1.repo[vc1.selectedRowIdx]
        
        titleLabel.text = repo["full_name"] as? String
        
        if let owner = repo["owner"] as? [String: Any], let imgURL = owner["avatar_url"] as? String,let url = URL(string: imgURL){
            URLSession.shared.dataTask(with: url) { (data, res, err) in
                if let unwrappedData = data,let img = UIImage(data: unwrappedData){
                    DispatchQueue.main.async {
                        self.repoImageView.image = img
                    }
                }
            }.resume()
        }
    }
}

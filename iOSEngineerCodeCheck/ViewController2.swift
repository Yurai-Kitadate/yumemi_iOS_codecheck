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
    
    var imageLoader : ImageLoader = ImageLoader()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let repo = vc1.client.repo?.items[vc1.selectedRowIdx]
        
        setLabelsText(repo: repo)
        getImage()
        
    }
    
    func setLabelsText(repo:Repository?){
        
        languageLabel.text = "Written in \(repo?.language as? String ?? "")"
        starsLabel.text = "\(repo?.stargazers_count as? Int ?? 0) stars"
        watchersLabel.text = "\(repo?.watchers_count as? Int ?? 0) watchers"
        forksLabel.text = "\(repo?.forks_count as? Int ?? 0) forks"
        issuesLabel.text = "\(repo?.open_issues_count as? Int ?? 0) open issues"
        titleLabel.text = repo?.full_name as? String ?? ""
    }
    
    func getImage(){
        
        Task.init {
            await imageLoader.load(owner: vc1.client.repo?.items[vc1.selectedRowIdx]?.owner)
            DispatchQueue.main.async {
                self.repoImageView.image = self.imageLoader.image
            }
        }
    }
}

class ImageLoader{
    
    var image : UIImage?
    func load(owner:Owner?)async{
        
        if let unwrappedOwner = owner,let unwrapped_url = unwrappedOwner.avatar_url,let url = URL(string: unwrapped_url){
            print(unwrapped_url)
            var urlRequest = URLRequest(url: url)
            do{
                print(unwrapped_url)
                urlRequest.httpMethod = "GET"
                let (data, _) = try await URLSession.shared.data(for: urlRequest)
                if let img = UIImage(data: data){
                    DispatchQueue.main.async {
                        self.image = img
                    }
                }
            }catch{
                print("image load error")
            }
        }
    }
}

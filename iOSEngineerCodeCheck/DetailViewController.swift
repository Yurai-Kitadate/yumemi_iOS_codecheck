//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var repoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!
    
    var vc1: TableViewController!
    
    var imageLoader : ImageLoader = ImageLoader()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let repo = vc1.repositriesViewModel.repo?.items[vc1.selectedRowIdx]
        
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
            await imageLoader.load(owner: vc1.repositriesViewModel.repo?.items[vc1.selectedRowIdx]?.owner)
            DispatchQueue.main.async {
                self.repoImageView.image = self.imageLoader.image
            }
        }
    }
}

class ImageLoader{
    
    var image : UIImage?
    
    func load(owner:Owner?)async{
        
        if let unwrappedOwner = owner,let avatar_url = unwrappedOwner.avatar_url{
            let data = await searchFromUrl(searchType: .image, keyWord: avatar_url)
            if let unwrappedData = data,let img = UIImage(data: unwrappedData){
                DispatchQueue.main.async {
                    self.image = img
                }
            }
        }
    }
}


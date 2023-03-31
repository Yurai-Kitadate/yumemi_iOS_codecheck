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
    var imageModel : ImageViewModel = ImageViewModel()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let repo = vc1.repositoriesModel.repositories?.items[vc1.selectedRowIdx]
        
        setLabelsText(repo: repo)
        setImage(owner: repo?.owner)
    }
    
    
    
    func setImage(owner : Owner?){
        if let owner = owner, let avatarUrl = owner.avatar_url {
            self.imageModel.getImage(from: avatarUrl) { [weak self] image in
                DispatchQueue.main.async {
                    self?.repoImageView.image = image
                }
            }
        }
    }
    
    func setLabelsText(repo:Repository?){
        
        languageLabel.text = "Written in \(repo?.language as? String ?? "")"
        starsLabel.text = "\(repo?.stargazers_count as? Int ?? 0) stars"
        watchersLabel.text = "\(repo?.watchers_count as? Int ?? 0) watchers"
        forksLabel.text = "\(repo?.forks_count as? Int ?? 0) forks"
        issuesLabel.text = "\(repo?.open_issues_count as? Int ?? 0) open issues"
        titleLabel.text = repo?.full_name as? String ?? ""
    }
}

class ImageViewModel {
    func getImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        Task.init {
            if let data = await searchFromUrl(searchType: .image, keyWord:urlString) {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                completion(nil)
            }
        }
    }
}

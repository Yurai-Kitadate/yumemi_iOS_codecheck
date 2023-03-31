
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController,UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    var selectedRowIdx: Int = 0
    var repositories: Repositories? {
            didSet {
                self.tableView.reloadData()
            }
        }
    
    let repositoriesModel = RepositoriesModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //searchBarのデリゲートとplaceholderを設定
        searchBar.placeholder = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail"{
            if let detail = segue.destination as? DetailViewController {
                detail.vc1 = self
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositories?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        guard let items = self.repositories?.items[indexPath.row] else{
            return cell
        }
        cell.set(fullName: items.full_name, language: items.language, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 選択されたrowのdetailに遷移
        selectedRowIdx = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.scrollToRow(at: indexPath, at: .none, animated: true)
        }
    }
}

extension UITableViewCell{
    
    func set(fullName:String?,language:String?,indexPath: IndexPath){
        self.textLabel?.text = fullName ?? ""
        self.detailTextLabel?.text = language ?? ""
        self.tag = indexPath.row
    }
}

extension TableViewController: SearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Task.init {
            await repositoriesModel.load(searchBarWord: searchBar.text)
            DispatchQueue.main.async {
                self.repositories = self.repositoriesModel.repositories
            }
        }
    }
}

protocol SearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
}

class RepositoriesModel{
    
    var repositories : Repositories?
    
    func load(searchBarWord:String?)async{
        if let word = searchBarWord,let data = await searchFromUrl(searchType: .repositories, keyWord: word){
            let d = JSONDecoder()
            DispatchQueue.main.async {
                do{
                    self.repositories = try d.decode(Repositories.self, from: data)
                }catch{
                    print("json parse error")
                }
            }
        }
    }
}

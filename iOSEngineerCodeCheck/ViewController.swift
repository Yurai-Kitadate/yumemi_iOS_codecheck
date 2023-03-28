//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var repo: [[String: Any]]=[]
    var task: URLSessionTask?
    var word: String?
    var url: String?
    var selectedRowIdx: Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //searchBarのデリゲートとplaceholderを設定
        searchBar.placeholder = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let word = searchBar.text ,!word.isEmpty,
           let url = URL(string: "https://api.github.com/search/repositories?q=\(word)"){
            task?.cancel()
            task = URLSession.shared.dataTask(with:url) { (data, _, err) in
                if err == nil,let unwrappedData = data,let obj = try? JSONSerialization.jsonObject(with: unwrappedData) as? [String: Any] {
                    if let items = obj["items"] as? [[String: Any]] {
                        self.repo = items
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            // urlSessionのタスクを開始
            task?.resume()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail"{
            if let detail = segue.destination as? ViewController2 {
                detail.vc1 = self
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return repo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let rp = repo[indexPath.row]
        cell.textLabel?.text = rp["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = rp["language"] as? String ?? ""
        cell.tag = indexPath.row
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

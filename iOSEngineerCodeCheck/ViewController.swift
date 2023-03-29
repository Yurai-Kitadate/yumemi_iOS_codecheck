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

    let decoder = JSONDecoder()
    var repo:  Repositories = Repositories(total_count: 0, incomplete_results: false, items: [])
    var task: URLSessionTask?
    var word: String?
    var url: String?
    var selectedRowIdx: Int = 0

    var client : GitHubAPIClient = GitHubAPIClient()

    override func viewDidLoad() {

        super.viewDidLoad()
        //searchBarのデリゲートとplaceholderを設定
        searchBar.placeholder = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        Task.init {
            await client.load(searchBarWord: searchBar.text)
            self.repo = client.repo
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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

        return repo.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        let rp = repo.items[indexPath.row]
        cell.textLabel?.text = rp?.full_name as? String ?? ""
        cell.detailTextLabel?.text = rp?.language as? String ?? ""
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


class GitHubAPIClient{
    var repo:  Repositories = Repositories(total_count: 0, incomplete_results: false, items: [])

    func load(searchBarWord:String?)async{
        if let word = searchBarWord ,!word.isEmpty,
           let url = URL(string: "https://api.github.com/search/repositories?q=\(word)"){
            var urlRequest = URLRequest(url: url)
            do{
                urlRequest.httpMethod = "GET"
                let (data, _) = try await URLSession.shared.data(for: urlRequest)
                let d = JSONDecoder()
                repo = try! d.decode(Repositories.self, from: data)
                print(repo)
            }catch{
                print("json parse error")
            }
        }
    }
}

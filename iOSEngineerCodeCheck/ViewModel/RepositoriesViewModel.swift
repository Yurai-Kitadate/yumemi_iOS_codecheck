//
//  RepositoriesViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 北舘友頼 on 2023/03/31.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

class RepositoriesViewModel{
    
    var repositories : Repositories?
    
    func load(searchBarWord:String?) async{
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

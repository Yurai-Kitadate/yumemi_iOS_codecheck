//
//  Repository.swift
//  iOSEngineerCodeCheck
//
//  Created by 北舘友頼 on 2023/03/28.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

struct Repositories : Decodable{
    let total_count : Int?
    let incomplete_results : Bool?
    let items : [Repository?]
}

struct Repository : Decodable{
    let name : String?
    let full_name : String?
    let owner : Owner?
    let stargazers_count : Int?
    let watchers_count : Int?
    let language : String?
    let forks_count : Int?
    let open_issues_count : Int?
    
    
}

struct Owner : Decodable{
    let avatar_url : String?
}

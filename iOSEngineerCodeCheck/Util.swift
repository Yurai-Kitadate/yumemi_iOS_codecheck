//
//  Util.swift
//  iOSEngineerCodeCheck
//
//  Created by 北舘友頼 on 2023/03/30.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
func substring(_ str: String, start: Int, end: Int) -> String? {
    guard start <= end else {
        return nil
    }
    let startIdx = str.index(str.startIndex, offsetBy: start)
    let endIdx = str.index(str.startIndex, offsetBy: end)
    return String(str[startIdx..<endIdx])
}

func execute_url_request(str:String?)async -> Data? {
    if let unwrapped_str = str,let url = URL(string: unwrapped_str){
        do{
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            return data
        }catch{
            print("load error")
            return nil
        }
    }
    print("url unwrapp error")
    return nil
}


func searchFromUrl(searchType:SearchType,keyWord : String) async -> Data?{
    
    switch searchType{
    case .repositories:
        let githubUrlPrefix = "https://api.github.com/search/repositories?q="
        return await execute_url_request(str:  githubUrlPrefix + keyWord)
    case .image:
        return await execute_url_request(str: keyWord)
        
    }
}

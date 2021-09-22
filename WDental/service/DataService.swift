//
//  DataService.swift
//  WDental
//
//  Created by Sidraque on 20/09/21.
//

import Foundation
import Alamofire

struct DataService {
    
    // MARK: - Singleton
    static let shared = DataService()
    
    // MARK: - URL
    private var baseUrl = "https://jsonplaceholder.typicode.com"
    // MARK: - Endpoints
    private var posts = "/posts"
    
    // MARK: - Services

    func requestFetchLogin(with id: Int, completion: @escaping (Login?, Error?) -> ()) {
        let url = "\(baseUrl)\(posts)/\(id)"
        Alamofire.request(url).responseLogin { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let login = response.result.value {
                completion(login, nil)
                return
            }
        }
    }
    
    
    
}

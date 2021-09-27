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
    
    private var baseUrl = "https://jsonplaceholder.typicode.com"
    // MARK: - Endpoints
    private var posts = "/posts"
    private var register = "/comments"
    private var recoverPassword = "/albums"
    
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
    
    func requestFetchRegister(with id: Int, completion: @escaping (Register?, Error?) -> ()) {
        let url = "\(baseUrl)\(register)/\(id)"
        Alamofire.request(url).responseRegister { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let register = response.result.value {
                completion(register, nil)
                return
            }
        }
    }
    
    func requestFetchRecoverPassword(with id: Int, completion: @escaping (RecoverPassword?, Error?) -> ()) {
        let url = "\(baseUrl)\(recoverPassword)/\(id)"
        Alamofire.request(url).responseRecoverPassword { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let recoverPassword = response.result.value {
                completion(recoverPassword, nil)
                return
            }
        }
    }
    
    
    
}

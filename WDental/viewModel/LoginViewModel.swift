//
//  LoginViewModel.swift
//  WDental
//
//  Created by Sidraque on 20/09/21.
//

import Foundation

class LoginViewModel {
    
    // MARK: - Properties
    private var login: Login? {
        didSet {
            guard let p = login else { return }
            self.setupText(with: p)
            self.didFinishFetch?()
        }
    }
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    var userID: String?
    var title: String?
    var body: String?
    
    private var dataService: DataService?
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // MARK: - Network call
    func fetchLogin(withId id: Int) {
        self.dataService?.requestFetchLogin(with: id, completion: { (login, error) in
            if let error = error {
                self.error = error
                self.isLoading = false
                return
            }
            self.isLoading = true
            self.error = nil
            self.isLoading = false
            self.login = login
            
        })
    }
    
    // MARK: - UI Logic
    private func setupText(with login: Login) {
        if let userId = login.userID, let title = login.title, let body = login.body{
            self.userID = "UserID: \(userId)"
            self.title = "Title : \(title)"
            self.body = "Body : \(body)"
        }
    }
    
    
}

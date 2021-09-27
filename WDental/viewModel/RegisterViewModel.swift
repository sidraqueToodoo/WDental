//
//  RegisterViewModel.swift
//  WDental
//
//  Created by Sidraque on 23/09/21.
//

import Foundation

class RegisterViewModel {
    // MARK: - Properties
    private var register: Register? {
        didSet {
            guard let p = register else { return }
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
    
    var postID: String?
    var name: String?
    var email: String?
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
    func fetchRegister(withId id: Int) {
        self.dataService?.requestFetchRegister(with: id, completion: { (register, error) in
            if let error = error {
                self.error = error
                self.isLoading = false
                return
            }
            self.isLoading = true
            self.error = nil
            self.isLoading = false
            self.register = register
        })
    }
    
    // MARK: - UI Logic
    private func setupText(with register: Register) {
        if let postId = register.postID, let name = register.name, let email = register.email, let body = register.body{
            self.postID = "PostID: \(postId)"
            self.name = "Name: \(name)"
            self.email = "E-mail: \(email)"
            self.body = "Body: \(body)"
        }
    }
    
    
}

//
//  RecoverPasswordViewModel.swift
//  WDental
//
//  Created by Sidraque on 24/09/21.
//

import Foundation

class RecoverPasswordViewModel {
    // MARK: - Properties
    private var recoverPassword: RecoverPassword? {
        didSet {
            guard let p = recoverPassword else { return }
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
    func fetchRecoverPassword(withId id: Int) {
        self.dataService?.requestFetchRecoverPassword(with: id, completion: { (recoverPassword, error) in
            if let error = error {
                self.error = error
                self.isLoading = false
                return
            }
            self.isLoading = true
            self.error = nil
            self.isLoading = false
            self.recoverPassword = recoverPassword
        })
    }
    
    // MARK: - UI Logic
    private func setupText(with recoverPassword: RecoverPassword) {
        if let userId = recoverPassword.userId, let title = recoverPassword.title{
            self.userID = "UserID: \(userId)"
            self.title = "Título: \(title)"
        }
    }
    
    
}

//
//  WDentalViewController.swift
//  WDental
//
//  Created by Sidraque on 14/09/21.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tfCpf: UITextField!{
        didSet{
            tfCpf.layer.borderColor = UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1.00).cgColor
            tfCpf.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var tfPassword: UITextField!{
        didSet{
            tfPassword.layer.borderColor = UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1.00).cgColor
            tfPassword.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var btForgotPassword: UIButton!
    @IBOutlet weak var btToEnter: UIButton!
    @IBOutlet weak var btFirstAccess: UIButton!{
        didSet{
            btFirstAccess.layer.borderColor = UIColor(red: 0.07, green: 0.10, blue: 0.24, alpha: 1.00).cgColor
            btFirstAccess.layer.borderWidth = 1
            btFirstAccess.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var btHireNow: UIButton!{
        didSet{
            btHireNow.layer.borderColor = UIColor(red: 0.07, green: 0.10, blue: 0.24, alpha: 1.00).cgColor
            btHireNow.layer.borderWidth = 1
            btHireNow.layer.cornerRadius = 10
        }
    }

    @IBOutlet weak var ivCheckCpf: UIImageView!
    @IBOutlet weak var ivCheckPassword: UIImageView!

    @IBOutlet weak var lbCPF: UILabel!
    @IBOutlet weak var lbPassword: UILabel!
    
    // MARK: - Injection
    let viewModel = LoginViewModel(dataService: DataService())
    let service = DataService()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Networking
    
    private func attemptFetchLogin(withId id: Int) {
          viewModel.fetchLogin(withId: id)
          
          viewModel.updateLoadingStatus = {
              let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
          }
          
          viewModel.showAlertClosure = {
              if let error = self.viewModel.error {
                  print(error.localizedDescription)
              }
          }
          
          viewModel.didFinishFetch = {
            print(self.viewModel.userID!)
            print(self.viewModel.title!)
            print(self.viewModel.body!)
          }
    }
    
    
    // MARK: - UI Setup
    private func activityIndicatorStart() {
        activityIndicator.startAnimating()
        print("start")
    }
    
    private func activityIndicatorStop() {
        performSegue(withIdentifier: "successfulSegue", sender: nil)
        print("stop")
    }
    
    
    @IBAction func actionLogin(_ sender: UIButton) {
        attemptFetchLogin(withId: 15)
    }
    
    
    

    @IBAction func forgotPasswordAndCpfClose(_ sender: UITextField) {
        if  tfPassword.text?.isEmpty == false {
            btForgotPassword.isHidden = true
            lbPassword.isHidden = false
        }else{
            btForgotPassword.isHidden = false
            ivCheckPassword.image = UIImage?(nil)
            lbPassword.isHidden = true
        }

        if  tfCpf.text?.isEmpty == false {
            lbCPF.isHidden = false
        }else{
            ivCheckCpf.image = UIImage?(nil)
            lbCPF.isHidden = true
        }

        if let selectedRange = tfCpf.selectedTextRange {

            let cursorPosition = tfCpf.offset(from: tfCpf.beginningOfDocument, to: selectedRange.start)
            
            print ("\(cursorPosition)")

            var appendString = ""

            switch cursorPosition {
            case 3:
                appendString = "."
            case 7:
                appendString = "."
            case 11:
                appendString = "-"
            default:
                break
            }

            tfCpf.text?.append(appendString)

            if (tfCpf.text?.count)! == 14{
                tfCpf.isEnabled = false
                tfCpf.isEnabled = true
            }
        }

    }
    
    
    
    @IBAction func clearCpf(_ sender: UITextField) {
        if  tfCpf.text?.isEmpty == false {
            tfCpf.text = nil
        }
    }
    



    @IBAction func checkPasswordCpf(_ sender: UITextField) {
        if  tfPassword.text?.isEmpty == false {
            ivCheckPassword.image = UIImage(named: "ok")
            lbPassword.isHidden = false
        }

        if  tfCpf.text?.isEmpty == false {
            ivCheckCpf.image = UIImage(named: "ok")
            lbCPF.isHidden = false
        }
    }

}

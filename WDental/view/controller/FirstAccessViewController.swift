//
//  FirstAccessViewController.swift
//  WDental
//
//  Created by Sidraque on 16/09/21.
//

import UIKit

class FirstAccessViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var lbCpf: UILabel!
    @IBOutlet weak var tfCpf: UITextField!
    @IBOutlet weak var ivCheckCpf: UIImageView!
    
    @IBOutlet weak var lbBirthDate: UILabel!
    @IBOutlet weak var tfBirthDate: UITextField!
    @IBOutlet weak var ivCheckBirthDate: UIImageView!
    
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var ivCheckEmail: UIImageView!
    
    @IBOutlet weak var lbConfirmEmail: UILabel!
    @IBOutlet weak var tfConfirmEmail: UITextField!
    @IBOutlet weak var ivCheckConfirmEmail: UIImageView!
    
    @IBOutlet weak var lbPassword: UILabel!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var ivCheckPassword: UIImageView!
    
    @IBOutlet weak var lbConfirmPassword: UILabel!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var ivCheckConfirmPassword: UIImageView!
    
    // MARK: - Injection
    let viewModel = RegisterViewModel(dataService: DataService.shared)
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        activityIndicator.hidesWhenStopped = true
    }
    
    // MARK: - Networking
    private func attemptFetchRegister(withId id: Int) {
          viewModel.fetchRegister(withId: id)
          
          viewModel.updateLoadingStatus = {
              let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
          }
          
          viewModel.showAlertClosure = {
              if let error = self.viewModel.error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)

                alert.addAction(UIAlertAction(title: "Voltar", style: UIAlertAction.Style.cancel, handler: { _ in
                }))
                self.present(alert, animated: true, completion: nil)
              }
          }
          
          viewModel.didFinishFetch = {
            print(self.viewModel.postID!)
            print(self.viewModel.name!)
            print(self.viewModel.email!)
            print(self.viewModel.body!)
          }
    }
    
    
    // MARK: - UI Setup
    private func activityIndicatorStart() {
        activityIndicator.startAnimating()
        print("start")
    }
    
    private func activityIndicatorStop() {
        let alert = UIAlertController(title: "Cadastrado com sucesso", message: "Volte para tela de login", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ir para Login", style: UIAlertAction.Style.default, handler: { _ in
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
        print("stop")
        
    }
    
    
    @IBAction func actionRegister(_ sender: UIButton) {
        attemptFetchRegister(withId: 15)
    }
    
    
    @IBAction func changedTextFields(_ sender: UITextField) {
        
        if  tfCpf.text?.isEmpty == false {
            lbCpf.isHidden = false
        }else{
            ivCheckCpf.image = UIImage?(nil)
            lbCpf.isHidden = true
        }
        
        if  tfBirthDate.text?.isEmpty == false {
            lbBirthDate.isHidden = false
        }else{
            ivCheckBirthDate.image = UIImage?(nil)
            lbBirthDate.isHidden = true
        }
        
        if  tfEmail.text?.isEmpty == false {
            lbEmail.isHidden = false
        }else{
            ivCheckEmail.image = UIImage?(nil)
            lbEmail.isHidden = true
        }
        
        if  tfConfirmEmail.text?.isEmpty == false {
            lbConfirmEmail.isHidden = false
        }else{
            ivCheckConfirmEmail.image = UIImage?(nil)
            lbConfirmEmail.isHidden = true
        }
        
        if  tfPassword.text?.isEmpty == false {
            lbPassword.isHidden = false
        }else{
            ivCheckPassword.image = UIImage?(nil)
            lbPassword.isHidden = true
        }
        
        if  tfConfirmPassword.text?.isEmpty == false {
            lbConfirmPassword.isHidden = false
        }else{
            ivCheckConfirmPassword.image = UIImage?(nil)
            lbConfirmPassword.isHidden = true
        }
        
        //MARK: - MASK CPF
        
        if let selectedRange = tfCpf.selectedTextRange {

            let cursorPosition = tfCpf.offset(from: tfCpf.beginningOfDocument, to: selectedRange.start)
            
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
        
        //MARK: - MASK DATA
        
        if let selectedRange2 = tfBirthDate.selectedTextRange {

            let cursorPosition = tfBirthDate.offset(from: tfBirthDate.beginningOfDocument, to: selectedRange2.start)
            
            var appendString = ""

            switch cursorPosition {
            case 2:
                appendString = "/"
            case 5:
                appendString = "/"
            default:
                break
            }

            tfBirthDate.text?.append(appendString)

            if (tfBirthDate.text?.count)! == 10{
                tfBirthDate.isEnabled = false
                tfBirthDate.isEnabled = true
            }
        }
    }
    
    @IBAction func didBeginData(_ sender: UITextField) {
        if  tfBirthDate.text?.isEmpty == false {
            tfBirthDate.text = nil
        }
    }

    @IBAction func didBeginCpf(_ sender: UITextField) {
        if  tfCpf.text?.isEmpty == false {
            tfCpf.text = nil
        }
    }
    
    @IBAction func didEndTextFields(_ sender: UITextField) {
        if  tfCpf.text?.isEmpty == false {
            ivCheckCpf.image = UIImage(named: "ok")
            lbCpf.isHidden = false
        }
        
        if  tfBirthDate.text?.isEmpty == false {
            ivCheckBirthDate.image = UIImage(named: "ok")
            lbBirthDate.isHidden = false
        }
        
        if  tfEmail.text?.isEmpty == false {
            ivCheckEmail.image = UIImage(named: "ok")
            lbEmail.isHidden = false
        }
        
        if  tfConfirmEmail.text?.isEmpty == false {
            ivCheckConfirmEmail.image = UIImage(named: "ok")
            lbConfirmEmail.isHidden = false
        }
        
        if  tfPassword.text?.isEmpty == false {
            ivCheckPassword.image = UIImage(named: "ok")
            lbPassword.isHidden = false
        }
        
        if  tfConfirmPassword.text?.isEmpty == false {
            ivCheckConfirmPassword.image = UIImage(named: "ok")
            lbConfirmPassword.isHidden = false
        }

        
    }
    

}

extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
    
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}

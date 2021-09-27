//
//  ResetPasswordViewController.swift
//  WDental
//
//  Created by Sidraque on 18/09/21.
//

import UIKit

class ResendPasswordViewController: UIViewController {
    
    //MARK:- View 2
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var btHome: UIButton!{
        didSet{
            btHome.layer.borderColor = UIColor(red: 0.07, green: 0.10, blue: 0.24, alpha: 1.00).cgColor
            btHome.layer.borderWidth = 1
            btHome.layer.cornerRadius = 20
        }
    }
    //MARK:- View 1
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lbCpf: UILabel!
    @IBOutlet weak var tfCpf: UITextField!
    @IBOutlet weak var ivCheckCpf: UIImageView!
    
    @IBOutlet weak var lbBirthDate: UILabel!
    @IBOutlet weak var tfBirthDate: UITextField!
    @IBOutlet weak var ivCheckBirthDate: UIImageView!
    
    @IBOutlet weak var btResendPassword: UIButton!
    
    // MARK: - Injection
    let viewModel = RecoverPasswordViewModel(dataService: DataService.shared)
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
    // MARK: - Networking
    private func attemptFetchRecoverPassword(withId id: Int) {
          viewModel.fetchRecoverPassword(withId: id)
          
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
            print(self.viewModel.userID!)
            print(self.viewModel.title!)
            self.lbEmail.text = (self.viewModel.title!)
          }
    }
    
    
    // MARK: - UI Setup
    private func activityIndicatorStart() {
        activityIndicator.startAnimating()
        print("start")
    }
    
    private func activityIndicatorStop() {
        view2.isHidden = false
        print("stop")
    }
    
    @IBAction func actionRecover(_ sender: UIButton) {
        attemptFetchRecoverPassword(withId: 15)
    }
    
    @IBAction func changedTextFields(_ sender: UITextField) {
        
        if  tfCpf.text?.isEmpty == false {
            lbCpf.isHidden = false
        }else{
            lbCpf.isHidden = true
        }
        
        if  tfBirthDate.text?.isEmpty == false {
            lbBirthDate.isHidden = false
        }else{
            lbBirthDate.isHidden = true
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
                ivCheckCpf.image = UIImage(named: "ok")
                lbCpf.isHidden = false
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
                ivCheckBirthDate.image = UIImage(named: "ok")
                lbBirthDate.isHidden = false
            }
        }
    }
    
    @IBAction func didBeginDate(_ sender: UITextField) {
        if  tfBirthDate.text?.isEmpty == false {
            tfBirthDate.text = nil
            ivCheckBirthDate.image = UIImage?(nil)
            lbBirthDate.isHidden = true
        }
    }

    @IBAction func didBeginCpf(_ sender: UITextField) {
        if  tfCpf.text?.isEmpty == false {
            tfCpf.text = nil
            ivCheckCpf.image = UIImage?(nil)
            lbCpf.isHidden = true
        }
    }
    
    @IBAction func didEndTextFields(_ sender: UITextField) {
        if (tfCpf.text?.isEmpty == true) || (tfBirthDate.text?.isEmpty == true){
            btResendPassword.isEnabled = false
        }else{
            btResendPassword.isEnabled = true
        }
        
    }
    
    
    
    
}

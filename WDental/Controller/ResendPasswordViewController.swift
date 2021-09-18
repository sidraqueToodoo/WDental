//
//  ResetPasswordViewController.swift
//  WDental
//
//  Created by Sidraque on 18/09/21.
//

import UIKit

class ResendPasswordViewController: UIViewController {
    
    @IBOutlet weak var lbCpf: UILabel!
    @IBOutlet weak var tfCpf: UITextField!
    @IBOutlet weak var ivCheckCpf: UIImageView!
    
    @IBOutlet weak var lbBirthDate: UILabel!
    @IBOutlet weak var tfBirthDate: UITextField!
    @IBOutlet weak var ivCheckBirthDate: UIImageView!
    
    @IBOutlet weak var btResendPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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

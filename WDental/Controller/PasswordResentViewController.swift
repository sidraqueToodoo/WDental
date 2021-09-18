//
//  PasswordResentViewController.swift
//  WDental
//
//  Created by Sidraque on 18/09/21.
//

import UIKit

class PasswordResentViewController: UIViewController {
    
    @IBOutlet weak var btHome: UIButton!{
        didSet{
            btHome.layer.borderColor = UIColor(red: 0.07, green: 0.10, blue: 0.24, alpha: 1.00).cgColor
            btHome.layer.borderWidth = 1
            btHome.layer.cornerRadius = 20
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

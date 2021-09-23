//
//  HomeViewController.swift
//  WDental
//
//  Created by Sidraque on 22/09/21.
//

import UIKit

class HomeViewController: UIViewController{
    
    

    @IBOutlet weak var view1: UIView!{
        didSet{
            view1.layer.cornerRadius = 4

            // shadow
            view1.layer.shadowColor = UIColor.black.cgColor
            view1.layer.shadowOffset = CGSize(width: 0, height: 0)
            view1.layer.shadowOpacity = 0.12
            view1.layer.shadowRadius = 4.0
        }
    }
    @IBOutlet weak var view2: UIView!{
        didSet{
            view2.layer.cornerRadius = 4

            // shadow
            view2.layer.shadowColor = UIColor.black.cgColor
            view2.layer.shadowOffset = CGSize(width: 0, height: 0)
            view2.layer.shadowOpacity = 0.12
            view2.layer.shadowRadius = 4.0
        }
    }
    @IBOutlet weak var view3: UIView!{
        didSet{
            view3.layer.cornerRadius = 4

            // shadow
            view3.layer.shadowColor = UIColor.black.cgColor
            view3.layer.shadowOffset = CGSize(width: 0, height: 0)
            view3.layer.shadowOpacity = 0.12
            view3.layer.shadowRadius = 4.0
        }
    }
    
    @IBOutlet weak var viewLittleWallet: UIView!{
        didSet{
            viewLittleWallet.layer.cornerRadius = 4

            // shadow
            viewLittleWallet.layer.shadowColor = UIColor.black.cgColor
            viewLittleWallet.layer.shadowOffset = CGSize(width: 0, height: 0)
            viewLittleWallet.layer.shadowOpacity = 0.12
            viewLittleWallet.layer.shadowRadius = 4.0
        }
    }
    @IBOutlet weak var viewSchedule: UIView!{
        didSet{
            viewSchedule.layer.cornerRadius = 4

            // shadow
            viewSchedule.layer.shadowColor = UIColor.black.cgColor
            viewSchedule.layer.shadowOffset = CGSize(width: 0, height: 0)
            viewSchedule.layer.shadowOpacity = 0.12
            viewSchedule.layer.shadowRadius = 4.0
        }
    }
    @IBOutlet weak var viewPayment: UIView!{
        didSet{
            viewPayment.layer.cornerRadius = 4

            // shadow
            viewPayment.layer.shadowColor = UIColor.black.cgColor
            viewPayment.layer.shadowOffset = CGSize(width: 0, height: 0)
            viewPayment.layer.shadowOpacity = 0.12
            viewPayment.layer.shadowRadius = 4.0
        }
    }
    @IBOutlet weak var viewNetwork: UIView!{
        didSet{
            viewNetwork.layer.cornerRadius = 4

            // shadow
            viewNetwork.layer.shadowColor = UIColor.black.cgColor
            viewNetwork.layer.shadowOffset = CGSize(width: 0, height: 0)
            viewNetwork.layer.shadowOpacity = 0.12
            viewNetwork.layer.shadowRadius = 4.0
        }
    }
    
    @IBOutlet weak var btDisplayHide: UIButton!
    @IBOutlet weak var pcInformationSelected: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func upInside(_ sender: UIButton) {
        if btDisplayHide.image(for: .normal) == UIImage(named: "exibir"){
            btDisplayHide.setImage(UIImage(named: "esconder"), for: UIControl.State.normal)
        }else{
            btDisplayHide.setImage(UIImage(named: "exibir"), for: UIControl.State.normal)
        }
    }
    
    //MARK: - Page Control
    
    @IBAction func changedPages(_ sender: UIPageControl) {
        if pcInformationSelected.currentPage == 0 {
            view1.isHidden = false
            view2.isHidden = true
            view3.isHidden = true
        }else if pcInformationSelected.currentPage == 1{
            view1.isHidden = true
            view2.isHidden = false
            view3.isHidden = true
        }else {
            view1.isHidden = true
            view2.isHidden = true
            view3.isHidden = false
        }
    }
}
    


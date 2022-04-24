//
//  SwichVC.swift
//  Funny
//
//  Created by Macbook Air on 20/04/22.
//

import UIKit
import SSNeumorphicView
import SoftButton

class SwichVC: UIViewController {
    
    @IBOutlet var btns: [SoftButton]! {
        didSet {
            for i in btns {
                i.makeNeuromorphic()
            }
        }
    }
    
    @IBOutlet weak var imgView: SSNeumorphicView! {
        didSet {
            imgView.transform = .init(scaleX: 1.5, y: 1.5)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0) {
            self.imgView.transform = .identity
        }
        navigationItem.backButtonTitle = ""
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }


    @IBAction func swictTap(_ sender: UIButton) {
        if sender.tag == 0 {
            let vc = FactsVC.init(nibName: "FactsVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if sender.tag == 1 {
            let vc = ImagesVCViewController.init(nibName: "ImagesVCViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

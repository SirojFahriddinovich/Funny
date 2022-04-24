//
//  WalkVC.swift
//  Funny
//
//  Created by Macbook Air on 20/04/22.
//

import UIKit
import SSNeumorphicView

class WalkVC: UIViewController {

    
    @IBOutlet weak var bacView: SSNeumorphicView! {
        didSet {
            bacView.transform = .init(scaleX: 1.3, y: 1.3)
        }
    }
    
    @IBOutlet weak var textView: SSNeumorphicView! {
        didSet {
            textView.transform = .init(scaleX: 1.3, y: 1.3)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: []) {
            self.bacView.transform = .identity
            self.textView.transform = .identity
        }

    }

    @IBAction func nextTap(_ sender: Any) {
        
        let vc = SwichVC.init(nibName: "SwichVC", bundle: nil)
        navigationItem.backButtonTitle = ""
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

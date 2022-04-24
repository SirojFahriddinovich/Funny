//
//  ImagesCVC.swift
//  Funny
//
//  Created by Macbook Air on 20/04/22.
//

import UIKit
import SDWebImage

class ImagesCVC: UICollectionViewCell {

    @IBOutlet weak var imgV: UIImageView! {
        didSet {
            imgV.transform = .init(scaleX: 1.5, y: 1.5)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0) {
            self.imgV.transform = .identity
        }
    }

    func updateCell(url : String) {
        imgV.sd_setImage(with: URL(string: url)!)
    }
    
}

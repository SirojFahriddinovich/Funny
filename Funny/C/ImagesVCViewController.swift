//
//  ImagesVCViewController.swift
//  Funny
//
//  Created by Macbook Air on 20/04/22.
//

import UIKit

class ImagesVCViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "ImagesCVC", bundle: nil), forCellWithReuseIdentifier: "ImagesCVC")
            collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 30, right: 0)
        }
    }
    
    var images = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cats photos"
        API.shared.getCatsImages { imgs in
            self.images = imgs
            self.collectionView.reloadData()
        }
    }

}


extension ImagesVCViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCVC", for: indexPath) as! ImagesCVC
        cell.updateCell(url: self.images[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.view.frame.width/2
        
        return CGSize(width: size, height: size)
    }
}

//
//  FactsTVCTableViewCell.swift
//  Funny
//
//  Created by Macbook Air on 20/04/22.
//

import UIKit

class FactsTVCTableViewCell: UITableViewCell {

    @IBOutlet weak var factLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UILabel!
    let formatter = DateFormatter()
    var index : IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        formatter.dateFormat = "YYYY.MMMM.dd HH:mm"
    }
    
    func updateCell(fact : FactDM, index : IndexPath) {
        self.index = index
        self.factLbl.text = fact.title
        self.dateLbl.text = formatter.string(from: fact.date!)
    }
    
}

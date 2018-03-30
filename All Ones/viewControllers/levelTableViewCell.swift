//
//  levelTableViewCell.swift
//  All Ones
//
//  Created by Difeng Chen on 12/9/17.
//  Copyright © 2017 Difeng Chen. All rights reserved.
//

import UIKit

class levelTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var levelNumer: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

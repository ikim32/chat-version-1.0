//
//  FirstAppTableViewCell.swift
//  FirstAppWithParse
//
//  Created by MIguel Saravia on 5/6/15.
//  Copyright (c) 2015 MIguel Saravia. All rights reserved.
//

import UIKit

class FirstAppTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestamLabel: UILabel!
    @IBOutlet weak var textFieldViewController: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

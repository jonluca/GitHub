//
//  RepoViewCell.swift
//  GithubDemo
//
//  Created by Chaitanya Pilaka on 10/16/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class RepoViewCell: UITableViewCell {

    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var displayImage: UIImageView!

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var forkImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  SearchResultCell.swift
//  Github-API
//
//  Created by 豊岡正紘 on 2020/09/17.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import UIKit
import Nuke

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var loginNameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    private var pipeline = ImagePipeline.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(data: User?) {
        guard let data = data else { return }
        
        loginNameLabel.text = data.login
        typeLabel.text = data.type
        
        if let url = URL(string: data.avatarUrl) {
            loadImage(with: url, into: avatarImageView)
        }
    }
}

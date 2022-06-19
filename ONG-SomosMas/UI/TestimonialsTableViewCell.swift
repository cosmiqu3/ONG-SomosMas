//
//  TestimonialsTableViewCell.swift
//  ONG-SomosMas
//
//  Created by training on 18-06-22.
//

import UIKit

class TestimonialsTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

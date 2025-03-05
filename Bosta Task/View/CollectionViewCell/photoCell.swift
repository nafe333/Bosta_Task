//
//  photoCell.swift
//  Bosta Task
//
//  Created by Nafea Elkassas on 05/03/2025.
//

import UIKit
import Kingfisher
class photoCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    func configure(with urlString: String) {
            if let url = URL(string: urlString) {
                photoImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            }
        }
}

//
//  photoCell.swift
//  Bosta Task
//
//  Created by Nafea Elkassas on 05/03/2025.
//

import UIKit
import Nuke
class photoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(with photo: Photo) {
        guard let url = URL(string: photo.url) else {
            // If the URL is invalid, set the custom image
            photoImageView.image = UIImage(named: "testImage")
            return
        }
        
        // Load image using Nuke
        Nuke.loadImage(with: url, into: photoImageView) { [weak self] result in
            switch result {
            case .success(let response):
                // incase of successfull
                print(" Image loaded successfully: \(response.image)")
            case .failure(let error):
                // incase of failure, local image
                print(" Failed to load image: \(error.localizedDescription)")
                self?.photoImageView.image = UIImage(named: "testImage")
            }
        }
    }}

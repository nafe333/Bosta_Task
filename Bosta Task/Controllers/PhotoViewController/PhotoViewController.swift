//
//  PhotoViewController.swift
//  BostaTask
//
//  Created by Nafea Elkassas on 05/03/2025.
//

import UIKit
import Nuke

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: - Properties
    var photoUrl: URL?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let photoUrl = photoUrl {
            Nuke.loadImage(with: photoUrl, into: photoImageView) { [weak self] result in
                if case .failure = result {
                    self?.photoImageView.image = UIImage(named: "testImage") 
                }
            }
        } else {
            photoImageView.image = UIImage(named: "testImage")
        }
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareImage))
                navigationItem.rightBarButtonItem = shareButton
    }
    
       //MARK: - Functions
    @objc private func shareImage() {
            guard let image = photoImageView.image else {
                print("No image to share")
                return
            }
            
            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        }
    
    func setupScrollView(){
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
}




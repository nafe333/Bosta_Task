//
//  PhotoCellViewModel.swift
//  Bosta Task
//
//  Created by Nafea Elkassas on 05/03/2025.
//

import Foundation

class PhotoCellViewModel {
    let imageUrl: URL?
    
    init(photo: Photo) {
        self.imageUrl = URL(string: photo.url)
    }
}

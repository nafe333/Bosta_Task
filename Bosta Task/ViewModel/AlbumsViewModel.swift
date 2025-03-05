//
//  AlbumsViewModel.swift
//  Bosta Task
//
//  Created by Nafea Elkassas on 05/03/2025.
//

import Foundation
import RxSwift
import RxCocoa

class AlbumsViewModel {
    private let disposeBag = DisposeBag()
    let photos = BehaviorRelay<[Photo]>(value: []) // Holds photos data

    func fetchPhotos(albumId: Int) {
            NetworkManager.shared.fetchPhotos(albumId: albumId)
                .subscribe { [weak self] result in
                    self?.photos.accept(result)
                }
                .disposed(by: disposeBag)
        }
}


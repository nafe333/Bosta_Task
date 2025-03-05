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
    // Inputs
    let searchQuery = BehaviorRelay<String>(value: "")
    
    // Outputs
    let photos = BehaviorRelay<[Photo]>(value: [])
    let filteredPhotos = BehaviorRelay<[Photo]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    init() {
        searchQuery
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                guard let self = self else { return }
                if query.isEmpty {
                    self.filteredPhotos.accept(self.photos.value)
                } else {
                    let filtered = self.photos.value.filter { $0.title.lowercased().contains(query.lowercased()) }
                    self.filteredPhotos.accept(filtered)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func fetchPhotos(albumId: Int) {
        NetworkManager.shared.fetchPhotos(albumId: albumId)
            .subscribe(onSuccess: { [weak self] photos in
                self?.photos.accept(photos)
                self?.filteredPhotos.accept(photos)
            }, onError: { error in
                print(" Error fetching photos: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
}

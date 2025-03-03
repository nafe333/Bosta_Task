//
//  PofileViewModel.swift
//  Bosta Task
//
//  Created by Nafea Elkassas on 03/03/2025.
//
import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel{
    private let disposeBag = DisposeBag()
    let user = BehaviorRelay<User?>(value: nil)
    let albums = BehaviorRelay<[Album]>(value: [])
    
    func loadUserData(userId: Int) {
            NetworkManager.shared.fetchUser(userId: userId)
                .subscribe { [weak self] result in
                    self?.user.accept(result)
                }
                .disposed(by: disposeBag)

            NetworkManager.shared.fetchAlbums(userId: userId)
                .subscribe { [weak self] result in
                    self?.albums.accept(result)
                }
                .disposed(by: disposeBag)
        }
}

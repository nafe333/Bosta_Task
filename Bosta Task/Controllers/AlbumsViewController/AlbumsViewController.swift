//
//  AlbumsViewController.swift
//  Bosta Task
//
//  Created by Nafea Elkassas on 03/03/2025.
//

import UIKit
import RxSwift

class AlbumsViewController: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    private let viewModel = AlbumsViewModel()
    private let disposeBag = DisposeBag()
    var albumId: Int = 0  // Set this from the previous screen

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        bindViewModel()
        viewModel.fetchPhotos(albumId: albumId)
    }

    private func bindViewModel() {
        collectionView.register(UINib(nibName: "photoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")

        viewModel.photos
            .bind(to: collectionView.rx.items(cellIdentifier: "PhotoCell", cellType: photoCell.self)) { index, photo, cell in
                cell.configure(with: photo.url)
            }
            .disposed(by: disposeBag)
    }
}

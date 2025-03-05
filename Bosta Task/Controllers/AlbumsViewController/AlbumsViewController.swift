//
//  AlbumsViewController.swift
//  Bosta Task
//
//  Created by Nafea Elkassas on 03/03/2025.
//

import UIKit
import RxSwift
import RxCocoa
import Nuke

class AlbumsViewController: UIViewController {
    
       //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
       //MARK: - Properties
    private let viewModel = AlbumsViewModel()
    private let disposeBag = DisposeBag()
    var albumTitle: String?
    var albumId: Int!
    
       //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupBindings()
        self.title = albumTitle
        if let albumId = albumId {
            viewModel.fetchPhotos(albumId: albumId)
        } else {
            print(" Album ID is not valid")
        }
    }
    
       //MARK: - Private Functions
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let itemSize = (UIScreen.main.bounds.width - 32) / 3
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "photoCell", bundle: nil), forCellWithReuseIdentifier: "photoCell")
    }
    
    private func setupBindings() {
        // Binding search bar text to ViewModel's searchQuery
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchQuery)
            .disposed(by: disposeBag)
        
        // Binding filtered photos to collection view
        viewModel.filteredPhotos
            .bind(to: collectionView.rx.items(cellIdentifier: "photoCell", cellType: photoCell.self)) { index, photo, cell in
                cell.configureCell(with: photo)
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
                .subscribe(onNext: { [weak self] indexPath in
                    guard let self = self else { return }
                    let selectedPhoto = self.viewModel.filteredPhotos.value[indexPath.item]
                    let photoVC = PhotoViewController()
                    photoVC.photoUrl = URL(string: selectedPhoto.url)
                    self.navigationController?.pushViewController(photoVC, animated: true)
                })
                .disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Profile"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.sizeToFit()
        let leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
}

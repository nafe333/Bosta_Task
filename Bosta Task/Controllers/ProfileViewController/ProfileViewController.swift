//
//  ProfileViewController.swift
//  Bosta Task
//
//  Created by Nafea Elkassas on 05/03/2025.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {

       //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
        private let viewModel = ProfileViewModel()
        private let disposeBag = DisposeBag()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()

        // Fetch user and albums
        viewModel.loadUserData(userId: 1)
    }
    
    // MARK: - UI Setup
    private func setupUI() {

        setupNavigationBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
    
    // MARK: - Bind ViewModel
    private func bindViewModel() {
        viewModel.user
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] user in
                print(user.name)
                print(user.address)
                self?.nameLabel.text = user.name
                self?.addressLabel.text = user.address.fullAddress
            })
            .disposed(by: disposeBag)

        viewModel.albums
            .bind(to: tableView.rx.items(cellIdentifier: "cell")) { _, album, cell in
                cell.textLabel?.text = album.title
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Album.self)
            .subscribe(onNext: { [weak self] album in
                let albumVC = AlbumsViewController(nibName: "AlbumsViewController", bundle: nil)
                albumVC.albumId = album.id
                self?.navigationController?.pushViewController(albumVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    }

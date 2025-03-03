//
//  PofileViewController.swift
//  Bosta Task
//
//  Created by Nafea Elkassas on 03/03/2025.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
    private let tableView = UITableView()
    private let nameLabel = UILabel()
    private let addressLabel = UILabel()
    private let viewModel = ProfileViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.loadUserData(userId: 1) // Test with user ID 1
    }

    private func setupUI() {
        view.backgroundColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 20)
        addressLabel.font = .systemFont(ofSize: 16)
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, addressLabel, tableView])
        stackView.axis = .vertical
        stackView.spacing = 8
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    private func bindViewModel() {
        viewModel.user
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] user in
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
            .subscribe(onNext: { album in
                print("Navigate to album details for album: \(album.id)")
            })
            .disposed(by: disposeBag)
    }
}

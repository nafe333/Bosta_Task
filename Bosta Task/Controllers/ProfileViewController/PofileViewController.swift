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
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        viewModel.albums.value.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = viewModel.albums.value[indexPath.row].title
//        return cell
//    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
        private let viewModel = ProfileViewModel()
        private let disposeBag = DisposeBag()
        
        // MARK: - Lifecycle Methods
        override func viewDidLoad() {
            super.viewDidLoad()
            
            print("Is tableView nil in viewDidLoad? \(tableView == nil)") // Debugging
            print("Is address label nil in viewDidLoad? \(addressLabel == nil)")
            setupUI()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            print("Calling bindViewModel() in viewDidAppear")
            bindViewModel()
        }
        
        // MARK: - UI Setup
        private func setupUI() {
            // Ensure the tableView is properly registered
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
        
        // MARK: - Bind ViewModel
        private func bindViewModel() {
            print("bindViewModel() called") // Debugging
            
            // Check if tableView is nil before proceeding
            guard let tableView = tableView else {
                print("Error: TableView is nil in bindViewModel()")
                return
            }
            
            // Bind user data to labels
            viewModel.user
                .compactMap { $0 }
                .subscribe(onNext: { [weak self] user in
                    self?.nameLabel.text = user.name
                    self?.addressLabel.text = "\(user.address.street), \(user.address.city)"
                })
                .disposed(by: disposeBag)
            
            // Bind albums to tableView
            viewModel.albums
                .bind(to: tableView.rx.items(cellIdentifier: "cell")) { _, album, cell in
                    cell.textLabel?.text = album.title
                }
                .disposed(by: disposeBag)
            
            // Handle album selection
            tableView.rx.modelSelected(Album.self)
                .subscribe(onNext: { [weak self] album in
                    guard let self = self else { return }
                    let albumVC = UIStoryboard(name: "Main", bundle: nil)
                        .instantiateViewController(withIdentifier: "AlbumViewController") as! AlbumsViewController
//                    albumVC.albumsId = album.id
                    self.navigationController?.pushViewController(albumVC, animated: true)
                })
                .disposed(by: disposeBag)
        }
    }

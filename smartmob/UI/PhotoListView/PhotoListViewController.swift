//
//  PhotoListViewController.swift
//  smartmob
//
//  Created by santosh kc on 7/3/19.
//  Copyright © 2019 Santosh Kc. All rights reserved.
//

import UIKit

class PhotoListViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //Method Injection
    func configure(photoListViewModel: PhotoListViewModel, registry: DependencyRegistry) {
        self.photoListViewModel = photoListViewModel
        self.registry = registry
    }
    
    //Variables
    var photoListViewModel: PhotoListViewModel!
    var registry: DependencyRegistry!
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        return activityIndicator
    }()
    
    //View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.searchBar.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(sender:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        photoListViewModel.loadData { [weak self] in
            self?.newDataRecieved()
        }
    }
    
    private func newDataRecieved() {
        debugPrint("total count: \(photoListViewModel.data.count)")
        self.collectionView.reloadData()
    }
    
    @objc private func viewTapped(sender: UITapGestureRecognizer) {
        if searchBar.isFirstResponder {
            searchBar.resignFirstResponder()
        }
    }
}

extension PhotoListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 10
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
}

extension PhotoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoListViewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let assest = photoListViewModel.data[indexPath.item]
        let cell = registry.makePhotoCell(for: collectionView, at: indexPath, assests: assest)
        return cell
    }
}

extension PhotoListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let assest = self.photoListViewModel.data[indexPath.row]
        
    }
}

extension PhotoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        debugPrint("text is \(searchBar.text)")
    }
}

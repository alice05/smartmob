//
//  PhotoViewCell.swift
//  smartmob
//
//  Created by santosh kc on 7/3/19.
//  Copyright © 2019 Santosh Kc. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(photoViewCellViewModel: PhotoViewCellViewModel) {
        imageView.kf.setImage(with: URL(string: photoViewCellViewModel.url))
    }
}

extension PhotoCollectionViewCell {
    static var cellId: String {
        return "PhotoCollectionViewCell"
    }
    
    static func deque(from collectionView: UICollectionView, for indexPath: IndexPath, with viewModel: PhotoViewCellViewModel) -> PhotoCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.cellId, for: indexPath) as? PhotoCollectionViewCell
        cell!.configure(photoViewCellViewModel: viewModel)
        return cell!
    }
}


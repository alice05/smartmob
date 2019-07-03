//
//  PhotoDetailViewController.swift
//  smartmob
//
//  Created by santosh kc on 7/3/19.
//  Copyright © 2019 Santosh Kc. All rights reserved.
//

import UIKit
import Kingfisher


class PhotoDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressView: CircularProgressBar!
    @IBOutlet weak var playImageView: UIImageView! {
        didSet {
            self.playImageView.isHidden = true
        }
    }
    
    // Variables
    var photodetailViewModel: PhotodetailViewModel!
    
    // Method injection
    func configure(photodetailViewModel: PhotodetailViewModel) {
        self.photodetailViewModel = photodetailViewModel
    }
    
    // View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.kf.setImage(with: URL(string: photodetailViewModel.url)!)
    }
}

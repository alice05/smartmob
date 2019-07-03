//
//  PhotoDetailViewController.swift
//  smartmob
//
//  Created by santosh kc on 7/3/19.
//  Copyright © 2019 Santosh Kc. All rights reserved.
//

import UIKit
import Alamofire


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
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swiped(sender:)))
        self.view.addGestureRecognizer(swipeGesture)
        downloadHQAssest()
    }
    
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss()
    }
    
    @objc private func swiped(sender: Any) {
        dismiss()
    }
    
    private func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func downloadHQAssest() {
        Alamofire.request(URL(string: photodetailViewModel.largeUrl)!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).downloadProgress { (progress) in
            debugPrint("progress is ", progress)
            DispatchQueue.main.async {
                self.progressView.setProgress(to: progress.fractionCompleted, withAnimation: false)
            }
            }.response { [weak self] (response) in
                DispatchQueue.main.async {
                    self?.progressView.isHidden = true
                    if let mimetype = response.response?.mimeType {
                        let typeArray = mimetype.components(separatedBy: "/")
                        if typeArray.count>0{
                            let type = typeArray[0]
                            guard let data = response.data else { return }
                            switch type {
                            case "image":
                                self?.imageView.image = UIImage(data: data)
                                break
                            case "video":
                                
                                break
                            default:
                                break
                            }
                        }
                    }
                }
        }
    }
}

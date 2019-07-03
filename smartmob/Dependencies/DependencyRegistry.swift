//
//  DependencyRegistry.swift
//  smartmob
//
//  Created by santosh kc on 7/3/19.
//  Copyright © 2019 Santosh Kc. All rights reserved.
//

import SwinjectStoryboard
import Swinject

protocol DependencyRegistry {
    var container: Container { get }
    
    func makePhotoDetailViewController(assests: AssestsDTO) -> PhotoDetailViewController
    func makePhotoCell(for collectionView: UICollectionView, at indexpath:IndexPath, assests: AssestsDTO) -> PhotoCollectionViewCell
}

class DependencyRegistryImpl: DependencyRegistry {
    var container: Container
    
    init(container: Container) {
        Container.loggingFunction = nil
        
        self.container = container
        registerModels()
        registerViewModels()
        registerViewControllers()
    }
    
    func registerModels() {
        container.register(NetworkLayer.self) { _ in
            return NetworkLayerImpl()
        }
        
        container.register(TranslationLayer.self) { _ in
            return TranslationLayerImpl()
        }
        
        container.register(ModelLayer.self) { resolver in
            return ModelLayerImpl(networkLayer: resolver.resolve(NetworkLayer.self)!, translationLayer: resolver.resolve(TranslationLayer.self)!)
        }
    }
    
    func registerViewModels() {
        container.register(PhotoListViewModel.self) { resolver in
            return PhotoListViewModelImpl(modelLayer: resolver.resolve(ModelLayer.self)!)
        }
        
        container.register(PhotodetailViewModel.self, factory: { (resolver, assests: AssestsDTO)  in
            return PhotoDetailViewModelImpl(assestsDTO: assests)
        })
        
        container.register(PhotoViewCellViewModel.self) { (resolver, assest: AssestsDTO) in
            return PhotoViewCellViewModelImpl(assestsDTO: assest)
        }
    }
    
    func registerViewControllers() {
        container.register(PhotoDetailViewController.self) { (resolver, assests:AssestsDTO) in
            let viewModel = resolver.resolve(PhotodetailViewModel.self, argument: assests)!
            
            let detailVc = UIStoryboard(name: Storyboard.main, bundle: nil).instantiateViewController(withIdentifier: ViewIdentifier.photoDetailViewController) as? PhotoDetailViewController
            detailVc!.configure(photodetailViewModel: viewModel)
            return detailVc!
        }
    }
    
    func makePhotoDetailViewController(assests: AssestsDTO) -> PhotoDetailViewController {
        return container.resolve(PhotoDetailViewController.self, argument: assests)!
    }
    
    func makePhotoCell(for collectionView: UICollectionView, at indexpath: IndexPath, assests: AssestsDTO) -> PhotoCollectionViewCell {
        let viewModel = container.resolve(PhotoViewCellViewModel.self, argument: assests)!
        let cell = PhotoCollectionViewCell.deque(from: collectionView, for: indexpath, with: viewModel)
        return cell
    }
}

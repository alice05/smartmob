//
//  SwinjectStoryboard+extensions.swift
//  smartmob
//
//  Created by santosh kc on 7/3/19.
//  Copyright © 2019 Santosh Kc. All rights reserved.
//

import SwinjectStoryboard

extension SwinjectStoryboard {
    
    public static func setup() {
        if AppDelegate.dependencyRegistry == nil {
            AppDelegate.dependencyRegistry = DependencyRegistryImpl(container: defaultContainer)
        }
        
        let dependencyRegistry: DependencyRegistry = AppDelegate.dependencyRegistry
        
        dependencyRegistry.container.storyboardInitCompleted(PhotoListViewController.self) { (resolver, vc) in
            let viewModel = resolver.resolve(PhotoListViewModel.self)!
            vc.configure(photoListViewModel: viewModel, registry: dependencyRegistry)
        }
    }
}

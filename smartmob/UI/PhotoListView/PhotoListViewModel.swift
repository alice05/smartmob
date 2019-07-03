//
//  PhotoListViewModel.swift
//  smartmob
//
//  Created by santosh kc on 7/3/19.
//  Copyright © 2019 Santosh Kc. All rights reserved.
//

import Foundation

protocol PhotoListViewModel {
    var data: [AssestsDTO] { get }
    var error: CustomError? {get}
    func loadData(finished: @escaping () -> Void)
    func searchData(withText text: String, finished: @escaping () -> Void)
}

class PhotoListViewModelImpl: PhotoListViewModel {
    
    var data = [AssestsDTO]()
    var error: CustomError?
    fileprivate var modelLayer: ModelLayer
    
    init(modelLayer: ModelLayer) {
        self.modelLayer = modelLayer
    }
    
    func loadData(finished: @escaping () -> Void) {
        modelLayer.loadData(withRequest: APIRequest(url: Api.latestAssestsURL, method: .get)) {[weak self] (assests, error) in
            if let err = error {
                self?.error = err
                self?.data = []
            } else {
                self?.error = nil
                self?.data = assests
            }
            finished()
        }
    }
    
    func searchData(withText text: String, finished: @escaping () -> Void) {
        guard text.count > 0 else {
            finished()
            return
        }
        let request = APIRequest(url: Api.searchQueryURL, method: .get, parameters: ["query": text], headers: nil)
        modelLayer.loadData(withRequest: request) {[weak self] (assests, error) in
            if let err = error {
                self?.error = err
                self?.data = []
            } else {
                self?.error = nil
                self?.data = assests
            }
            finished()
        }
    }
}


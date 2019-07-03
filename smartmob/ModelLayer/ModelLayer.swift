//
//  ModelLayer.swift
//  smartmob
//
//  Created by santosh kc on 7/3/19.
//  Copyright © 2019 Santosh Kc. All rights reserved.
//

import Foundation

protocol ModelLayer {
    func loadData(withRequest request: APIRequest, resultsLoaded: @escaping ([AssestsDTO], CustomError?) -> Void)
}

class ModelLayerImpl: ModelLayer {
    fileprivate var networkLayer: NetworkLayer
    fileprivate var translationLayer: TranslationLayer
    
    init(networkLayer: NetworkLayer,
         translationLayer: TranslationLayer) {
        self.networkLayer = networkLayer
        self.translationLayer = translationLayer
    }
    
    func loadData(withRequest request: APIRequest, resultsLoaded: @escaping ([AssestsDTO], CustomError?) -> Void) {
        networkLayer.loadFromServer(request: request) { (data, error) in
            guard let data = data else {
                resultsLoaded([], error)
                return
            }
            let dtos = self.translationLayer.createAssestsDTOsFromJsonData(data)
            resultsLoaded(dtos, nil)
        }
    }
}

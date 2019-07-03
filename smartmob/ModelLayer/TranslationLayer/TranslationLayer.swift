//
//  TranslationLayer.swift
//  smartmob
//
//  Created by santosh kc on 7/3/19.
//  Copyright © 2019 Santosh Kc. All rights reserved.
//

import Outlaw

protocol TranslationLayer {
    func createAssestsDTOsFromJsonData(_ data: Data) -> [AssestsDTO]
}

class TranslationLayerImpl: TranslationLayer {
    func createAssestsDTOsFromJsonData(_ data: Data) -> [AssestsDTO] {
        do {
            let json: [String: Any] = try JSON.value(from: data)
            let images: [AssestsDTO] = try json.value(for: "images")
            return images
        } catch {
            print(error)
            return []
        }
    }
}

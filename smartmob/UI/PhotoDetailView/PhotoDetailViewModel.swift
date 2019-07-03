//
//  PhotoDetailViewModel.swift
//  smartmob
//
//  Created by santosh kc on 7/3/19.
//  Copyright © 2019 Santosh Kc. All rights reserved.
//

import Foundation

protocol PhotodetailViewModel {
    var assestsDTO: AssestsDTO {get}
    
    var id: Int {get}
    var url: String {get}
    var largeUrl: String {get}
}

class PhotoDetailViewModelImpl: PhotodetailViewModel {
    var assestsDTO: AssestsDTO
    
    var id: Int { return assestsDTO.id}
    
    var url: String {return assestsDTO.url}
    
    var largeUrl: String {return assestsDTO.largeUrl}
    
    init(assestsDTO: AssestsDTO) {
        self.assestsDTO = assestsDTO
    }
}

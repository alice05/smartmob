//
//  PhotoViewCellViewModel.swift
//  smartmob
//
//  Created by santosh kc on 7/3/19.
//  Copyright © 2019 Santosh Kc. All rights reserved.
//

import Foundation

protocol PhotoViewCellViewModel {
    var url: String {get}
}

class PhotoViewCellViewModelImpl: PhotoViewCellViewModel {
    var assestsDTO: AssestsDTO
    
    var url: String {return assestsDTO.url}
    
    init(assestsDTO: AssestsDTO) {
        self.assestsDTO = assestsDTO
    }
    
}

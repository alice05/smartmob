//
//  AssestsDTO.swift
//  smartmob
//
//  Created by santosh kc on 7/3/19.
//  Copyright © 2019 Santosh Kc. All rights reserved.
//

import Foundation
import Outlaw

struct AssestsDTO {
    var id: Int
    var sourceId: Int?
    var url: String
    var largeUrl: String
}

extension AssestsDTO: Deserializable {
    init(object: Extractable) throws {
        id = try object.value(for: "id")
        sourceId = try? object.value(for: "source_id")
        url = try object.value(for: "url")
        largeUrl = try object.value(for: "large_url")
    }
}

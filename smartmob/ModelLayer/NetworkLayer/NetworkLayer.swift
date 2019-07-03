//
//  NetworkLayer.swift
//  smartmob
//
//  Created by santosh kc on 7/3/19.
//  Copyright © 2019 Santosh Kc. All rights reserved.
//

import Alamofire

protocol NetworkLayer {
    func loadFromServer(request: APIRequest, finished: @escaping (Data?, CustomError?) -> Void)
}

enum CustomError: Error {
    case genericError
}

struct APIRequest {
    let url: String
    let method: HTTPMethod
    var parameters: Parameters?
    var headers: HTTPHeaders?
    
    init(url: String, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
}

class NetworkLayerImpl: NetworkLayer {
    func loadFromServer(request: APIRequest, finished: @escaping (Data?, CustomError?) -> Void) {
        print("loading data from server")
        print("url : \(request.url)")
        Alamofire.request(request.url,
                          method: request.method,
                          parameters: request.parameters,
                          headers: request.headers).responseJSON { response in
                            guard let data = response.data else {
                                finished(nil, CustomError.genericError)
                                return
                            }
                            finished(data, nil)
        }
    }
}

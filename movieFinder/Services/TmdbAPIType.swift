//
//  TmdbAPIType.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 04/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Moya

protocol TmdbAPIType: TargetType {}

extension TmdbAPIType {
    
    var baseURL: URL { return TmdbAPI.baseURL }
    
    var method: Moya.Method { return .get }
    
    var task: Task { return .requestPlain }
    
    var headers: [String: String]? { return nil }
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    func stubbedResponse(fileName: String) -> Data! {
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        return try? Data(contentsOf: URL(fileURLWithPath: path!))
    }
}


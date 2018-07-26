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
    
    public var baseURL: URL { return TmdbAPI.baseURL }
    
    public var method: Moya.Method { return .get }
    
    public var task: Task { return .requestPlain }
    
    public var headers: [String: String]? { return nil }
    
    func stubbedResponse(fileName: String) -> Data! {
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        return try? Data(contentsOf: URL(fileURLWithPath: path!))
    }
}


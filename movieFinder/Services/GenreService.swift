//
//  GenreService.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 04/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Moya

enum GenreService {
    case list(apiKey:String, language: String)
}

extension GenreService: TmdbAPIType {
    var path: String {
        return "genre/movie/list"
    }
    var task: Task {
        switch self {
        case .list(let apiKey, let language):
            return .requestParameters(parameters: ["api_key": apiKey, "language": language], encoding: JSONEncoding.default)
        }
    }
    
    var sampleData: Data { return "{}".data(using: String.Encoding.utf8)! }
}

extension Response {
    func mapGenres() -> [Genre]? {
        do {
            let dicJson =  try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
            if let results = dicJson["genres"] as? [[String: Any]] {
                var arrayGenres = [Genre]()
                for item in results {
                    arrayGenres.append(Genre(fromDictionary:item))
                }
                return arrayGenres
            }
            return nil
        } catch {
            return nil
        }
    }
}

//
//  MovieService.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 04/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Moya

enum MovieService {
    case list(apiKey:String, language: String, page: Int)
}

extension MovieService: TmdbAPIType {
    var path: String {
        return "movie/upcoming"
    }
    var task: Task {
        switch self {
        case .list(let apiKey, let language, let page):
            return .requestParameters(parameters: ["api_key": apiKey, "language": language, "page": page], encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data { return "{}".data(using: String.Encoding.utf8)! }
}

extension Response {
    func mapMovies() -> [Movie]? {
        do {
            let dicJson =  try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
            if let results = dicJson["results"] as? [[String: Any]] {
                var arrayMovies = [Movie]()
                for item in results {
                    arrayMovies.append(Movie(fromDictionary:item))
                }
                return arrayMovies
            }
            return nil
        } catch {
            return nil
        }
    }
}

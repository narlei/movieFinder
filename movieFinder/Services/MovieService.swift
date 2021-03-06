//
//  MovieService.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 04/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Moya

public enum MovieService {
    case list(apiKey:String, language: String, page: Int)
    case search(apiKey:String, language: String, page: Int, query: String)
}

extension MovieService: TmdbAPIType {
    public var path: String {
        switch self {
        case .list:
            return "movie/upcoming"
        case .search:
            return "search/movie"
        }
    }
    public var task: Task {
        switch self {
        case .list(let apiKey, let language, let page):
            return .requestParameters(parameters: ["api_key": apiKey, "language": language, "page": page], encoding: URLEncoding.default)
        case .search(let apiKey, let language,let page, let query):
            return .requestParameters(parameters: ["api_key": apiKey, "language": language, "page": page, "query": query], encoding: URLEncoding.default)
        }
    }
    
    public var sampleData: Data {
        return stubbedResponse(fileName: "Movie")
    }
    
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

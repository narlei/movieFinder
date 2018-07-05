//
//  TmdbAPI.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 04/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Moya

final class TmdbAPI {
    static let baseURL = URL(string: Constants.API.baseUrl)!
    
    
    var movie: MoyaProvider<MovieService> {
        return createProvider(for: MovieService.self)
    }

    var genre: MoyaProvider<GenreService> {
        return createProvider(for: GenreService.self)
    }

    
    private func createProvider<T: TmdbAPIType>(for target: T.Type) -> MoyaProvider<T> {
        let endpointClosure = createEndpointClosure(for: target)
        
        var plugins = [PluginType]()
        
        plugins.append(NetworkLoggerPlugin())
        
        return MoyaProvider<T>(endpointClosure: endpointClosure, plugins: plugins)
    }
    
    private func createEndpointClosure<T: TargetType>(for target: T.Type) -> MoyaProvider<T>.EndpointClosure {
        let endpointClosure = { (target: T) -> Endpoint in
            let endpoint = MoyaProvider.defaultEndpointMapping(for: target)
            return endpoint
//            let headers = ["Accept": "application/json"]
//            return endpoint.adding(newHTTPHeaderFields: headers)
        }
        
        return endpointClosure
    }
}

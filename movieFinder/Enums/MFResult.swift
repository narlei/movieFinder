//
//  MFResult.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 04/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Foundation

enum MFResult<T>: Error {
    case success(object:T)
    case emtpy
    case failure(error:Error)
}

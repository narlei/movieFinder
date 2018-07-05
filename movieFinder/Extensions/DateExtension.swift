//
//  DateExtension.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 04/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Foundation

extension String {
    func toDateFormat(format:String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        dateFormatterPrint.locale = Locale(identifier: "pt-BR")
        
        if let date = dateFormatterGet.date(from: self){
            return dateFormatterPrint.string(from: date)
        } else {
            return ""
        }
    }
}

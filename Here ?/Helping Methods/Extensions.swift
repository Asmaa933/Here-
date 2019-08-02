//
//  Extensions.swift
//  Here ?
//
//  Created by AsMaa on 8/2/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import Foundation
//Convert string to date
extension String {
    func convertStringToDate(withFormat format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            preconditionFailure("Take a look to your format")
        }
        return date
    }
}
//Convert date to string
extension Date{
    func convertDateToString(format : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

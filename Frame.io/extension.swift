//
//  extension.swift
//  Frame.io
//
//  Created by Jonathan Green on 5/7/20.
//  Copyright © 2020 Jonathan Green. All rights reserved.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

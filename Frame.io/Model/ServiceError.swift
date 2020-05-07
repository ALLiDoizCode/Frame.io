//
//  ServiceError.swift
//  Frame.io
//
//  Created by Jonathan Green on 5/07/20.
//  Copyright © 2020 Jonathan Green. All rights reserved.
//

import Foundation

struct ServiceError: Error, Codable {
    let status: Int
    let message: String
    let description: String?
}

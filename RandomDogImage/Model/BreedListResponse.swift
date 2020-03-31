//
//  BreedListResponse.swift
//  RandomDogImage
//
//  Created by Hari Prasad on 3/29/20.
//  Copyright © 2020 Hari Prasad. All rights reserved.
//

import Foundation

struct BreedListResponse: Codable {
    let status: String
    let message: [String:[String]]
}

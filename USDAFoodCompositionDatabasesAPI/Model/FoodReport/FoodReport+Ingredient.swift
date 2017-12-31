//
//  FoodReport+Ingredient.swift
//  USDATestAPI
//
//  Created by Jacob Christie on 2017-12-29.
//  Copyright © 2017 Jacob Christie. All rights reserved.
//

import Foundation

extension FoodReport {

    /// <#Description#>
    public struct Ingredient {

        /// <#Description#>
        let description: String

        /// <#Description#>
        public let items: [String]

        /// <#Description#>
        public let lastUpdated: Date
    }
}

extension FoodReport.Ingredient: Decodable {

    enum DecodingKeys: String, CodingKey {
        case description = "desc"
        case lastUpdated = "upd"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)

        description = try container.decode(String.self, forKey: .description)
        items = description.components(separatedBy: ", ")
        lastUpdated = try container.decode(Date.self, forKey: .lastUpdated)
    }
}

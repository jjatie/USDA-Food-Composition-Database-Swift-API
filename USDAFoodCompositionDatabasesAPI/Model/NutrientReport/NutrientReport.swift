//
//  NutrientReport.swift
//  USDATestAPI
//
//  Created by Jacob Christie on 2017-12-30.
//  Copyright © 2017 Jacob Christie. All rights reserved.
//

import Foundation

public struct NutrientReport {

    public enum SortOrder: String {
        // Sort the list of foods by (f)ood name or nutrient (c)ontent. If you are requesting more than one nutrient and specifying sort = c then the first nutrient in your list is used for the content sort.
        case food = "f"
        case nutrientContent = "c"
    }

    /// <#Description#>
    ///
    /// - all: <#all description#>
    /// - common: <#common description#>
    public enum Subset: Int {
        case all
        case common
    }

    /// <#Description#>
    public let foodGroups: [String]

    /// <#Description#>
    public let subset: String

    /// <#Description#>
    public let standardReleaseVersion: String

    /// <#Description#>
    public let start: Int

    /// <#Description#>
    public let end: Int

    /// <#Description#>
    public let total: Int

    /// <#Description#>
    public let foods: [Food]
}

extension NutrientReport: Decodable {

    enum DecodingKeys: String, CodingKey {
        case foodGroups = "group"
        case subset
        case standardReleaseVersion = "sr"
        case start, end, total, foods
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        do {
            let group = try container.decode(String.self, forKey: .foodGroups)
            foodGroups = [group]
        } catch {
            foodGroups = try container.decode([String].self, forKey: .foodGroups)
        }
        subset = try container.decode(String.self, forKey: .subset)
        standardReleaseVersion = try container.decode(String.self, forKey: .standardReleaseVersion)
        start = try container.decode(Int.self, forKey: .start)
        end = try container.decode(Int.self, forKey: .end)
        total = try container.decode(Int.self, forKey: .total)
        foods = try container.decode([Food].self, forKey: .foods)
    }
}

//
//  ListReport.swift
//  USDATestAPI
//
//  Created by Jacob Christie on 2017-12-30.
//  Copyright © 2017 Jacob Christie. All rights reserved.
//

import Foundation

public struct ListReport: Decodable {

    /// <#Description#>
    ///
    /// - derivationCodes: <#derivationCodes description#>
    /// - food: <#food description#>
    /// - allNutrients: <#allNutrients description#>
    /// - specialtyNutrients: <#specialtyNutrients description#>
    /// - standardReleaseNutrientsOnly: <#standardReleaseNutrientsOnly description#>
    /// - foodGroup: <#foodGroup description#>
    public enum ListType: String, Decodable {
        case derivationCodes = "d"
        case food = "f"
        case allNutrients = "n"
        case specialtyNutrients = "ns"
        case standardReleaseNutrientsOnly = "nr"
        case foodGroup = "g"
    }


    public enum SortOrder: String, Decodable {
        case name = "n"
        /// Varies by list type: nutrient number for a nutrient list, NDBno for a foods list, food group id for a food group list
        case id
    }

    /// The type of list requested
    public let type: ListType

    /// Beginning offset of the list
    public let start: Int

    /// End offset of the list
    public let end: Int

    /// Total number of items in the query
    public let total: Int

    /// The sort order of the list
    public let sortOrder: SortOrder

    /// Standard Release version of the data being reported
    public let standardReleaseVersion: String

    /// The items returned by the list query
    public let items: [Item]

    enum CodingKeys: String, CodingKey {
        case type = "lt"
        case start, end, total
        case sortOrder = "sort"
        case standardReleaseVersion = "sr"
        case items = "item"
    }
}


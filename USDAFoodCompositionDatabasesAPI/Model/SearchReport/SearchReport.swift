//
//  SearchReport.swift
//  USDATestAPI
//
//  Created by Jacob Christie on 2017-12-29.
//  Copyright © 2017 Jacob Christie. All rights reserved.
//

import Foundation

public struct SearchReport {

    /// <#Description#>
    ///
    /// - brandedFoodProducts: <#brandedFoodProducts description#>
    /// - standardReference: <#standardReference description#>
    /// - any: <#any description#>
    public enum DataSource: String, Decodable {
        case brandedFoodProducts = "Branded Food Products"
        case standardReference = "Standard Reference"
        case any = ""
    }

    /// <#Description#>
    ///
    /// - name: <#name description#>
    /// - relevance: <#relevance description#>
    public enum SortOrder: String, Decodable {
        case name = "n"
        case relevance = "r"
    }

    /// The terms requested and used in the search
    public let query: String

    /// beginning item index in the list
    public let start: Int

    /// last item index in the list
    public let end: Int

    /// beginning offset into the results list for the items in the list requested
    public let offset: Int?

    /// The total number of items returned by the search
    public let total: Int

    /// requested sort order (r=relevance or n=name)
    public let sortOrder: SortOrder

    /// food group filter
    public let foodGroup: Int?

    /// Standard Release version of the data being reported
    public let standardReleaseVersion: String

    /// The items returned by the search
    public let items: [Item]
}

extension SearchReport: Decodable {
    enum DecodingKeys: String, CodingKey {
        case query = "q"
        case start, end, offset, total
        case sortOrder = "sort"
        case foodGroup = "group"
        case standardReleaseVersion = "sr"
        case items = "item"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        query = try container.decode(String.self, forKey: .query)
        start = try container.decode(Int.self, forKey: .start)
        end = try container.decode(Int.self, forKey: .end)
        offset = try container.decodeIfPresent(Int.self, forKey: .offset)
        total = try container.decode(Int.self, forKey: .total)
        sortOrder = try container.decode(SortOrder.self, forKey: .sortOrder)
        foodGroup = try container.decodeIfPresent(Int.self, forKey: .total)
        standardReleaseVersion = try container.decode(String.self, forKey: .standardReleaseVersion)
        items = try container.decode([Item].self, forKey: .items)
    }
}

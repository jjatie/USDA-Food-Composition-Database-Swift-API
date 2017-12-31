//
//  FoodReport.swift
//  USDATestAPI
//
//  Created by Jacob Christie on 2017-12-29.
//  Copyright © 2017 Jacob Christie. All rights reserved.
//

import Foundation

/// <#Description#>
struct FoodReportResponse {

    /// <#Description#>
    let foods: [FoodReport]

    /// <#Description#>
    let count: Int

    /// <#Description#>
    let notFoundCount: Int

    /// <#Description#>
    let apiVersion: Double
}

extension FoodReportResponse: Decodable {

    enum DecodingKeys: String, CodingKey {
        case foods, count
        case notFoundCount = "notfound"
        case apiVersion = "api"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        struct Foods: Decodable {
            let food: FoodReport?
            let error: String?
        }
        foods = try container.decode([Foods].self, forKey: .foods)
            .flatMap { $0.food }
        count = try container.decode(Int.self, forKey: .count)
        notFoundCount = try container.decode(Int.self, forKey: .notFoundCount)
        apiVersion = try container.decode(Double.self, forKey: .apiVersion)
    }
}

/// <#Description#>
public struct FoodReport {

    /// <#Description#>
    ///
    /// - basic: <#basic description#>
    /// - full: <#full description#>
    /// - stats: <#stats description#>
    public enum ReportType: String, Decodable {
        case basic = "b"
        case full = "f"
        case stats = "s"
    }

    /// <#Description#>
    ///
    /// - brandedFoodProducts: <#brandedFoodProducts description#>
    /// - standardReference: <#standardReference description#>
    /// - any: <#any description#>
    public enum DatabaseSource: String, Decodable {
        case brandedFoodProducts = "Branded Food Products"
        case standardReference = "Standard Reference"
        case any = ""
    }

    /// <#Description#>
    public let type: ReportType

    /// <#Description#>
    public let standardReleaseVersion: String

    /// <#Description#>
    public let description: Description

    /// <#Description#>
    public let nutrients: [Nutrient]

    /// <#Description#>
    public let sources: [Source]?

    /// <#Description#>
    public let footnotes: [Footnote]

    /// LANGUAL codes assigned to the food
    public let langual: [Langual]?
}

extension FoodReport: Decodable {

    enum DecodingKeys: String, CodingKey {
        case type
        case standardReleaseVersion = "sr"
        case description = "desc"
        case nutrients
        case sources = "source"
        case footnotes, langual
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        type = try container.decode(ReportType.self, forKey: .type)
        standardReleaseVersion = try container.decode(String.self, forKey: .standardReleaseVersion)
        description = try container.decode(Description.self, forKey: .description)
        nutrients = try container.decode([Nutrient].self, forKey: .nutrients)
        sources = try container.decodeIfPresent([Source].self, forKey: .sources)
        footnotes = try container.decode([Footnote].self, forKey: .footnotes)
        langual = try container.decodeIfPresent([Langual].self, forKey: .langual)
    }
}


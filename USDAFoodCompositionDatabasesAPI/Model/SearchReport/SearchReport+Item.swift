//
//  SearchReport+Item.swift
//  USDATestAPI
//
//  Created by Jacob Christie on 2017-12-29.
//  Copyright © 2017 Jacob Christie. All rights reserved.
//

import Foundation

extension SearchReport {

    /// <#Description#>
    public struct Item {

        /// <#Description#>
        ///
        /// - brandedFoodProducts: <#brandedFoodProducts description#>
        /// - standardReference: <#standardReference description#>
        public enum DataSource: String, Decodable {
            case brandedFoodProducts = "BL"
            case standardReference = "SR"
        }

        /// the food’s NDB Number
        public let ndbno: Int

        /// the food’s name
        public let name: String

        /// food group to which the food belongs
        public let foodGroup: String

        /// Data source: BL=Branded Food Products or SR=Standard Release
        public let dataSource: DataSource
    }
}

extension SearchReport.Item: Decodable {
    enum DecodingKeys: String, CodingKey {
        case ndbno, name
        case foodGroup = "group"
        case dataSource = "ds"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        let ndbno = try container.decode(String.self, forKey: .ndbno)
        self.ndbno = Int(ndbno)!
        name = try container.decode(String.self, forKey: .name)
        foodGroup = try container.decode(String.self, forKey: .foodGroup)
        dataSource = try container.decode(DataSource.self, forKey: .dataSource)
    }
}

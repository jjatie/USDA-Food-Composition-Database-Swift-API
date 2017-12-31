//
//  NutrientReport+Food.swift
//  USDATestAPI
//
//  Created by Jacob Christie on 2017-12-30.
//  Copyright © 2017 Jacob Christie. All rights reserved.
//

import Foundation

extension NutrientReport {

    /// <#Description#>
    public struct Food: Decodable {

        /// <#Description#>
        public let ndbno: String

        /// <#Description#>
        public let name: String

        /// <#Description#>
        public let measure: String

        /// <#Description#>
        public let weight: Double

        /// <#Description#>
        public let nutrients: [Nutrient]

    }
}

extension NutrientReport.Food {

    /// <#Description#>
    public struct Nutrient: Decodable {

        /// <#Description#>
        public let nutrientID: String

        /// <#Description#>
        public let nutrient: String

        /// <#Description#>
        public let unit: String

        /// <#Description#>
        public let gramEquivalent: Double

        /// <#Description#>
        public let value: Double
    }
}

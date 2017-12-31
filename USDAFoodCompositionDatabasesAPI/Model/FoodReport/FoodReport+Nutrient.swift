//
//  FoodReport+Nutrient.swift
//  USDATestAPI
//
//  Created by Jacob Christie on 2017-12-29.
//  Copyright © 2017 Jacob Christie. All rights reserved.
//

import Foundation

extension FoodReport {

    /// <#Description#>
    public struct Nutrient: Decodable {

        /// <#Description#>
        public struct Measure {
            /*
             measures    list of measures reported for a nutrient
             label    name of the measure, e.g. "large"
             eqv    equivalent of the measure expressed as an eunit
             eunit    Unit in with the equivalent amount is expressed. Usually either gram (g) or milliliter (ml)
             value    gram equivalent value of the measure
             */

            // TODO: Make type wrapper for this?
            /// <#Description#>
            public let label: String

            /// <#Description#>
            public let equivalent: Double

            // TODO: Make type wrapper for this?
            /// <#Description#>
            public let eUnit: String

            /// <#Description#>
            public let value: Double
        }

        /*
         nutrient    metadata elements for each nutrient included in the food report
         nutrient_id    nutrient number (nutrient_no) for the nutrient
         name    nutrient name
         sourcecode    list of source id's in the sources list referenced for this nutrient
         derivation    Indicator of how the value was derived
         unit    unit of measure for this nutrient
         value
         dp    # of data points
         se    standard error
         */

        /// The nutrient number (nutrient_no) for the nutrient
        public let id: String

        /// <#Description#>
        public let name: String

        /// <#Description#>
        public let sourceCode: [Int]?

        /// <#Description#>
        public let derivation: String

        // TODO: Make type wrapper for this?
        /// <#Description#>
        public let unit: String

        /// The 100 g equivalent value of the nutrient
        public let value: Double

        /// <#Description#>
        public let numberOfDataPoints: Int?

        /// <#Description#>
        public let standardError: Double?

        /// <#Description#>
        public let measures: [Measure]
    }
}

extension FoodReport.Nutrient {

    enum DecodingKeys: String, CodingKey {
        case id = "nutrient_id"
        case name
        case sourceCode = "sourcecode"
        case derivation, unit, value
        case numberOfDataPoints = "dp"
        case standardError = "se"
        case measures
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        sourceCode = try container.decodeIfPresent([Int].self, forKey: .sourceCode)
        derivation = try container.decode(String.self, forKey: .derivation)
        unit = try container.decode(String.self, forKey: .unit)
        let value = try container.decode(String.self, forKey: .value)
        self.value = Double(value)!
        numberOfDataPoints = try container.decodeIfPresent(Int.self, forKey: .numberOfDataPoints)
        standardError = try container.decodeIfPresent(Double.self, forKey: .standardError)
        measures = try container.decode([Measure].self, forKey: .measures)
    }
}

extension FoodReport.Nutrient.Measure: Decodable {
    enum DecodingKeys: String, CodingKey {
        case label
        case equivalent = "eqv"
        case eUnit = "eunit"
        case value
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        label = try container.decode(String.self, forKey: .label)
        equivalent = try container.decode(Double.self, forKey: .equivalent)
        eUnit = try container.decode(String.self, forKey: .eUnit)
        let value = try container.decode(String.self, forKey: .value)
        self.value = Double(value)!
    }
}

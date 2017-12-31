//
//  FoodReport+Description.swift
//  USDATestAPI
//
//  Created by Jacob Christie on 2017-12-29.
//  Copyright © 2017 Jacob Christie. All rights reserved.
//

import Foundation

extension FoodReport {

    /// <#Description#>
    public struct Description: Decodable {
        /*
         desc    metadata elements for the food being reported
         ndbno    NDB food number
         name    food name
         sd    short description
         group    food group
         sn    scientific name
         cn    commercial name
         manu    manufacturer
         nf    nitrogen to protein conversion factor
         cf    carbohydrate factor
         ff    fat factor
         pf    protein factor
         r    refuse %
         rd    refuse description
         ds    database source: 'Branded Food Products' or 'Standard Reference'
         ru    reporting unit: nutrient values are reported in this unit, usually gram (g) or milliliter (ml)
         */

        /// <#Description#>
        public let ndbno: String

        /// <#Description#>
        public let name: String

        /// <#Description#>
        public let shortDescription: String?

        /// <#Description#>
        public let foodGroup: String?

        /// <#Description#>
        public let scientificName: String?

        /// <#Description#>
        public let commercialName: String?

        /// <#Description#>
        public let manufacturer: String

        /// <#Description#>
        public let nitrogenToProteinConversionFactor: Double?

        /// <#Description#>
        public let carbohydrateFactor: Double?

        /// <#Description#>
        public let fatFactor: Double?

        /// <#Description#>
        public let proteinFactor: Double?

        /// <#Description#>
        public let refusePercentage: Double?

        /// <#Description#>
        public let refuseDescription: String?

        /// <#Description#>
        public let databaseSource: DatabaseSource

        // TODO: Make type wrapper for reporting unit?
        /// <#Description#>
        public let reportingUnit: String

        enum CodingKeys: String, CodingKey {
            case ndbno, name
            case shortDescription = "sd"
            case foodGroup = "group"
            case scientificName = "sn"
            case commercialName = "cn"
            case manufacturer = "manu"
            case nitrogenToProteinConversionFactor = "nf"
            case carbohydrateFactor = "cf"
            case fatFactor = "ff"
            case proteinFactor = "pf"
            case refusePercentage = "r"
            case refuseDescription = "rd"
            case databaseSource = "ds"
            case reportingUnit = "ru"
        }
    }
}

//extension FoodReport.Description: Decodable {
/*
 desc    metadata elements for the food being reported
 ndbno    NDB food number
 name    food name
 sd    short description
 group    food group
 sn    scientific name
 cn    commercial name
 manu    manufacturer
 nf    nitrogen to protein conversion factor
 cf    carbohydrate factor
 ff    fat factor
 pf    protein factor
 r    refuse %
 rd    refuse description
 ds    database source: 'Branded Food Products' or 'Standard Reference'
 ru    reporting unit: nutrient values are reported in this unit, usually gram (g) or milliliter (ml)
 */

//
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: DecodingKeys.self)
//
//    }
//}


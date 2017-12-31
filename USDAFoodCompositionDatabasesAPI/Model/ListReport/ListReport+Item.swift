//
//  ListReport+Item.swift
//  USDATestAPI
//
//  Created by Jacob Christie on 2017-12-30.
//  Copyright © 2017 Jacob Christie. All rights reserved.
//

import Foundation

extension ListReport {

    /// Information about a single item in a `ListReport`
    public struct Item: Decodable {

        /// Varies by list type:
        /// - ndbno for type 'f'
        /// - nutrient no for type 'n'
        /// - group no for type 'g
        public let id: String

        /// Name of the item
        public let name: String
    }
}

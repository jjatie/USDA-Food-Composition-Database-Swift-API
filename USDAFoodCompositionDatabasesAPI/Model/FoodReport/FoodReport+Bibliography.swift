//
//  FoodReport+Bibliography.swift
//  USDATestAPI
//
//  Created by Jacob Christie on 2017-12-29.
//  Copyright © 2017 Jacob Christie. All rights reserved.
//

import Foundation

extension FoodReport {

    /// Reference source for the food. Usually a bibliographic citation
    public struct Source: Decodable {
        /*

         title    n
         authors    authors of the report
         vol    volume
         iss    issue
         year    publication year
         start    start page
         end    end page
         */

        /// Name of reference
        public let title: String

        /// Authors of the source
        public let authors: String

        /// Volume ID
        public let volume: String

        /// Issue ID
        public let issue: String

        /// Publication
        public let year: Int

        /// First page of the reference
        public let startPage: Int

        /// Last page of the reference
        public let endPage: Int
    }

    /// Footnote
    public struct Footnote: Decodable {
        /*
         footnote
         idv    footnote id
         desc    text of the foodnote
         */

        /// Footnote ID
        public let id: Int

        /// The text of the footnote
        public let description: String
    }

    /// LANGUAL codes assigned to the food
    public struct Langual: Decodable {

        /// LANGUAL code
        public let code: Int

        /// Description of the code
        public let description: String
    }
}

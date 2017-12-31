//
//  USDAAPI.swift
//  USDATestAPI
//
//  Created by Jacob Christie on 2017-12-29.
//  Copyright © 2017 Jacob Christie. All rights reserved.
//

import Foundation

public typealias NDBNO = Int

public struct USDAAPI {

    public static var apiKey = "DEMO_KEY"

    private static var baseURL: URL { return URL(string: "https://api.nal.usda.gov/ndb/")! }

    private static let decoder = JSONDecoder()

    private static let urlSession = {
        return URLSession.shared
    }()

    // MARK: - Food Report

    /// <#Description#>
    ///
    /// - basic: <#basic description#>
    /// - full: <#full description#>
    /// - stats: <#stats description#>
    public enum FoodReportType: String {
        // Report type: [b]asic or [f]ull or [s]tats
        case basic = "b"
        case full = "f"
        case stats = "s"
    }

    /// <#Description#>
    ///
    /// - Parameters:
    ///   - ndbno: <#ndbno description#>
    ///   - type: <#type description#>
    ///   - completion: <#completion description#>
    public static func foodReport(ndbno: [String], type: FoodReportType = .basic, completion: @escaping ([FoodReport]?, Error?) -> Void) {

        let parameters = ndbno.map { URLQueryItem(name: "ndbno", value: $0) } + [
            URLQueryItem(name: "type", value: type.rawValue)
        ]

        let request = makeRequest(apiPath: "V2/reports", parameters: parameters)
        performRequest(request) { data, error in
            guard let data = data else {
                debugPrint(error!)
                return completion(nil, error)
            }

            do {
                let response = try decoder.decode(FoodReportResponse.self, from: data)
                completion(response.foods, nil)
            } catch {
                debugPrint(error)
                completion(nil, error)
            }
        }
    }

    // MARK: - List

    public static func list(type: ListReport.ListType, max: Int, offset: Int, sort: ListReport.SortOrder, completion: @escaping (ListReport?, Error?) -> Void) {
        let parameters = [
            URLQueryItem(name: "lt", value: type.rawValue),
            URLQueryItem(name: "max", value: "\(max)"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "sort", value: sort.rawValue)
        ]

        let request = makeRequest(apiPath: "list", parameters: parameters)
        performRequest(request) { data, error in
            guard let data = data else {
                return completion(nil, error)
            }

            do {
                struct Response: Decodable {
                    let list: ListReport
                }
                let response = try decoder.decode(Response.self, from: data)
                completion(response.list, nil)
            } catch {
                completion(nil, error)
            }
        }
    }

    // MARK: - Nutrient Report

    /*
     Parameter      Required    Default     Description
     api_key        y           n/a         Must be a data.gov registered API key

     fg             n           ""          limit your nutrients to one or more food groups by providing a list of food group
     ID's via the fg parameter. The default is a blank list meaning no food group
     filtering will be applied. Up to 10 food groups may be specified.

     format         n           JSON        Report format: xml or json

     max            n           50          Number of rows to return. The maximum per request is 1,500.

     offset         n           0           beginning row in the result set to begin

     nbno           n           n/a         Report the nutrients for a single food identified by it's unique id (nutrient number)

     nutrients      y           n/a         a list of up to a maximum of 20 nutrient_id's to include in the report

     sort           n           f           Sort the list of foods by (f)ood name or nutrient (c)ontent. If you are requesting
     more than one nutrient and specifying sort = c then the first nutrient in your list
     is used for the content sort.

     subset         n           0           You may indicate all the foods in the SR database or an abridged list from the pull
     down menu. Set the subset parameter to 1 for the abridged list of about 1,000 foods
     commonly consumed in the U.S. The default 0 for all of the foods in the database
     */
    public static func nutrientReport(nutrientIDs: [Int]? = nil, foodGroupIDs: [Int]? = nil, max: Int = 50, offset: Int = 0, ndbno: String? = nil, sort: NutrientReport.SortOrder = .food, subset: NutrientReport.Subset = .all, completion: @escaping (NutrientReport?, Error?) -> Void) {

        var parameters = [
            URLQueryItem(name: "max", value: "\(max)"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "sort", value: sort.rawValue),
            URLQueryItem(name: "subset", value: "\(subset.rawValue)")
        ]

        if let ids = foodGroupIDs {
            parameters += ids.map { URLQueryItem(name: "fg", value: "\($0)") }
        }

        if let ids = nutrientIDs {
            parameters += ids.map { URLQueryItem(name: "nutrients", value: "\($0)") }
        }

        if let ndbno = ndbno {
            parameters.append(URLQueryItem(name: "nbno", value: "\(ndbno)"))
        }

        let request = makeRequest(apiPath: "nutrients/", parameters: parameters)
        performRequest(request) { data, error in
            guard let data = data else {
                return completion(nil, error)
            }

            do {
                struct Response: Decodable {
                    let report: NutrientReport
                }
                let report = try decoder.decode(Response.self, from: data).report
                completion(report, nil)
            } catch {
                completion(nil, error)
            }
        }
    }

    // MARK: - Search



    /**
     A search request sends keyword queries and returns lists of foods which contain one or more of the keywords in the food description, scientific name, or commerical name fields. Search requests are a good way to locate NDB numbers (NDBno) for the [reports](https://ndb.nal.usda.gov/ndb/doc/apilist/API-FOOD-REPORT.md) API as well as for general discovery.

     - Parameters:
     - query: The query or terms to search for. An empty string returns all foods.
     - dataSource: The datasource to search. Default is `.any`.
     - foodGroupID: The food group ID to limit the search to. Default is `nil`
     - sort: The sort order to return the search results in. Default is `relevance`
     - max: Maximum number of results to return
     - offset: The beginning index of the results
     - completion: Returns the search report, or error.

     There are no restrictions, other than common sense, on the keywords which can be searched. It's very easy to create paged browsing by using the total and offset (a zero-based start point) parameters. You may want to try the discovery application to get a feel for how searching works. You may limit your search results to a specific food group by specifying a food group id or a food group description in the fg parameter. (You may wish to use the list request to identify the food group id or description you wish to use.)
     */
    public static func search(query: String, dataSource: SearchReport.DataSource = .any, foodGroupID: Int? = nil, sort: SearchReport.SortOrder = .relevance, max: Int = 50, offset: Int = 0, completion: @escaping (SearchReport?, Error?) -> Void) {

        var parameters: Parameters = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "ds", value: dataSource.rawValue),
            URLQueryItem(name: "sort", value: sort.rawValue),
            URLQueryItem(name: "max", value: "\(max)"),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]

        if let fg = foodGroupID {
            parameters.append(URLQueryItem(name: "fg", value: "\(fg)"))
        }

        let request = makeRequest(apiPath: "search/", parameters: parameters)
        performRequest(request) { data, error in
            guard let data = data else {
                return completion(nil, error)
            }

            struct Response: Decodable {
                let list: SearchReport
            }

            do {
                let report = try decoder.decode(Response.self, from: data)
                completion(report.list, nil)
            } catch {
                debugPrint(error.localizedDescription, #file, #line)
                completion(nil, error)
            }
        }
    }

    private typealias Parameters = [URLQueryItem]

    private enum ReportFormat: String {
        case json
        case xml
    }

    private static func makeRequest(apiPath: String, parameters: Parameters, format: ReportFormat = .json) -> URLRequest {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        urlComponents.path += apiPath

        let queryItems = parameters + [URLQueryItem(name: "api_key", value: apiKey)]
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            fatalError("Invalid URL components")
        }

        var request = URLRequest(url: url)
        request.addValue("application/\(format.rawValue)", forHTTPHeaderField: "Content-Type")
        return request
    }

    private static func performRequest(_ request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in

            guard let response = response else {
                debugPrint(error!.localizedDescription, #file, #line)
                return completion(nil, error)
            }

            guard let data = data else {
                debugPrint("Response: ", response, #file, #line)
                debugPrint("Error: ", error!.localizedDescription, #file, #line)
                return completion(nil, error)
            }

            completion(data, error)
        }
        task.resume()
    }
}


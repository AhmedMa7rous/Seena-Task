//
//  NetworkLayer.swift
//  Seena Task
//
//
//  Created by Ma7rous on 18/02/2023.
//

import Foundation
import Moya

public enum NetworkLayer {
    static private let ApiKey = "gjpXTjabnG2WcldCr8KzMmJRCMZfPGHn"
    
    case news
}

extension NetworkLayer: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.nytimes.com/svc/movies/v2/")!
    }
    
    public var path: String {
        switch self {
        case .news:
            return "reviews/search.json"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .news:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .news:
            return .requestParameters(parameters: ["api-key": NetworkLayer.ApiKey], encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}

//
//  EndpointItem.swift
//  quizzie
//
//  Created by Ensar Baba on 1.05.2020.
//  Copyright © 2020 Ensar Baba. All rights reserved.
//
import Alamofire

enum RequestItemsType {
    
    // MARK: User actions
    case questions(count: String)
}

// MARK: - Extensions
// MARK: - EndPointType
extension RequestItemsType: EndPointType {
    
    // MARK: - Vars & Lets
    
    var baseURL: String {
        switch APIManager.networkEnviroment {
        case .dev: return "https://opentdb.com/api.php?type=multiple&"
        case .production: return "https://opentdb.com/api.php?type=multiple&"
        case .stage: return "https://opentdb.com/api.php?type=multiple&"
        }
    }
    
    var version: String {
        return "/v0_1"
    }
    
    var path: String {
        switch self {
        case .questions(count: let count):
            return "amount=\(count)"
        }

    }
        var httpMethod: HTTPMethod {
            switch self {
            case .questions:
                return .get
            }
        }
        
        var headers: HTTPHeaders? {
            switch self {
            case .questions:
                return ["Content-Type": "application/json",
                        "X-Requested-With": "XMLHttpRequest",
                        "x-access-token": "someToken"]
            }
        }
    
        var url: URL {
            switch self {
            default:
                return URL(string: self.baseURL + self.path)!
            }
        }
        
        var encoding: ParameterEncoding {
            switch self {
            default:
                return JSONEncoding.default
            }
        }
}

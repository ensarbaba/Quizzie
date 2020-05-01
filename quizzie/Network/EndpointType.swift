//
//  EndpointType.swift
//  quizzie
//
//  Created by Ensar Baba on 1.05.2020.
//  Copyright © 2020 Ensar Baba. All rights reserved.
//
import Alamofire

protocol EndPointType {
    
    // MARK: - Vars & Lets
    
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
    var version: String { get }
    
}

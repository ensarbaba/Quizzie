//
//  APIManager.swift
//  quizzie
//
//  Created by Ensar Baba on 1.05.2020.
//  Copyright © 2020 Ensar Baba. All rights reserved.
//

import Alamofire

class APIManager {
    
    // MARK: - Vars & Lets
    
    private let sessionManager: SessionManager
    static let networkEnviroment: NetworkEnvironment = .dev

    // MARK: - Vars & Lets
    
    private static var sharedApiManager: APIManager = {
        let apiManager = APIManager(sessionManager: SessionManager())
        
        return apiManager
    }()
    
    // MARK: - Accessors
    
    class func shared() -> APIManager {
        return sharedApiManager
    }
    
    // MARK: - Initialization
    
    private init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    func call<T>(type: EndPointType, params: Parameters? = nil, handler: @escaping (T?, _ error: AlertMessage?) -> Void) where T: Codable {
        
        self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).validate().responseJSON { data in
                                        switch data.result {
                                        case .success(_):
                                            let decoder = JSONDecoder()
                                            if let jsonData = data.data {
                                                let result = try! decoder.decode(T.self, from: jsonData)
                                                handler(result, nil)
                                            }
                                        case .failure(_):
                                            handler(nil, self.parseApiError(data: data.data))
                                        }
        }
    }
  
    func call(type: EndPointType, params: Parameters? = nil, handler: @escaping (()?, _ error: AlertMessage?) -> Void) {
    self.sessionManager.request(type.url,
                                method: type.httpMethod,
                                parameters: params,
                                encoding: type.encoding,
                                headers: type.headers).validate().responseJSON { data in
                                    switch data.result {
                                    case .success(_):
                                        handler((), nil)
                                    case .failure(_):
                                        handler(nil, self.parseApiError(data: data.data))
                                    }
    }
}
    private func parseApiError(data: Data?) -> AlertMessage {
        let decoder = JSONDecoder()
        if let jsonData = data, let error = try? decoder.decode(ErrorObject.self, from: jsonData) {
            return AlertMessage(title: "Error", body: error.key ?? error.message)
        }
        return AlertMessage(title: "Error", body: "error body")
    }
}

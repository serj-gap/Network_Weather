//
//  APIService.swift
//  NetworkingLecture
//
//  Created by Oleksandr Yehorov1 on 6/25/20.
//  Copyright © 2020 Oleksandr Yehorov1. All rights reserved.
//

import Foundation

typealias APIServiceInput = WeatherAPIServiceInput

enum ServiceResult<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
    
    public init(_ value: Value) {
        self = .success(value)
    }
    
    public init(_ error: Error) {
        self = .failure(error)
    }
}

enum ServiceError: Error {
    case message(errorMessage: String)
    case undefined
}

class APIService {
    static let api = "https://www.metaweather.com"
}

extension APIService: CodeHandlerProtocol {
    
    func handleServerCodesWithMessage(_ code: Int, _ message: String, completion: @escaping CodeValidationCompletion) {
        switch HTTPStatusCodes(rawValue: code) {
        case .success?, .created?:
            completion(.success)
            
        case .internalServerError?:
            completion(.internalServerError)
            
        default:
            completion(.unknown)
        }
    }
    
    func handleServerCodes(_ code: Int, completion: @escaping CodeValidationCompletion) {
        switch HTTPStatusCodes(rawValue: code) {
        case .success?, .created?:
            completion(.success)
            
        case .internalServerError?:
            completion(.internalServerError)
            
        default:
            completion(.unknown)
        }
    }
}

//
//  CodeHandlerProtocol.swift
//  NetworkingLecture
//
//  Created by Oleksandr Yehorov1 on 6/25/20.
//  Copyright © 2020 Oleksandr Yehorov1. All rights reserved.
//

import Foundation

public enum HTTPStatusCodes: Int {
    case success = 200 // success
    case created = 201 // created
    case internalServerError = 500
}

enum CodeValidation {
    case success
    case failure(reason: String)
    case internalServerError
    case unknown
}

typealias CodeValidationCompletion = (_ result: CodeValidation) -> Void

protocol CodeHandlerProtocol {
    func handleServerCodesWithMessage(_ code: Int, _ message: String, completion: @escaping CodeValidationCompletion)
    func handleServerCodes(_ code: Int, completion: @escaping CodeValidationCompletion)
}

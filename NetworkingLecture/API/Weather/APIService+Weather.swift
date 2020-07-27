//
//  APIService+Weather.swift
//  NetworkingLecture
//
//  Created by Oleksandr Yehorov1 on 6/25/20.
//  Copyright © 2020 Oleksandr Yehorov1. All rights reserved.
//

import Foundation

typealias WeatherComplition = (_ result: ServiceResult<WeatherForDays, ServiceError>) -> Void
typealias LocationComplition = (_ result: ServiceResult<Location?, ServiceError>) -> Void

protocol WeatherAPIServiceInput {
    func loadLocation(_ completion: @escaping LocationComplition)
    func loadWeather(id: Int, _ completion: @escaping WeatherComplition)
}

extension APIService: WeatherAPIServiceInput {
    func loadLocation(_ completion: @escaping LocationComplition) {
        let url = URL(string:"\(APIService.api)\("/api/location/search/?query=kharkiv")")
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { [weak self] (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            self?.handleServerCodes(httpResponse.statusCode, completion: { (validation) in
                switch validation {
                case .success:
                    do {
//                        guard let data = data else { return }
//                        let response = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
//                        guard let responseDic = response?[0] as? [String: Any] else { return }
//                        let decoder = JSONDecoder()
//                        let correctData = try JSONSerialization.data(withJSONObject: responseDic, options: [])
//                        let location = try decoder.decode(Location.self, from: correctData)
                         guard let data = data else { return }
                         let responseLocation = try JSONDecoder().decode([Location].self, from: data)
                         guard let location = responseLocation[0] as? Location else {return}
                         completion(ServiceResult(location))
                    } catch let error {
                        completion(ServiceResult(ServiceError.message(errorMessage: error.localizedDescription)))
                    }
                case .failure(let reason): debugPrint(reason)
                case .internalServerError: debugPrint("internalServerError")
                case .unknown: print("unknown")
                    
                }
            })
        })
        
        task.resume()
    }
    
    func loadWeather(id: Int, _ completion: @escaping WeatherComplition ) {
        
        let url = URL(string:"\(APIService.api)\("/api/location/\(id)/")")
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { [weak self] (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            self?.handleServerCodes(httpResponse.statusCode, completion: { (validation) in
                switch validation {
                case .success:
                    guard let data = data else { return }
                    do {
                        let weatherGlobal = try JSONDecoder().decode(WeatherForDays.self, from: data)
                        completion(ServiceResult(weatherGlobal))
                    } catch let err {
                        completion(ServiceResult(ServiceError.message(errorMessage: err.localizedDescription)))
                    }
                case .failure(let reason): debugPrint(reason)
                case .internalServerError: debugPrint("internalServerError")
                case .unknown: print("unknown")
                    
                }
            })
        })
        task.resume()
    }
    
}

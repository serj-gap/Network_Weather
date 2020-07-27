//
//  ViewController.swift
//  NetworkingLecture
//
//  Created by Oleksandr Yehorov1 on 6/25/20.
//  Copyright © 2020 Oleksandr Yehorov1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let api = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataForWeather()
    
    }
    
    
}

private extension ViewController {
    
    func loadDataForWeather() {
        api.loadLocation() {[weak self] result in
            switch result {
            case .success(let location):
                guard let location = location else {return}
                self?.api.loadWeather(id: location.id ) { (result) in
                    switch result {
                    case .success(let weatherForDays):
                        print("global \(weatherForDays)")
                        print("days \(weatherForDays.data)")
                    case .failure(let error):
                        if case let ServiceError.message(errorMessage: message) = error {
                            print(message)
                        } else {
                            print("undefined")
                        }
                    }
                }
            case .failure(let error):
                guard case let ServiceError.message(errorMessage: message) = error else {
                    print("undefined")
                    return
                }
                print(message)
            }
        }
    }
}


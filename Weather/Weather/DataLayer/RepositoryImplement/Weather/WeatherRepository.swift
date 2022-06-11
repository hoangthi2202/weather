//
//  WeatherRepository.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation
import Combine

class WeatherRepository {
    private let remoteApi: WeatherApi
    private let localStorage: WeatherDatabase
    private var cancellables = [AnyCancellable]()
    init(remoteApi: WeatherApi, localStorage: WeatherDatabase) {
        self.remoteApi = remoteApi
        self.localStorage = localStorage
    }
}

extension WeatherRepository: WeatherRepositoryProtocol {
    func searchWithParam(_ param: [String : String]) -> AnyPublisher<Response<[DomainCity]>, RepositoryError> {
        Future<Response<[DomainCity]>, RepositoryError> { [weak self] promise in
            guard let weakSelf = self else {
                return
            }
            
            // check local storage
            weakSelf.searchInLocalStorageWithParam(param) { [weak self] domainCities, localError in
                guard let weakSelf = self else {
                    return
                }
                
                if let error = localError {
                    promise(.failure(error))
                    return
                }
                
                if let domainCities = domainCities, domainCities.count > 0 {
                    promise(.success(.succeed(domainCities)))
                    return
                }
                
                // call to server
                weakSelf.searchOnServerWithParam(param) { [weak self] domainCities, serverError in
                    
                    guard let weakSelf = self else {
                        return
                    }
                    
                    if let error = serverError {
                        promise(.failure(error))
                        return
                    }
                    
                    guard
                        let domainCities = domainCities, domainCities.count > 0
                    else {
                        promise(.success(.succeed([])))
                        return
                    }
                    
                    // save to db
                    weakSelf.saveToLocalStorate(domainCities: domainCities)
                    promise(.success(.succeed(domainCities)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

// MARK: - Private functions
extension WeatherRepository {
    private func searchInLocalStorageWithParam(_ param: [String: String], completion: @escaping ([DomainCity]?, RepositoryError?) -> Void) {
        localStorage.searchWeatherWithParam(param)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished: break
                case .failure(let error):
                    completion(nil, error)
                }
            }, receiveValue: { response in
                switch response {
                case .succeed(let domainCities):
                    completion(domainCities, nil)
                    break
                case .failed(message: let message):
                    completion(nil, RepositoryError.unknown(message: message))
                    break
                }
            })
            .store(in: &cancellables)
    }
    
    private func searchOnServerWithParam(_ param: [String: String], completion: @escaping ([DomainCity]?, RepositoryError?) -> Void) {
        remoteApi.searchWeatherWithParam(param)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished: break
                case .failure(let error):
                    completion(nil, error)
                }
            }, receiveValue: { response in
                switch response {
                case .succeed(let domainCities):
                    completion(domainCities, nil)
                    break
                case .failed(message: let message):
                    completion(nil, RepositoryError.unknown(message: message))
                    break
                }
            })
            .store(in: &cancellables)
    }
    
    private func saveToLocalStorate(domainCities: [DomainCity]) {
        localStorage.saveWeather(domainCities)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished: break
                case .failure(let error):
                    print("Weather repository save error: \(error)")
                }
            }, receiveValue: { response in
                if response {
                    print("Weather repository saved successfully")
                } else {
                    print("Weather repository cannot save")
                }
            })
            .store(in: &cancellables)
    }
}


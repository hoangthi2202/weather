//
//  RemoteDailyApi.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation
import Combine
import UIKit

class RemoteDailyApi {
    private let apiConfig: ApiConfiguration
    init(apiConfig: ApiConfiguration) {
        self.apiConfig = apiConfig
    }
}

extension RemoteDailyApi: WeatherApi {
    func getUrlForIconId(_ iconId: String) -> URL? {
        let iconURLString = apiConfig.baseIconURLString + "\(iconId).png"
        return URL(string: iconURLString)
    }
    
    func searchWeatherWithParam(_ param: [String : String]) -> AnyPublisher<Response<[DomainCity]>, RepositoryError> {
        let urlString = param.reduce("\(apiConfig.baseURLString)/forecast/daily?") { partialResult, value in
            "\(partialResult)\(value.0)=\(value.1)"
        }
        guard let url = URL(string: urlString) else {
            return Fail(error: RepositoryError.urlNotCorrect).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse,
                      200..<300 ~= response.statusCode
                else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .mapError { error -> RepositoryError in
                if let error = error as? RepositoryError {
                    return error
                }
                return RepositoryError.unknown(message: error.localizedDescription)
            }
            .decode(type: [DailyCity].self, decoder: JSONDecoder())
            .map({ dailyCities in
                let array = dailyCities.compactMap { dailyCity in
                    return DomainCity.createByDailyCity(dailyCity)
                }
                return Response.succeed(array)
            })
            .catch { Fail(error: RepositoryError.unknown(message: $0.localizedDescription)).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

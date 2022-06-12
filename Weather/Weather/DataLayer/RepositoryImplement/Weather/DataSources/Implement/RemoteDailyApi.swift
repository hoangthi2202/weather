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
        let urlString = param.reduce("\(apiConfig.baseURLString)/forecast/daily?appid=\(apiConfig.appAPI ?? "")") { partialResult, value in
            return "\(partialResult)&\(value.0)=\(value.1)"
        }
        WLog.debug("searchWeatherWithParam: ", urlString)
        guard let url = URL(string: urlString) else {
            return Fail(error: RepositoryError.urlNotCorrect).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                WLog.debug("Response: ", element.response)
                do {
                    if let json = try JSONSerialization.jsonObject(with: element.data, options: []) as? [String: Any] {
                        WLog.debug("Data json: ", json)
                    }
                } catch let error as NSError {
                    WLog.debug("Failed to load: \(error.localizedDescription)")
                }
                
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
            .decode(type: DailyCity.self, decoder: JSONDecoder())
            .map({ dailyCity in
                let domainCity = DomainCity.createByDailyCity(dailyCity)
                return Response.succeed([domainCity])
            })
            .catch {
                Fail(error: RepositoryError.unknown(message: $0.localizedDescription)).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

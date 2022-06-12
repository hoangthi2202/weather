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
        }.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard
            let urlString = urlString,
            let url = URL(string: urlString)
        else {
            return Fail(error: RepositoryError.urlNotCorrect).eraseToAnyPublisher()
        }
        WLog.debug("RemoteDailyApi request: ", urlString)
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                //WLog.debug("RemoteDailyApi Response: ", element.response)
                var jsonDict: [String: Any]?
                do {
                    if let json = try JSONSerialization.jsonObject(with: element.data, options: []) as? [String: Any] {
                        jsonDict = json
                        WLog.debug("RemoteDailyApi json: ", json)
                    }
                } catch let error as NSError {
                    WLog.debug("RemoteDailyApi Failed to parse: \(error.localizedDescription)")
                }
                
                guard let response = element.response as? HTTPURLResponse,
                      200..<300 ~= response.statusCode
                else {
                    if let message = jsonDict?["message"] as? String {
                        throw RepositoryError.unknown(message: message)
                    }
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
            .decode(type: WeatherData.self, decoder: JSONDecoder())
            .map({ dailyCity in
                let domainCity = DomainCity.createByDailyCity(dailyCity)
                return Response.succeed([domainCity])
            })
            .catch { error -> AnyPublisher<Response<[DomainCity]>, RepositoryError> in
                // Local Error
                if let error = error as? RepositoryError {
                    return Fail(error: error).eraseToAnyPublisher()
                }
                
                return Fail(error: RepositoryError.unknown(message: error.localizedDescription)).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

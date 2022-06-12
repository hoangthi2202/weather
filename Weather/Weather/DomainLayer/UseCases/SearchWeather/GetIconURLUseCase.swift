//
//  GetIconURLUseCase.swift
//  Weather
//
//  Created by Hoang Thi on 12/06/2022.
//

import Foundation

protocol GetIconURLUseCaseProtocol {
    func execute(iconId: String) -> URL?
}

class GetIconURLUseCase {
    private let repository: WeatherRepositoryProtocol
    init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
    }
}

extension GetIconURLUseCase: GetIconURLUseCaseProtocol {
    func execute(iconId: String) -> URL? {
        repository.getURLForIconId(iconId)
    }
}

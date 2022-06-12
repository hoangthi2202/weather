//
//  Assembler+.swift
//  Weather
//
//  Created by Hoang Thi on 12/06/2022.
//

import Swinject

extension Assembler {
    static let shared: Assembler = {
        let container = Container()
        return Assembler(
            [
                PresentationAssemply(),
                UseCaseAssembly(),
                RepositoriesAssembly()
            ],
            container: container
        )
    }()
}

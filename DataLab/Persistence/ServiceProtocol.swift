//
//  ServiceProtocol.swift
//  DataLab
//
//  Created by Глеб Хамин on 02.07.2025.
//

import Foundation

protocol ServiceProtocol {
    var delegate: ServiceDelegate? { get set }
    func save(_ person: PersonModel.Person)
    func delete(_ person: PersonModel.Person)
    func fetchAllPersons() -> [PersonModel.Person]
    func update(_ person: PersonModel.Person)
}

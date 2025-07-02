//
//  SwiftDataModel.swift
//  DataLab
//
//  Created by Глеб Хамин on 02.07.2025.
//

import Foundation
import SwiftData

@Model
final class PlanetObjectSD {
    var name: String

    init(name: String) {
        self.name = name
    }

    convenience init(planet: Planet) {
        self.init(name: planet.rawValue)
    }

    var toModel: Planet? {
        Planet(rawValue: name)
    }
}

@Model
final class PersonObjectSD {
    var id: UUID
    var name: String
    var age: Int?
    var link: URL?
    var birthday: Date?
    var isStudent: Bool?
    var planet: PlanetObjectSD?

    init(
        id: UUID = UUID(),
        name: String,
        age: Int?,
        link: URL?,
        birthday: Date?,
        isStudent: Bool?,
        planet: PlanetObjectSD?
    ) {
        self.id = id
        self.name = name
        self.age = age
        self.link = link
        self.birthday = birthday
        self.isStudent = isStudent
        self.planet = planet
    }
}

//
//  RealmModel.swift
//  DataLab
//
//  Created by Глеб Хамин on 02.07.2025.
//

import Foundation
import RealmSwift

class PlanetObjectR: Object {
    @Persisted(primaryKey: true) var name: String?
}

class PersonObjectR: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var name: String
    @Persisted var age: Int?
    @Persisted var link: String?
    @Persisted var birthday: Date?
    @Persisted var isStudent: Bool?
    @Persisted var planet: PlanetObjectR?
}

extension PlanetObjectR {
    convenience init(from planet: Planet?) {
        self.init()
        self.name = planet?.rawValue
    }

    var toModel: Planet? {
        guard let name else { return nil }
        return Planet(rawValue: name)
    }
}

extension PersonObjectR {
    convenience init(from person: PersonModel.Person) {
        self.init()
        self.id = person.id
        self.name = person.name
        self.age = person.age
        self.link = person.link?.absoluteString
        self.birthday = person.birthday
        self.isStudent = person.isStudent
        self.planet = PlanetObjectR(from: person.planet)
    }

    var toModel: PersonModel.Person {
        PersonModel.Person(
            name: name,
            age: age,
            link: link.flatMap(URL.init(string:)),
            birthday: birthday,
            isStudent: isStudent,
            planet: planet?.toModel,
            id: id
        )
    }
}

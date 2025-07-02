//
//  RealmService.swift
//  DataLab
//
//  Created by Глеб Хамин on 02.07.2025.
//

import Foundation
import RealmSwift

final class RealmService: ServiceProtocol {
    private let realm: Realm
    weak var delegate: ServiceDelegate?

    init() {
        realm = try! Realm()
    }

    func save(_ person: PersonModel.Person) {
        let personObject = PersonObjectR(from: person)

        try! realm.write {
            realm.add(personObject, update: .modified)
        }
        delegate?.didUpdatePersons()
    }

    func delete(_ person: PersonModel.Person) {
        guard let obj = realm.object(ofType: PersonObjectR.self, forPrimaryKey: person.id) else { return }

        try! realm.write {
            realm.delete(obj)
        }
        delegate?.didUpdatePersons()
    }

    func fetchAllPersons() -> [PersonModel.Person] {
        realm.objects(PersonObjectR.self).compactMap { $0.toModel }
    }

    func update(_ person: PersonModel.Person) {
        guard let existingObject = realm.object(ofType: PersonObjectR.self, forPrimaryKey: person.id) else { return }

        try! realm.write {
            existingObject.name = person.name
            existingObject.age = person.age
            existingObject.link = person.link?.absoluteString ?? nil
            existingObject.birthday = person.birthday
            existingObject.isStudent = person.isStudent

            if let planetName = person.planet?.rawValue {
                if let existingPlanet = realm.object(ofType: PlanetObjectR.self, forPrimaryKey: planetName) {
                    existingObject.planet = existingPlanet
                } else {
                    let newPlanet = PlanetObjectR()
                    newPlanet.name = planetName
                    realm.add(newPlanet)
                    existingObject.planet = newPlanet
                }
            } else {
                existingObject.planet = nil
            }
        }

        delegate?.didUpdatePersons()
    }

}

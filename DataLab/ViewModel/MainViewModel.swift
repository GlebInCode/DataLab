//
//  MainViewModel.swift
//  DataLab
//
//  Created by Глеб Хамин on 01.07.2025.
//

import Foundation

enum Database {
    case local
    case swiftData
    case realm
}

protocol ServiceDelegate: AnyObject {
    func didUpdatePersons()
}

@Observable
final class MainViewModel {
    typealias Person = PersonModel.Person

    var database: Database = .realm
    var personModel: PersonModel = PersonModel()
    var service: ServiceProtocol?

    private var personsLocal: [Person] = [] {
        didSet { persons = personsLocal }
    }
    private var personsService: [Person] = [] {
        didSet { persons = personsService }
    }
    private(set) var persons: [Person] = []

    init() {
        serviceDeploy()
        delegateDeploy()
        personsService = service?.fetchAllPersons() ?? []
    }

    // MARK: Public Methods

    func addNewPerson() {
        let newPerson = personModel.generateRandom()
        switch database {
        case .local: addNewPersonLocal(to: newPerson)
        case .realm, .swiftData: addNewPersonService(to: newPerson)
        }
    }

    func removePerson(at person: Person) {
        switch database {
        case .local: removePersonLocal(at: person)
        case .realm, .swiftData: removePersonService(at: person)
        }
    }

    func editPerson(_ person: Person) {
        switch database {
        case .local: editPersonLocal(person)
        case .realm, .swiftData: editPersonService(person)
        }
    }

    // MARK: Service

    private func serviceDeploy() {
        service = RealmService()
    }

    // MARK: Private Methods

    private func removePersonLocal(at person: Person) {
        guard let index = personsLocal.firstIndex(of: person) else { return }
        personsLocal.remove(at: index)
    }

    private func editPersonLocal(_ person: Person) {
        guard let index = personsLocal.firstIndex(of: person) else { return }

        personsLocal[index] = personModel.mutate(person)
    }

    private func addNewPersonLocal(to person: Person){
        personsLocal.append(person)
    }

    // MARK: Service

    private func removePersonService(at person: Person) {
        service?.delete(person)
    }

    private func editPersonService(_ person: Person) {
        let newPerson = personModel.mutate(person)
        service?.update(newPerson)
    }

    private func addNewPersonService(to person: Person){
        service?.save(person)
    }

    private func delegateDeploy() {
        service?.delegate = self
    }
}

extension MainViewModel: ServiceDelegate {
    func didUpdatePersons() {
        print("Обновляюсь")
        personsService = service?.fetchAllPersons() ?? []
    }
}

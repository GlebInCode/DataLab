//
//  MainViewModel.swift
//  DataLab
//
//  Created by Глеб Хамин on 01.07.2025.
//

import Foundation
import SwiftData

protocol ServiceDelegate: AnyObject {
    func didUpdatePersons()
}

@Observable
final class MainViewModel {
    typealias Person = PersonModel.Person

    var personModel: PersonModel = PersonModel()
    var service: ServiceProtocol?

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
       addNewPersonService(to: newPerson)

    }

    func removePerson(at person: Person) {
        removePersonService(at: person)
    }

    func editPerson(_ person: Person) {
        editPersonService(person)
    }

    // MARK: Service

    private func serviceDeploy() {
        service = RealmService()
    }

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
        personsService = service?.fetchAllPersons() ?? []
    }
}

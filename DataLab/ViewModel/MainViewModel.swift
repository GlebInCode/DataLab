//
//  MainViewModel.swift
//  DataLab
//
//  Created by Глеб Хамин on 01.07.2025.
//

import Foundation

@Observable
final class MainViewModel {
    typealias Person = PersonModel.Person

    var personModel: PersonModel = PersonModel()

    var persons: [Person] = []

    func addNewPerson() {
        persons.append(getNewPerson())
    }

    func removePerson(at person: Person) {
        removePersonLocal(at: person)
    }

    func editPerson(_ person: Person) {
        editPersonLocal(person)
    }

    private func removePersonLocal(at person: Person) {
        guard let index = persons.firstIndex(of: person) else { return }
        persons.remove(at: index)
    }

    private func editPersonLocal(_ person: Person) {
        guard let index = persons.firstIndex(of: person) else { return }

        persons[index] = personModel.mutate(person)
    }

    private func getNewPerson() -> Person {
        personModel.generateRandom()
    }


}

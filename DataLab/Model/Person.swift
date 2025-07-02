//
//  Person.swift
//  DataLab
//
//  Created by Глеб Хамин on 01.07.2025.
//

import Foundation

struct PersonModel {

    struct Person: Identifiable, Equatable {
        var name: String
        var age: Int?
        var link: URL?
        var birthday: Date?
        var isStudent: Bool?
        var planet: Planet?

        var id: UUID = UUID()
    }

    var mok: [Person] {
        [Person(
            name: "Alice",
            age: 28,
            link: URL(string: "https://example.com/alice")!,
            birthday: Calendar.current.date(from: DateComponents(year: 1996, month: 3, day: 15))!,
            isStudent: false,
            planet: .earth
        ),
        Person(
            name: "Bob",
            age: 22,
            link: URL(string: "https://example.com/bob")!,
            birthday: Calendar.current.date(from: DateComponents(year: 2002, month: 11, day: 2))!,
            isStudent: true,
            planet: .mars
        ),
        Person(
            name: "Clara",
            age: 35,
            link: URL(string: "https://example.com/clara")!,
            birthday: Calendar.current.date(from: DateComponents(year: 1989, month: 6, day: 8))!,
            isStudent: false,
            planet: .venus
        ),
        Person(
            name: "David",
            age: 30,
            link: URL(string: "https://example.com/david")!,
            birthday: Calendar.current.date(from: DateComponents(year: 1994, month: 1, day: 20))!,
            isStudent: true,
            planet: .jupiter
        ),
        Person(
            name: "Eva",
            age: 26,
            link: URL(string: "https://example.com/eva")!,
            birthday: Calendar.current.date(from: DateComponents(year: 1998, month: 9, day: 5))!,
            isStudent: false,
            planet: .saturn
        )]
    }

    func generateRandom() -> Person {
        let names = ["Alice", "Bob", "Clara", "David", "Eva", "Frank", "Grace", "Helen", "Ivan", "Julia"]
        let planets: [Planet] = [.mercury, .venus, .earth, .mars, .jupiter, .saturn, .uranus, .neptune]

        let name = names.randomElement() ?? "John Doe"
        let age = Int.random(in: 18...70)
        let link = URL(string: "https://example.com/\(name.lowercased())")

        let currentYear = Calendar.current.component(.year, from: Date())
        let birthYear = currentYear - age
        let birthMonth = Int.random(in: 1...12)
        let birthDay = Int.random(in: 1...28)
        let birthday = Calendar.current.date(from: DateComponents(year: birthYear, month: birthMonth, day: birthDay))!

        let isStudent = Bool.random()
        let planet = planets.randomElement()!

        let person = Person(
            name: name,
            age: age,
            link: link,
            birthday: birthday,
            isStudent: isStudent,
            planet: planet
        )

        return person
    }

    func mutate(_ person: Person) -> Person {
        let planets: [Planet] = [.mercury, .venus, .earth, .mars, .jupiter, .saturn, .uranus, .neptune]

        let age = Int.random(in: 18...70)
        let link = URL(string: "https://example.com/\(person.name.lowercased())")

        let currentYear = Calendar.current.component(.year, from: Date())
        let birthYear = currentYear - age
        let birthMonth = Int.random(in: 1...12)
        let birthDay = Int.random(in: 1...28)
        let birthday = Calendar.current.date(from: DateComponents(year: birthYear, month: birthMonth, day: birthDay))!

        let isStudent = Bool.random()
        let planet = planets.randomElement()!

        return Person(
            name: person.name,
            age: age,
            link: link,
            birthday: birthday,
            isStudent: isStudent,
            planet: planet,
            id: person.id          
        )
    }
}

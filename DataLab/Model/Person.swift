//
//  Person.swift
//  DataLab
//
//  Created by Глеб Хамин on 01.07.2025.
//

import Foundation

struct Person: Identifiable {
    var name: String
    var age: Int
    var link: URL
    var birthday: Date
    var isStudent: Bool
    var planet: Planet

    var id: UUID = UUID()

    static var mok: [Person] {
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
}

//
//  MainView.swift
//  DataLab
//
//  Created by Глеб Хамин on 01.07.2025.
//

import SwiftUI
import SwiftData

enum DataService: String, CaseIterable, Identifiable {
    case swiftData = "SwiftData"
    case realm = "Realm"

    var id: String { rawValue }
}

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \PersonObjectSD.name) private var persons: [PersonObjectSD]

    private var viewModel: MainViewModel

    @State private var selectedData: DataService = .realm

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            HStack {
                Picker("Data", selection: $selectedData) {
                    ForEach(DataService.allCases) { data in
                        Text(data.rawValue).tag(data)
                    }
                }
                .pickerStyle(.segmented)
                Button {
                    if selectedData == .realm {
                        viewModel.addNewPerson()
                    } else {
                        let new = generateRandomSD()
                        modelContext.insert(new)
                        try? modelContext.save()
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
            .padding()

            if selectedData == .realm {
                List(viewModel.persons, id: \.id) { person in
                    VStack {
                        HStack {
                            Text(person.name)
                            Text(person.age?.description ?? "000")
                            Spacer()
                            Circle()
                                .foregroundColor(person.isStudent == nil ? .black : person.isStudent! ? .green : .blue)
                                .frame(width: 20, height: 20)
                        }
                        HStack {
                            Text(person.birthday ?? Date(), format: .dateTime.day(.twoDigits).month(.twoDigits).year())
                            Text(person.planet?.rawValue ?? "000")
                            Spacer()

                        }
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            viewModel.removePerson(at: person)
                        } label: {
                            Label("Удалить", systemImage: "trash")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            viewModel.editPerson(person)
                        } label: {
                            Label("Редактировать", systemImage: "pencil")
                        }
                        .tint(.blue)
                    }
                }
            } else {
                List {
                    ForEach(persons, id: \.id) { person in
                        VStack {
                            HStack {
                                Text(person.name)
                                Text(person.age?.description ?? "000")
                                Spacer()
                                Circle()
                                    .foregroundColor(person.isStudent == nil ? .black : person.isStudent! ? .green : .blue)
                                    .frame(width: 20, height: 20)
                            }
                            HStack {
                                Text(person.birthday ?? Date(), format: .dateTime.day().month().year())
                                Text(person.planet?.name ?? "000")
                                Spacer()
                            }
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                modelContext.delete(person)
                                try? modelContext.save()
                            } label: {
                                Label("Удалить", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                mutate(person)
                                try? modelContext.save()
                            } label: {
                                Label("Редактировать", systemImage: "pencil")
                            }
                            .tint(.blue)
                        }
                    }
                }
            }
        }
    }


    private func generateRandomSD() -> PersonObjectSD {
        let names = ["Alice", "Bob", "Clara", "David", "Eva", "Frank", "Grace", "Helen", "Ivan", "Julia"]
        let planets: [Planet] = [.mercury, .venus, .earth, .mars, .jupiter, .saturn, .uranus, .neptune]

        let name = names.randomElement() ?? "John Doe"
        let age = Int.random(in: 18...70)
        let link = URL(string: "https://example.com/\(name.lowercased())")!

        let currentYear = Calendar.current.component(.year, from: Date())
        let birthYear = currentYear - age
        let birthMonth = Int.random(in: 1...12)
        let birthDay = Int.random(in: 1...28)
        let birthday = Calendar.current.date(from: DateComponents(year: birthYear, month: birthMonth, day: birthDay))!

        let isStudent = Bool.random()
        let planet = PlanetObjectSD(planet: planets.randomElement()!)

        return PersonObjectSD(
            name: name,
            age: age,
            link: link,
            birthday: birthday,
            isStudent: isStudent,
            planet: planet
        )
    }

    private func mutate(_ person: PersonObjectSD) {
        person.age = Int.random(in: 18...70)
        person.isStudent = Bool.random()
        person.birthday = Calendar.current.date(from: DateComponents(
            year: 2024 - (person.age ?? 20),
            month: Int.random(in: 1...12),
            day: Int.random(in: 1...28)
        ))
        person.link = URL(string: "https://example.com/\(person.name.lowercased())")
        person.planet = PlanetObjectSD(planet: [.mercury, .venus, .earth, .mars, .jupiter, .saturn, .uranus, .neptune].randomElement()!)
    }

}

#Preview {
    MainView(viewModel: MainViewModel())
}

//
//  MainView.swift
//  DataLab
//
//  Created by Глеб Хамин on 01.07.2025.
//

import SwiftUI

struct MainView: View {
    @State private var persons: [Person] = Person.mok

    var body: some View {
        VStack {
            Button {

            } label: {
                Image(systemName: "plus")
            }

            List(persons, id: \.id) { person in
                VStack {
                    HStack {
                        Text(person.name)
                        Text(person.age.description)
                        Spacer()
                        Circle()
                            .foregroundColor(person.isStudent ? .green : .blue)
                            .frame(width: 20, height: 20)
                    }
                    HStack {
                        Text(person.birthday, format: .dateTime.day(.twoDigits).month(.twoDigits).year())
                        Text(person.planet.rawValue)
                        Spacer()

                    }
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {

                    } label: {
                        Label("Удалить", systemImage: "trash")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {

                    } label: {
                        Label("Редактировать", systemImage: "pencil")
                    }
                    .tint(.blue)
                }
            }
        }
    }
}

#Preview {
    MainView()
}

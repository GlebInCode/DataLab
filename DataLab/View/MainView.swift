//
//  MainView.swift
//  DataLab
//
//  Created by Глеб Хамин on 01.07.2025.
//

import SwiftUI

struct MainView: View {
    private var viewModel: MainViewModel

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Button {
                viewModel.addNewPerson()
            } label: {
                Image(systemName: "plus")
            }

            List(viewModel.persons, id: \.id) { person in
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
        }
    }
}

#Preview {
    MainView(viewModel: MainViewModel())
}

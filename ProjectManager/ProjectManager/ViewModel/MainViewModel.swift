//
//  Model.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import Foundation
import SwiftUI

protocol MainViewModelInputInterface {
    func onCreateEvent()
    func onTouchAddButton()
    func onDismissSheet()
}

protocol MainViewModelOutputInterface {
    var eventListViewModel: EventListViewModel { get }
    var currentEvetDetailViewModel: DetailViewModel { get }
    var isTouchAddButton: Bool { get }
}

protocol MainViewModelable: ObservableObject {
    var input: MainViewModelInputInterface { get }
    var output: MainViewModelOutputInterface { get }
}

class ProjectManager: MainViewModelable {
    func notifyChange() {
        objectWillChange.send()
    }
    
    var output: MainViewModelOutputInterface { return self }
    var input: MainViewModelInputInterface { return self }
    @Published var isTouchAddButton: Bool = false
    @Published var eventListViewModel = EventListViewModel()

    var currentEvetDetailViewModel: DetailViewModel {
        guard let viewModel = self.eventListViewModel.output
                .itemViewModels.last?.detailViewModel else {
                    return DetailViewModel(event: Event(title: "", description: "", date: Date(), state: .ToDo, id: UUID()))
        }
        return viewModel
    }
}

extension ProjectManager: MainViewModelInputInterface {
    func onCreateEvent() {
        self.eventListViewModel.input.onAddEvent()
    }
    
    func onTouchAddButton() {
        self.isTouchAddButton = true
    }
    
    func onDismissSheet() {
        self.isTouchAddButton = false
    }

}

extension ProjectManager: MainViewModelOutputInterface {
    
}

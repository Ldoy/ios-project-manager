//
//  EventListViewModel.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/11/04.
//

import Foundation
import UIKit

protocol ListViewModelInputInterface {
    func onDeleteRow(at indexSet: IndexSet)
    func onAddEvent()
    func onCountEventNumber(eventState: EventState) -> Int
}

protocol ListViewModelOutputInterface {
    var itemViewModels: [ItemViewModel] { get }
}

protocol ListViewModelable: ObservableObject {
    var input: ListViewModelInputInterface { get }
    var output: ListViewModelOutputInterface { get }
}

class EventListViewModel: ListViewModelable, Delegatable {
    var input: ListViewModelInputInterface { return self }
    var output: ListViewModelOutputInterface { return self }

    @Published var itemViewModels: [ItemViewModel] = []

    init() {
        let itemViewModel = ItemViewModel()
        itemViewModel.delegate = self
        self.itemViewModels.append(itemViewModel)
    }
}

extension EventListViewModel {
    func notifyChange() {
        objectWillChange.send()
    }
}

extension EventListViewModel: ListViewModelInputInterface {
    func onDeleteRow(at indexSet: IndexSet) {
        self.itemViewModels.remove(atOffsets: indexSet)
    }
    
    func onAddEvent() {
        let itemViewModel = ItemViewModel()
        itemViewModel.delegate = self
        self.itemViewModels.append(itemViewModel)
    }
    
    func onCountEventNumber(eventState: EventState) -> Int {
        return self.itemViewModels.filter { item in
            item.currentEvent.state == eventState
        }.count
    }
}

extension EventListViewModel: ListViewModelOutputInterface {
}
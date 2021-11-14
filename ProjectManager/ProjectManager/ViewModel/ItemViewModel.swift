//
//  EventViewModel.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/11/04.
//

import Foundation

protocol ItemViewModelInputInterface {
    func onChangeEventState(to eventState: EventState)
    func onTouchRow()
    func onPressRow()
}

protocol ItemViewModelOutputInterface {
    var detailViewModel: DetailViewModel { get }
    var currentEvent: Event { get }
    var isOutDated: Bool { get }
    var delegate: Delegatable? { get }
    var isTouchRow: Bool { get }
    var isPressedRow: Bool { get }
}

protocol ItemViewModelable: ObservableObject {
    var input: ItemViewModelInputInterface { get }
    var output: ItemViewModelOutputInterface { get }
}

protocol Delegatable: AnyObject {
    func notifyChange()
}

class ItemViewModel: ItemViewModelable, Delegatable, Identifiable {
    func notifyChange() {
        objectWillChange.send()
    }
    
    var id: UUID = UUID()
    
    var input: ItemViewModelInputInterface { return self }
    var output: ItemViewModelOutputInterface { return self }
    weak var delegate: Delegatable?
    @Published var isTouchRow: Bool = false
    @Published var isPressedRow: Bool = false
    
    @Published var detailViewModel = DetailViewModel(event:
                                                        Event(title: "제목을 입력해 주세요",
                                                              description: "1000자까지 입력해 주세요",
                                                              date: Date(),
                                                              state: .ToDo,
                                                              id: UUID()))
    var currentEvent: Event {
        detailViewModel.output.event
    }
    
    var isOutDated: Bool {
        self.detailViewModel.isOutDated
    }
    
    init() {
        detailViewModel.delegate = self
    }
}

extension ItemViewModel: ItemViewModelInputInterface {
    func onChangeEventState(to eventState: EventState) {
        self.detailViewModel.event.state = eventState
        self.delegate?.notifyChange()
    }
    
    func onTouchRow() {
        self.isTouchRow.toggle()
    }
    
    func onPressRow() {
        self.isPressedRow.toggle()
    }
}

extension ItemViewModel: ItemViewModelOutputInterface {
}


//
//  EventViewModel.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/11/04.
//

import Foundation

protocol EventViewModelInputInterface {
    mutating func onChangeEventState(to eventState: EventState)
    mutating func onSaveTitle(title: String)
    mutating func onSaveDescription(description: String)
    mutating func onSaveDate(date: Date)
    mutating func onTouchEditAndDoneButton()
}

protocol EventViewModelOutputInterface {
    var isOutDated: Bool { get }
    var event: Event { get }
    var editAndDoneButtonTitle: String { get }
    var isInteractionDisabled: Bool { get }
}

protocol EventViewModelable {
    var input: EventViewModelInputInterface { get }
    var output: EventViewModelOutputInterface { get }
}

protocol Delegatable: AnyObject {
    func notifyChange()
}

struct EventViewModel: EventViewModelable, Identifiable {
    weak var delegate: Delegatable?
    var id: UUID = UUID()
    
    var input: EventViewModelInputInterface { return self }
    var output: EventViewModelOutputInterface { return self }
    
    var event: Event = Event(title: "제목을 입력해 주세요",
                                        description: "1000자까지 입력해 주세요",
                                        date: Date(),
                                        state: .ToDo,
                                        id: UUID())
    
     var isInteractionDisabled: Bool = true
     var isOutDated: Bool = false
     var isPresented: Bool = false
     var editAndDoneButtonTitle: String = ButtonTitle.edit.rawValue

    enum ButtonTitle: String {
        case edit = "Edit"
        case done = "Done"
    }
}

extension EventViewModel: EventViewModelInputInterface {
 
    
    mutating func onSaveTitle(title: String) {
        self.event.title = title
    }
    
    mutating func onSaveDescription(description: String) {
        self.event.description = description
    }
    
    mutating func onSaveDate(date: Date) {
        let today = Date()
        let calendar = Calendar.current
        if calendar.compare(today, to: date, toGranularity: .day) == .orderedDescending {
            self.isOutDated = true
        }
        self.event.date = date
    }
    
    mutating func onTouchEditAndDoneButton() {
        self.isInteractionDisabled.toggle()
        if isInteractionDisabled {
            self.editAndDoneButtonTitle = ButtonTitle.edit.rawValue
        } else {
            self.editAndDoneButtonTitle = ButtonTitle.done.rawValue
        }
    }
    
    mutating func onChangeEventState(to eventState: EventState) {
        self.event.state = eventState
        self.delegate?.notifyChange()
    }
}

extension EventViewModel: EventViewModelOutputInterface {
}


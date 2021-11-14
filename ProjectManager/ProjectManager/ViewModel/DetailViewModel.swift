////
////  DetailViewModel.swift
////  ProjectManager
////
////  Created by Do Yi Lee on 2021/11/04.
////
//
//import Foundation
//import SwiftUI
//
//protocol DetailViewModelInputInterface {
//    func onSaveTitle(title: String)
//    func onSaveDescription(description: String)
//    func onSaveDate(date: Date)
//    func onTouchEditandDoneButton()
//}
//
//protocol DetailViewModelOutputInterface {
//    var event: Event { get }
//    var editAndDoneButtonTitle: String { get }
//    var isInteractionDisabled: Bool { get }
//}
//
//protocol DetailViewModelable: ObservableObject {
//    var input: DetailViewModelInputInterface { get }
//    var output: DetailViewModelOutputInterface { get }
//}
//
//class DetailViewModel: DetailViewModelable {
//    var input: DetailViewModelInputInterface { return self }
//    var output: DetailViewModelOutputInterface { return self }
//    
//    var delegate: Delegatable?
//    var isOutDated: Bool = false
//    var editAndDoneButtonTitle: String = ButtonTitle.edit.rawValue
//    @Published var isInteractionDisabled: Bool = true
//
//    var event: Event {
//        didSet {
//            delegate?.notifyChange()
//        }
//    }
//    
//    init(event: Event) {
//        self.event = event
//    }
//}
//
//extension DetailViewModel: DetailViewModelInputInterface {
//    enum ButtonTitle: String {
//        case edit = "Edit"
//        case done = "Done"
//    }
//    
//    func onSaveTitle(title: String) {
//        self.event.title = title
//    }
//    
//    func onSaveDescription(description: String) {
//        self.event.description = description
//    }
//    
//    func onSaveDate(date: Date) {
//        let today = Date()
//        let calendar = Calendar.current
//        if calendar.compare(today, to: date, toGranularity: .day) == .orderedDescending {
//            self.isOutDated = true
//        }
//        self.event.date = date
//    }
//    
//    func onTouchEditandDoneButton() {
//        self.isInteractionDisabled.toggle()
//        if isInteractionDisabled {
//            self.editAndDoneButtonTitle = ButtonTitle.edit.rawValue
//        } else {
//            self.editAndDoneButtonTitle = ButtonTitle.done.rawValue
//        }
//    }
//}
//
//extension DetailViewModel: DetailViewModelOutputInterface {
//
//}

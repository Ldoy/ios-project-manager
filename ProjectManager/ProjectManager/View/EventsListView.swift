//
//  ListView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import SwiftUI

//class EventViewModelWrapper: ObservableObject {
//    @Published var viewModel = [EventViewModel()]
//}

struct EventListView<Value: EventListViewModel>: View {
    var state: EventState
    @ObservedObject var eventListViewModel: Value
    var body: some View {
        VStack {
            
//            EventListHeader(eventTitle: state.rawValue,
//                            eventNumber: "\(eventListViewModels.input.onCountEventNumber(eventState: state))")
            List {
                ForEach(eventListViewModel.output.itemViewModels) { viewModel in
                    if viewModel.output.event.state == state {
                        EventListRowView(viewModel: viewModel)
                    }
    
                }.onDelete { indexSet in
                    eventListViewModel.input.onDeleteRow(at: indexSet)
                }
            }
        }
    }
}

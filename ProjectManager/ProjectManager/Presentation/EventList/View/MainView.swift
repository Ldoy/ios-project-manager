//
//  MainView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import SwiftUI

struct MainView<T: MainViewModelable>: View {
    @ObservedObject var viewModel: T
    
    init(viewModel: T) {
        UINavigationBar.appearance().backgroundColor = .systemGray5
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            HStack {
                ForEach(EventState.allCases, id: \.self) {
                    EventListView(eventListViewModels: viewModel.output.eventListViewModel, state: $0)
                }
            }
            .navigationBarTitle("프로젝트 관리")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: button)
        }
        .navigationViewStyle(.stack)
    }
    
    var button: some View {
        Button("+") {
            viewModel.input.onTouchAddButton()
        }
        .sheet(isPresented: Binding<Bool>(get: {
            viewModel.output.isTouchAddButton
        }, set: { _ in } )
        ) {
            viewModel.input.onDismissSheet()
        } content: {
            DetailEventView(detailViewModel:
                                viewModel.output.currentEvetDetailViewModel,
                            id: UUID())
        }.onChange(of: viewModel.output.isTouchAddButton) { newValue in
            if newValue {
                self.viewModel.input.onCreateEvent()
            }
        }
        .font(.title2)
    }
}

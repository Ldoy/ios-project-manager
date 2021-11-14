//
//  ListRowView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/11/05.
//

import SwiftUI


struct EventListRowView: View {
    var viewModel: EventViewModelable
    @State var isPopOvered: Bool = false
    
    private func decideDateTextColor() -> Color {
        if viewModel.output.isOutDated {
            return Color.red
        }
        return .black
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.output.event.title)
                .font(.title)
            Text(viewModel.output.event.description)
                .frame(height: 30, alignment: .leading)
                .font(.body)
                .foregroundColor(.gray)
            Text(viewModel.output.event.date, style: .date)
                .font(.callout)
                .foregroundColor(decideDateTextColor())
        }
        .onLongPressGesture {
            self.isPopOvered = true
        }
        .popover(isPresented: $isPopOvered) {
//            PopOverView(eventState: listRowViewModelWrapper.viewModel.output.event.state,
//                        viewModel: listRowViewModelWrapper.viewModel)
        }
    }
}

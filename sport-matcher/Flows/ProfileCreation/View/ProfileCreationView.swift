//
//  ProfileCreationView.swift
//  sport-matcher
//
//  Created by Dawid on 24/07/2024.
//

import SwiftUI

struct ProfileCreationView: View {
    enum Field {
        case name
    }

    @StateObject private var viewModel: ProfileCreationViewModel
    @FocusState private var focusedField: Field?
    
    init() {
        self._viewModel = StateObject(
            wrappedValue: ProfileCreationViewModel()
        )
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack() {
                    Spacer()
                    profilePicture()
                    Spacer()
                }
                ZStack {
                    Color.white
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(.gray, lineWidth: 1)
                    TextField("Name", text: $viewModel.name)
                        .font(.title2)
                        .foregroundStyle(.black)
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                        .autocorrectionDisabled()
                        .focused($focusedField, equals: .name)
                }
                .frame(height: 30)
                .onTapGesture {
                    focusedField = .name
                }
                ScrollView {
                    activitiesChooser()
                }
                Spacer()
                Button {
                    print("Create")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                        Text("Create")
                            .foregroundStyle(.white)
                    }
                }
                .frame(height: 40)
            }
            .padding(.vertical)
            .navigationTitle("Create profile")
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private func profilePicture() -> some View {
        Button {
            print("add photo")
        } label: {
            VStack {
                ZStack {
                    Circle()
                        .foregroundStyle(.gray)
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .foregroundStyle(.black)
                }
                .frame(width: 100)
                Text("Add photo")
                    .foregroundStyle(.black)
            }
        }
    }

    @ViewBuilder
    private func activitiesChooser() -> some View {
        VStack {
            ForEach(viewModel.getActivitiesRows(), id: \.self) { activities in
                activityRow(activities: activities)
            }
        }
        .background(
            GeometryReader { proxy in
                viewModel.setActivitiesViewWidth(proxy.size.width)
                return Color.clear
            }
        )
    }
    
    @ViewBuilder
    private func activityRow(activities: [ActivityRow]) -> some View {
        HStack {
            ForEach(activities, id: \.activity.rawValue) { activityRow in
                if activityRow.hashValue == activities.first?.hashValue {
                    Spacer()
                }
                Button {
                    print(activityRow.activity.label)
                } label: {
                    ChipsButtonView(
                        title: activityRow.activity.label,
                        font: viewModel.activityFont,
                        titleHorizontalPadding: viewModel.activitiesCellHorizontalPadding
                    ) { isSelected in
                        print(isSelected)
                    }
                    .frame(width: activityRow.width)
                }
                
                if activityRow.hashValue == activities.last?.hashValue {
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ProfileCreationView()
}

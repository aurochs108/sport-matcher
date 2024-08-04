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
        case whatsapp
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
                .onTapGesture {
                    focusedField = .name
                }
                profileTextField(text: "Name", output: $viewModel.name, keyboardType: .default, field: .name)
                profileTextField(text: "Whatsapp number", output: $viewModel.name, keyboardType: .decimalPad, field: .whatsapp)
                ScrollView {
                    activitiesChooser()
                }
                .scrollBounceBehavior(.basedOnSize)
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
    private func profileTextField(
        text: String,
        output: Binding<String>,
        keyboardType: UIKeyboardType,
        field: Field
    ) -> some View {
        ZStack {
            Color.white
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(.gray, lineWidth: 1)
            TextField(text, text: output)
                .font(.title2)
                .foregroundStyle(.black)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                .autocorrectionDisabled()
                .focused($focusedField, equals: field)
                .keyboardType(keyboardType)
        }
        .frame(height: 30)
        .onTapGesture {
            focusedField = field
        }
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

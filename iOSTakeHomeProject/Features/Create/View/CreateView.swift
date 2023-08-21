//
//  CreateView.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 13.08.2023.
//

import SwiftUI

struct CreateView: View {
    @Environment (\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    @StateObject private var viewModel = CreateViewModel()
    let successfulAction: () -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    firstName
                    lastName
                    job
                } footer: {
                    if case .validation(let error) = viewModel.error,
                       let errorDesc = error.errorDescription {
                        Text(errorDesc)
                            .foregroundStyle(.red)
                    }
                }
                
                
                Section {
                    submit
                }
            }
            .disabled(viewModel.state == .submitting)
            .navigationTitle("Create")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    done
                }
            }
            .onChange(of: viewModel.state) { formState in
                if formState == .successful {
                    dismiss()
                    successfulAction()
                }
            }
            .overlay {
                if viewModel.state == .submitting {
                    ProgressView()
                }
            }
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView {
            
        }
    }
}

extension CreateView {
    enum Field: Hashable {
        case firstName
        case lastName
        case job
    }
}


private extension CreateView {
    
    var done: some View {
        Button {
            dismiss()
        } label: {
            Text("Done")
                .fontWeight(.semibold)
        }
        .accessibilityIdentifier("doneBtn")

    }
    
    var firstName: some View {
        TextField("First Name", text: $viewModel.person.firstName)
            .focused($focusedField, equals: .firstName)
            .accessibilityIdentifier("firstNameTxtField")

        
    }
    
    var lastName: some View {
        TextField("Last Name", text: $viewModel.person.lastName)
            .focused($focusedField, equals: .lastName)
            .accessibilityIdentifier("lastNameTxtField")

    }
    
    var job: some View {
        TextField("Job", text: $viewModel.person.job)
            .focused($focusedField, equals: .job)
            .accessibilityIdentifier("jobTxtField")

    }
    
    var submit: some View {
        Button("Submit") {
            // TODO: - Handle action
            focusedField = nil
            Task {
                await viewModel.create()
            }
        }
        .accessibilityIdentifier("submitBtn")
    }
}

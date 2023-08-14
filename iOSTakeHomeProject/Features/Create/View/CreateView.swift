//
//  CreateView.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 13.08.2023.
//

import SwiftUI

struct CreateView: View {
    @Environment (\.dismiss) private var dismiss
    @StateObject private var viewModel = CreateViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                firstName
                lastName
                job
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
        CreateView()
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

    }
    
    var firstName: some View {
        TextField("First Name", text: $viewModel.person.firstName)
    }
    
    var lastName: some View {
        TextField("Last Name", text: $viewModel.person.lastName)
    }
    
    var job: some View {
        TextField("Job", text: $viewModel.person.job)
    }
    
    var submit: some View {
        Button("Submit") {
            // TODO: - Handle action
            viewModel.create()
        }
    }
}

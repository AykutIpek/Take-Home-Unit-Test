//
//  CreateViewModel.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 13.08.2023.
//

import Foundation


final class CreateViewModel: ObservableObject {
    
    @Published var person = NewPerson()
    @Published private(set) var state: SubmissionState?
    @Published var hasError: Bool = false
    @Published private(set) var error: FormError?
    
    private let validator = CreateValidator()
    
    @MainActor
    func create() async {
        do {
            try validator.validate(person)
            
            state = .submitting
            
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try encoder.encode(person)
            
            try await NetworkingManager.shared.request(.create(submissionData: data))
            
            state = .successful
        } catch {
            self.hasError = true
            
            switch error {
            case is NetworkingManager.NetworkingError:
                self.state = .unsuccessful
                self.error = .networking(error: error as! NetworkingManager.NetworkingError)
            case is CreateValidator.CreateValidotorError:
                self.state = .unsuccessful
                self.error = .validation(error: error as! CreateValidator.CreateValidotorError)
            default:
                self.error = .system(error: error)
            }
        }
    }
}


extension CreateViewModel {
    enum SubmissionState {
        case unsuccessful
        case successful
        case submitting
    }
}


extension CreateViewModel {
    enum FormError: LocalizedError {
        case networking(error: LocalizedError)
        case validation(error: LocalizedError)
        case system(error: Error)
    }
}

extension CreateViewModel.FormError {
    var errorDescription: String? {
        switch self {
        case .networking(let error):
            return error.localizedDescription
        case .validation(let error):
            return error.localizedDescription
        case .system(let err):
            return err.localizedDescription
        }
    }
}

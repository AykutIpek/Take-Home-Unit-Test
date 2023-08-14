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
    
    func create() {
        
        do {
            try validator.validate(person)
            
            state = .submitting
            
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try? encoder.encode(person)
            
            NetworkingManager.shared.request(.create(submissionData: data)) {[weak self] res in
                DispatchQueue.main.async {
                    switch res {
                    case .success:
                        self?.state = .successful
                    case .failure(let err):
                        self?.state = .unsuccessful
                        self?.hasError = true
                        self?.error = .networking(error: err as! NetworkingManager.NetworkingError)
                        if let networkingError = err as? NetworkingManager.NetworkingError {
                            self?.error = .networking(error: networkingError)
                        }
                        print("DEBUG: Create viewModel err \(err.localizedDescription)")
                        break
                    }
                }
            }
        } catch {
            self.hasError = true
            if let validatorError = error as? CreateValidator.CreateValidotorError {
                self.error = .validation(error: validatorError)
            }
            print("DEBUG: \(error.localizedDescription)")
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
    }
}

extension CreateViewModel.FormError {
    var errorDescription: String? {
        switch self {
        case .networking(let error):
            return error.localizedDescription
        case .validation(let error):
            return error.localizedDescription
        }
    }
}

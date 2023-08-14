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
    @Published private(set) var error: NetworkingManager.NetworkingError?
    
    func create() {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try? encoder.encode(person)
        
        NetworkingManager.shared.request(methodType: .POST(data: data), "https://reqres.in/api/users") {[weak self] res in
            DispatchQueue.main.async {
                switch res {
                case .success:
                    self?.state = .successful
                case .failure(let err):
                    self?.state = .unsuccessful
                    self?.hasError = true
                    self?.error = err as? NetworkingManager.NetworkingError
                    print("DEBUG: Create viewModel err \(err.localizedDescription)")
                    break
                }
            }
        }
    }
}


extension CreateViewModel {
    enum SubmissionState {
        case unsuccessful
        case successful
    }
}
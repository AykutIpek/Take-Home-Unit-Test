//
//  PeopleViewModel.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 13.08.2023.
//

import Foundation


final class PeopleViewModel: ObservableObject {
    @Published private(set) var users: [User] = []
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError = false
    
    
    func fetchUser(){
        NetworkingManager.shared.request("https://reqres.in/api/users", type: UserResponse.self) {[weak self] res in
            DispatchQueue.main.async {
                switch res {
                case .success(let response):
                    self?.users = response.data
                case .failure(let error):
                    self?.hasError = true
                    self?.error = error as? NetworkingManager.NetworkingError
                    print("DEBUG: Fetch json error in people view\(error.localizedDescription)")
                }
            }
        }
    }
    
}

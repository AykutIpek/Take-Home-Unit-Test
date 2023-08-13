//
//  DetailViewModel.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 13.08.2023.
//

import Foundation


final class DetailViewModel: ObservableObject {
    
    @Published private(set) var userInfo: UserDetailResponse?
    
    
    func fetchDetails(for id: Int) {
        NetworkingManager.shared.request("https://reqres.in/api/users/\(id)", type: UserDetailResponse.self) {[weak self] res in
            DispatchQueue.main.async {
                switch res {
                case .success(let response):
                    self?.userInfo = response
                case .failure(let error):
                    print("DEBUG: Fetch json error in people view\(error.localizedDescription)")
                }
            }
        }
    }
}

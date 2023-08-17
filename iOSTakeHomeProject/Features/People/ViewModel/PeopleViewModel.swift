//
//  PeopleViewModel.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 13.08.2023.
//

import Foundation

@MainActor
final class PeopleViewModel: ObservableObject {
    //MARK: - Properties
    @Published private(set) var users: [User] = []
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var viewState: ViewState?
    @Published var hasError = false
    
    private(set) var page = 1
    private var totalPages: Int?
    private let networkingManager: NetworkingManagerProtocol!
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    //MARK: - LifeCycle
    init(networkingManager: NetworkingManagerProtocol = NetworkingManager.shared) {
        self.networkingManager = networkingManager
    }
    
    //MARK: - Functions
    @MainActor
    func fetchUser() async {
        reset()
        viewState = .loading
        defer { viewState = .finished }
        
        do {
            let response = try await networkingManager.request(session: .shared, .people(page: page), type: UserResponse.self)
            self.totalPages = response.totalPages
            self.users = response.data
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    @MainActor
    func fetchNextSetOfUsers() async {
        
        guard page != totalPages else { return }
        viewState = .fetching
        defer {
            viewState = .finished
        }
        page += 1
        
        do {
            let response = try await networkingManager.request(session: .shared, .people(page: page), type: UserResponse.self)
            self.totalPages = response.totalPages
            self.users += response.data
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
        
    }
    
    func hasReachedEnd(of user: User) -> Bool {
        users.last?.id == user.id
    }
    
}


extension PeopleViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}


private extension PeopleViewModel {
    func reset() {
        if viewState == .finished {
            users.removeAll()
            page = 1
            totalPages = nil
            viewState = nil
        }
    }
}

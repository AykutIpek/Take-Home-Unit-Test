//
//  PeopleView.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 12.08.2023.
//

import SwiftUI

struct PeopleView: View {
    //MARK: - Properties
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    @StateObject private var viewModel = PeopleViewModel()
    @State private var shouldShowCreate = false
    @State private var sholudShowSuccess = false
    @State private var hasAppeared = false
    
    init() {
        #if DEBUG
        
        if UITestingHelper.isUITesting {
            let mock: NetworkingManagerProtocol = UITestingHelper.isPeopleNetworkingSuccessfuly ? NetworkingManagerUserDetailsResponseSuccessMock() : NetworkingManagerUserDetailsResponseFailureMock()
            _viewModel = StateObject(wrappedValue: PeopleViewModel(networkingManager: mock))
        } else {
            _viewModel = StateObject(wrappedValue: PeopleViewModel())
        }
        #else
        _viewModel = StateObject(wrappedValue: PeopleViewModel())
        #endif
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                background
                
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .mint))
                            .scaleEffect(2.0, anchor: .center)
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.users, id: \.id) { user in
                                NavigationLink {
                                    DetailView(userId: user.id)
                                } label: {
                                    PersonItemView(user: user)
                                        .accessibilityIdentifier("item_\(user.id)")
                                        .task {
                                            if viewModel.hasReachedEnd(of: user) && !viewModel.isFetching {
                                                await viewModel.fetchNextSetOfUsers()
                                            }
                                        }
                                }
                                

                            }
                        }
                        .padding()
                        .accessibilityIdentifier("peopleGrid")
                    }
                    .overlay(alignment: .bottom) {
                        if viewModel.isFetching {
                            ProgressView()
                        }
                    }
                }
            }
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    create
                    
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    refresh
                }
            }
            .task {
                if !hasAppeared {
                    await viewModel.fetchUser()
                    hasAppeared = true
                }
            }
            .sheet(isPresented: $shouldShowCreate) {
                CreateView {
                    haptic(.success)
                    withAnimation(.spring().delay(0.25)) {
                        self.sholudShowSuccess.toggle()
                    }
                }
            }
            .alert(isPresented: $viewModel.hasError, error: viewModel.error) {
                Button("Retry") {
                    Task {
                        await viewModel.fetchUser()
                    }
                }
            }
            .overlay {
                if sholudShowSuccess {
                    CheckmarkPopover()
                        .transition(.scale.combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.spring()){
                                    self.sholudShowSuccess.toggle()
                                }
                            }
                        }
                }
            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}


private extension PeopleView {
    
    var create: some View {
        Button {
            shouldShowCreate.toggle()
        } label: {
            Image(systemName: Symbols.plus.rawValue)
                .font(.system(.headline, design: .rounded))
                .fontWeight(.bold)
        } 
        .disabled(viewModel.isLoading)
    }
    
    var background: some View {
        Color(Theme.background.rawValue)
            .edgesIgnoringSafeArea(.all)
    }
    
    var refresh: some View {
        Button {
            Task {
                await viewModel.fetchUser()
            }
        } label: {
            Image(systemName: Symbols.refresh.rawValue)
        }
        .disabled(viewModel.isLoading)
    }
}

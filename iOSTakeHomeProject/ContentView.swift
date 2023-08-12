//
//  ContentView.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 12.08.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
                .onAppear {
                    print("User Response")
                    
                    dump(try? StaticJSONMapper.decode(file: "UserStaticData",
                                                 type: UserResponse.self))
                    print("Single User Response")
                    
                    dump(try? StaticJSONMapper.decode(file: "SingleUserData",
                                                 type: UserDetailResponse.self))
                }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  CraeteValidatorSuccessMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by aykut ipek on 18.08.2023.
//

import Foundation

#if DEBUG
struct CreateValidatorSuccessMock: CreateValidatorProtocol {
    func validate(_ person: iOSTakeHomeProject.NewPerson) throws {
        
    }
}
#endif

//
//  CreateValidatorFailureMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by aykut ipek on 18.08.2023.
//

import Foundation


#if DEBUG
struct CreateValidatorFailureMock: CreateValidatorProtocol {
    func validate(_ person: NewPerson) throws {
        throw CreateValidator.CreateValidotorError.invalidFirstName
    }

    
}

#endif

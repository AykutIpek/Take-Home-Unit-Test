//
//  CreateValidatorFailureMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by aykut ipek on 18.08.2023.
//

import Foundation
@testable import iOSTakeHomeProject


struct CreateValidatorFailureMock: CreateValidatorProtocol {
    func validate(_ person: iOSTakeHomeProject.NewPerson) throws {
        throw CreateValidator.CreateValidotorError.invalidFirstName
    }
    
    
}

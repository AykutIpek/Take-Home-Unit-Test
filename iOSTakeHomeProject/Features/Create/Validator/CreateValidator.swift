//
//  CreateValidator.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 14.08.2023.
//

import Foundation

protocol CreateValidatorProtocol {
    func validate(_ person: NewPerson) throws
}

struct CreateValidator: CreateValidatorProtocol {
    
    func validate(_ person: NewPerson) throws {
        if person.firstName.isEmpty {
            throw CreateValidotorError.invalidFirstName
        }
        
        if person.lastName.isEmpty {
            throw CreateValidotorError.invalidLastName
        }
        
        if person.job.isEmpty {
            throw CreateValidotorError.invalidJob
        }
    }
    
}

extension CreateValidator {
    enum CreateValidotorError: LocalizedError {
        case invalidFirstName
        case invalidLastName
        case invalidJob
    }
}


extension CreateValidator.CreateValidotorError {
    var errorDescription: String? {
        switch self {
        case .invalidFirstName:
            return "First name can't be empty"
        case .invalidLastName:
            return "Last name can't be empty"
        case .invalidJob:
            return "Job can't be empty"
        }
    }
}

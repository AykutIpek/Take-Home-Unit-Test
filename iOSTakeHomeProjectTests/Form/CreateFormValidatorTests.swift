//
//  CreateFormValidatorTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by aykut ipek on 21.08.2023.
//

import XCTest
@testable import iOSTakeHomeProject

class CreateFormValidatorTests: XCTestCase {

    private var validator: CreateValidator!
    
    override func setUp() {
        validator = CreateValidator()
    }
    
    override func tearDown() {
        validator = nil
    }
    
    func test_with_empty_person_first_name_error_thrown() {
        let person = NewPerson()
        XCTAssertThrowsError(try validator.validate(person), "Error for an empty first name should be thrown")
        
        do {
            _ = try validator.validate(person)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidotorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, CreateValidator.CreateValidotorError.invalidFirstName, "Expecting an error where we have an invalid first name")
        }
    }
    
    func test_with_empty_first_name_error_thrown() {
        
        let person = NewPerson(lastName: "Ads", job: "iOS Dev")
        XCTAssertThrowsError(try validator.validate(person), "Error for an empty first name should be thrown")

        do {
            _ = try validator.validate(person)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidotorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, CreateValidator.CreateValidotorError.invalidFirstName, "Expecting an error where we have an invalid first name")
        }
    }
    
    func test_with_empty_last_name_error_thrown() {
        
        let person = NewPerson(firstName: "Tunds", job: "iOS Dev")
        XCTAssertThrowsError(try validator.validate(person), "Error for an empty last name should be thrown")

        do {
            _ = try validator.validate(person)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidotorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, CreateValidator.CreateValidotorError.invalidLastName, "Expecting an error where we have an invalid last name")
        }
    }
    
    func test_with_empty_job_error_thrown() {
        
        let person = NewPerson(firstName: "Tunds", lastName: "Ads")
        XCTAssertThrowsError(try validator.validate(person), "Error for an empty job should be thrown")

        do {
            _ = try validator.validate(person)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidotorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, CreateValidator.CreateValidotorError.invalidJob, "Expecting an error where we have an invalid job")
        }
    }
    
    func test_with_valid_person_error_not_thrown() {
        
        let person = NewPerson(firstName: "Tunds", lastName: "Ads", job: "iOS Dev")
        
        do {
            _ = try validator.validate(person)
        } catch {
            XCTFail("No errors should be thrown, since the person should be a valid object")
        }
    }
}

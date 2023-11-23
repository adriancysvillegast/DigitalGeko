//
//  Test_LogInViewModel.swift
//  DigitalGekoTests
//
//  Created by Adriancys Jesus Villegas Toro on 22/11/23.
//

import XCTest

@testable import DigitalGeko

final class Test_LogInViewModel: XCTestCase {

    var sut: LogInViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = LogInViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func test_LogInViewModel_ShouldValidate() throws {
        let email = "adriancys@digitalgeko.com"
        let password = "12133131"
        
        sut.validateEmail(emailUser: email)
        sut.validatePassword(password: password)
        
        XCTAssertTrue(sut.emailValidate)
        XCTAssertTrue(sut.passwordValidate)
        
    }


    func test_LogInViewModel_ShouldInvalidate() throws {
        let email = "adriancysdigitalgeko.com"
        let password = ""
        
        sut.validateEmail(emailUser: email)
        sut.validatePassword(password: password)
        
        XCTAssertFalse(sut.emailValidate)
        XCTAssertFalse(sut.passwordValidate)
        
    }
}

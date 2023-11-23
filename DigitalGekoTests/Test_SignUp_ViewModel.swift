//
//  Test_SignUp_ViewModel.swift
//  Test_SignUp_ViewModel
//
//  Created by Adriancys Jesus Villegas Toro on 22/11/23.
//

import XCTest

@testable import DigitalGeko

final class Test_SignUp_ViewModel: XCTestCase {

    var sut: SignUpViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SignUpViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func test_SignUpViewModel_ShouldValidate() throws {
        
        let name = "Carlos"
        let email = "Carlos@digitalgeko.com"
        let password = "A1234a%"
        let numberPhone = "1234567891"
        
        sut.nameValidate(nameUser: name)
        sut.emailValidate(emailUser: email)
        sut.passwordValidate(password: password)
        sut.contactNumberValidate(number: numberPhone)
        
        XCTAssertTrue(sut.nameValidate)
        XCTAssertTrue(sut.emailValidate)
        XCTAssertTrue(sut.passwordValidate)
        XCTAssertTrue(sut.numberValidate)
    }
    
    func test_SignUpViewModel_ShouldInvalidate() throws {
        
        let name: String = ""
        let email = "Carlos@digitalgeko"
        let password = "666666645ghhkkk"
        let numberPhone = "17891"
        
        sut.nameValidate(nameUser: name)
        sut.emailValidate(emailUser: email)
        sut.passwordValidate(password: password)
        sut.contactNumberValidate(number: numberPhone)
        
        XCTAssertFalse(sut.nameValidate)
        XCTAssertFalse(sut.emailValidate)
        XCTAssertFalse(sut.passwordValidate)
        XCTAssertFalse(sut.numberValidate)
    }


}

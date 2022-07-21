//
//  NetworkModelTests.swift
//  DragonBallXibsTests
//
//  Created by Joaquín Corugedo Rodríguez on 21/7/22.
//

import XCTest
@testable import DragonBallXibs

class NetworkModelTests: XCTestCase {

    private var urlSessionMock: URLSessionMock!
    private var sut: NetworkModel!

    override func setUpWithError() throws {
        urlSessionMock = URLSessionMock()
        sut = NetworkModel(urlSession: urlSessionMock)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLoginSuccess() throws {
      let expectation = expectation(description: "Login Success")
      var retrievedToken: String?
      var error: NetworkError?
      
      sut.login(user: "juan.guidi@globant.com", password: "123456") { token, networkError in
        retrievedToken = token
        error = networkError
        expectation.fulfill()
      }
      
      waitForExpectations(timeout: 5)
      
      XCTAssertNotNil(retrievedToken, "should have received a token")
      XCTAssertNil(error, "should be no error")
    }
    
    func testLoginFail() throws {
      let expectation = expectation(description: "Login Fail")
      var retrievedToken: String?
      var error: NetworkError?
      
      sut.login(user: "juan.guidi", password: "123456") { token, networkError in
        retrievedToken = token
        error = networkError
        expectation.fulfill()
      }
      
      waitForExpectations(timeout: 5)
      
      XCTAssertNil(retrievedToken, "should have not received a token")
      XCTAssertNotNil(error, "should be an error")
    }
    
    
    func testGetHerosSuccess(){
        var error: NetworkError?
        var retrievedHeroes: [Hero]?
        
        //Given
        sut.token = "testToken"
        urlSessionMock.data = getHeroesData(resourceName: "heroes")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        sut.getHeroes { heroes, networkError in
          error = networkError
          retrievedHeroes = heroes
        }
        
        //Then
        XCTAssertEqual(retrievedHeroes?.first?.id, "Hero ID", "should be the same hero as in the json file")
        XCTAssertNil(error, "there should be no error")
    }

}

extension NetworkModelTests {
  func getHeroesData(resourceName: String) -> Data? {
    let bundle = Bundle(for: NetworkModelTests.self)
    
    guard let path = bundle.path(forResource: resourceName, ofType: "json") else {
      return nil
    }
    
    return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
  }
}

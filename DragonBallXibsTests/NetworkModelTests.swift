//
//  NetworkModelTests.swift
//  DragonBallXibsTests
//
//  Created by Joaquín Corugedo Rodríguez on 21/7/22.
//

import XCTest
@testable import DragonBallXibs

enum ErrorMock: Error {
  case mockCase
}

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
    
    func testLoginFailWithNoData() {
      var error: NetworkError?
      
      //Given
      urlSessionMock.data = nil
      
      //When
      sut.login(user: "", password: "") { _, networkError in
        error = networkError
      }
      
      //Then
      XCTAssertEqual(error, .noData)
    }
    
    func testLoginFailWithError() {
      var error: NetworkError?
      
      //Given
      urlSessionMock.data = nil
      urlSessionMock.error = ErrorMock.mockCase
      
      //When
      sut.login(user: "", password: "") { _, networkError in
        error = networkError
      }
      
      //Then
      XCTAssertEqual(error, .other)
    }
    
    func testLoginFailWithErrorCodeNil() {
      var error: NetworkError?
      
      //Given
      urlSessionMock.data = "TokenString".data(using: .utf8)!
      urlSessionMock.response = nil
      
      //When
      sut.login(user: "", password: "") { _, networkError in
        error = networkError
      }
      
      //Then
      XCTAssertEqual(error, .errorCode(nil))
    }
    
    func testLoginFailWithErrorCode() {
      var error: NetworkError?
      
      //Given
      urlSessionMock.data = "TokenString".data(using: .utf8)!
      urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 404, httpVersion: nil, headerFields: nil)
      
      //When
      sut.login(user: "", password: "") { _, networkError in
        error = networkError
      }
      
      //Then
      XCTAssertEqual(error, .errorCode(404))
    }

    func testLoginSuccessWithMockToken() throws {
        var retrievedToken: String?
        var error: NetworkError?
        
        //Given
        urlSessionMock.error = nil
        urlSessionMock.data = "TokenString".data(using: .utf8)!
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        sut.login(user: "", password: "") { token, networkError in
            retrievedToken = token
            error = networkError
        }
        
        //Then
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
        urlSessionMock.data = getMockData(resourceName: "heroes")
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
    
    
    func testGetTransformationsSuccess(){
        var error: NetworkError?
        var retrievedTransformations: [Transformation]?
        
        //Given
        sut.token = "TestToken"
        urlSessionMock.data = getMockData(resourceName: "transformations")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //When
        sut.getTransformations(id: "Hero ID") { transformations, networkError in
            error = networkError
            retrievedTransformations = transformations
        }
        
        XCTAssertEqual(retrievedTransformations?.first?.id, "Transformation ID", "should be the same transformation as in the json file")
        XCTAssertNil(error, "there should be no error")
    }

}

extension NetworkModelTests {
  func getMockData(resourceName: String) -> Data? {
    let bundle = Bundle(for: NetworkModelTests.self)
    
    guard let path = bundle.path(forResource: resourceName, ofType: "json") else {
      return nil
    }
    
    return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
  }
}

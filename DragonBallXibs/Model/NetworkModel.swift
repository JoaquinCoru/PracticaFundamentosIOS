//
//  NetworkModel.swift
//  DragonBallXibs
//
//  Created by Joaquín Corugedo Rodríguez on 16/7/22.
//

import Foundation

enum NetworkError: Error, Equatable {
  case malformedURL
  case dataFormatting
  case other
  case noData
  case errorCode(Int?)
  case tokenFormatError
  case decoding
}

final class NetworkModel{
    
    let session: URLSession
    
    var token: String?
    
    init(urlSession: URLSession = .shared, token: String? = nil) {
      self.session = urlSession
      self.token = token
    }
    
    func login(user: String, password: String, completion: @escaping (String?, NetworkError?) -> Void) {
      guard let url = URL(string: "https://vapor2022.herokuapp.com/api/auth/login") else {
        completion(nil, .malformedURL)
        return
      }
      
      let loginString = String(format: "%@:%@", user, password)
      guard let loginData = loginString.data(using: .utf8) else {
        completion(nil, .dataFormatting)
        return
      }
      let base64LoginString = loginData.base64EncodedString()
      
      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "POST"
      urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
      
      //URLSession.shared
      let task = session.dataTask(with: urlRequest) { data, response, error in
        guard error == nil else {
          completion(nil, .other)
          return
        }
        
        guard let data = data else {
          completion(nil, .noData)
          return
        }
        
        guard let httpResponse = (response as? HTTPURLResponse),
              httpResponse.statusCode == 200 else {
          completion(nil, .errorCode((response as? HTTPURLResponse)?.statusCode))
          return
        }
        
        guard let token = String(data: data, encoding: .utf8) else {
          completion(nil, .tokenFormatError)
          return
        }
      
        completion(token, nil)
      }
      
      task.resume()
    }
}

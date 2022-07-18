//
//  HeroModel.swift
//  DragonBallXibs
//
//  Created by Joaquín Corugedo Rodríguez on 18/7/22.
//

import Foundation

struct Hero: Decodable {
  let id: String
  let name: String
  let description: String
  let photo: URL
  let favorite: Bool
}

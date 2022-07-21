//
//  TransformationModel.swift
//  DragonBallXibs
//
//  Created by Joaquín Corugedo Rodríguez on 18/7/22.
//

import Foundation


struct Transformation:Decodable{
    let id:String
    let name:String
    let description: String
    let photo: URL
}

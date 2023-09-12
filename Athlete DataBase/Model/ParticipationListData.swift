//
//  ParticipationListData.swift
//  Athlete DataBase
//
//  Created by Apple8 on 11/09/23.
//

import Foundation

class  ParticipationListData : Codable {
    
    let athlete_id : String?
    let name : String?
    let surname : String?
    let bio : String?
    let dateOfBirth : String?
    let weight : Int?
    let height : Int?
    let photo_id : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case athlete_id = "athlete_id"
        case name = "name"
        case surname = "surname"
        case bio = "bio"
        case dateOfBirth = "dateOfBirth"
        case weight = "weight"
        case height = "height"
        case photo_id = "photo_id"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        athlete_id = try values.decodeIfPresent(String.self, forKey: .athlete_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        surname = try values.decodeIfPresent(String.self, forKey: .surname)
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
        weight = try values.decodeIfPresent(Int.self, forKey: .weight)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        photo_id = try values.decodeIfPresent(Int.self, forKey: .photo_id)
    }
}

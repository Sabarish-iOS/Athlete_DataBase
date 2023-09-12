//
//  AthleteDetailsViewModel.swift
//  Athlete DataBase
//
//  Created by Apple8 on 11/09/23.
//

import UIKit

class AthleteDetailsViewModel: NSObject {
    
    override init() {
        super.init()
    }
    
    func getAthleteDeatils(url:String, result: @escaping(Result<AthleteDetailsData?,ApiError>) -> Void){
        ApiManager.shared.fetch(baseUrl: url, methodType: .get, contentType: .applicationJson, param: "", completion: result)
    }

}

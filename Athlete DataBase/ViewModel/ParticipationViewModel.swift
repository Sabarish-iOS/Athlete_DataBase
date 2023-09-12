//
//  ParticipationViewModel.swift
//  Athlete DataBase
//
//  Created by Apple8 on 11/09/23.
//

import UIKit

class ParticipationViewModel: NSObject {
    
    override init() {
        super.init()
    }
    
    func getParticipationList(url:String, result: @escaping(Result<[ParticipationListData]?,ApiError>) -> Void){
        ApiManager.shared.fetch(baseUrl: url, methodType: .get, contentType: .applicationJson, param: "", completion: result)
    }
}

//
//  PrizeDetailsViewModel.swift
//  Athlete DataBase
//
//  Created by Apple8 on 12/09/23.
//

import UIKit

class PrizeDetailsViewModel: NSObject {

    override init() {
        super.init()
    }
    
    func getprizeDeatils(url:String, result: @escaping(Result<[PrizeDeatilsData]?,ApiError>) -> Void){
        ApiManager.shared.fetch(baseUrl: url, methodType: .get, contentType: .applicationJson, param: "", completion: result)
    }
    
}

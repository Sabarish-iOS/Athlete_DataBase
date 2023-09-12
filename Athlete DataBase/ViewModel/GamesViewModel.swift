//
//  GamesViewModel.swift
//  Athlete DataBase
//
//  Created by Apple8 on 11/09/23.
//

import UIKit

class GamesViewModel: NSObject {
    
    override init() {
        super.init()
    }
    
    func getGameList(url:String, result: @escaping(Result<[GameListData]?,ApiError>) -> Void){
        ApiManager.shared.fetch(baseUrl: url, methodType: .get, contentType: .applicationJson, param: "", completion: result)
    }
}

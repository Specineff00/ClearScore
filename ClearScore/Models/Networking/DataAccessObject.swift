//
//  DataAccessObject.swift
//  ClearScore
//
//  Created by Nikash Ramsorrun on 31/07/2019.
//  Copyright © 2019 Nikash Ramsorrun. All rights reserved.
//

import Foundation

//The reasoning for the Data Access Object is to make a simple interface for calls. It can be said using the Network Layer does that but this extra level allows extras such as accessing storage. An example use is logging in with the network layer and then the token would be saved in the storage ie user defaults

//The use of contracts allows the network layer or the dao to be mocked easily for testing


protocol DataAccessObjectContract {
    func getScore(onCompletion:  @escaping CreditScoreClosure)
}


class DataAccessObject: DataAccessObjectContract {
    let networkLayer: NetworkLayerContract
    
    init(networkLayer: NetworkLayerContract) {
        self.networkLayer = networkLayer
    }
    
    func getScore(onCompletion:  @escaping CreditScoreClosure) {
        networkLayer.getScore(onCompletion: onCompletion)
    }
}




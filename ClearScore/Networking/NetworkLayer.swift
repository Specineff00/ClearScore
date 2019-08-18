//
//  NetworkLayer.swift
//  ClearScore
//
//  Created by Yogesh N Ramsorrrun on 18/08/2019.
//  Copyright © 2019 Nikash Ramsorrun. All rights reserved.
//

import Foundation

typealias CompletionClosure = (Result<(URLResponse, Data), Error>) -> Void
typealias CreditScoreClosure = (CSResult<CreditScore>) -> Void

enum CSResult<T> {
    case success(T)
    case failure(CSError)
}

enum CSError: Error {
    case decodeError
    case serverError
    case unknown
}

enum HTTPMethod: String {
    case get
    case put
    
    var rawValue: String {
        return "\(self)".uppercased()
    }
}


protocol NetworkLayerContract {
    func getScore(onCompletion: @escaping CreditScoreClosure)
}

class NetworkLayer: NetworkLayerContract {
    
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func getScore(onCompletion: @escaping CreditScoreClosure) {
        URLSession.shared.dataTask(withUrl: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_, let data):
                    do {
                        let creditReport = try JSONDecoder().decode(CreditReport.self, from: data)
                        onCompletion(.success(creditReport.creditScore))
                    } catch {
                        onCompletion(.failure(CSError.decodeError))
                    }
                case .failure(let error):
                    guard let csError = error as? CSError else {
                        onCompletion(.failure(CSError.unknown))
                        return
                    }
                    onCompletion(.failure(csError))
                }
            }
        }.resume()
    }
}



//
//  Network.swift
//  Marvellous
//
//  Created by Giuseppe Bottiglieri on 20/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import UIKit
import Alamofire
import CryptoSwift

class Network {
    
    struct APIConfig {
        static let apikey = APIKey.publicKey
        static let ts = Date().timeIntervalSince1970.description
        static let hash = "\(ts)\(APIKey.privateKey)\(apikey)".md5()
    }
    
    struct APIUrl {
        static let baseDomainString = "http://gateway.marvel.com"
        static let characters = baseDomainString + "/v1/public/characters"
        static let series = baseDomainString + "/v1/public/series"
        static let comics = baseDomainString + "/v1/public/comics"
    }
    
    func getCharacters(limit: Int, offset: Int, nameStartsWith: String = "", completion: @escaping([Character]?, Error?) ->()) {
        let URL = APIUrl.characters
        
        var p: Parameters = [
            "apikey" : APIConfig.apikey,
            "ts": APIConfig.ts,
            "hash": APIConfig.hash
        ]
        
        if nameStartsWith.isEmpty {
            p["limit"] = limit
            p["offset"] = offset
        } else {
            p["nameStartsWith"] = nameStartsWith
        }
        
        let req = Alamofire.request(URL, method: .get, parameters: p, encoding: URLEncoding.default)
        req.responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success:
                do {
                    let item = try JSONDecoder().decode(CharactersModel.self, from: response.data!)
                    
                    if item.code == 409 {
                        completion(nil, self.getErrorWith(message: item.status))
                    } else {
                        completion(item.data?.results ?? [], nil)
                    }
                } catch let jsonError {
                    print("Error serializing json: ", jsonError)
                    completion(nil, jsonError as NSError)
                }
                
            case .failure(let error):
                print(error)
                completion(nil,error as NSError)
            }
        })
    }
    
    func getSeries(limit: Int, offset: Int, completion: @escaping([Series]?, Error?) ->()) {
        let URL = APIUrl.series
        let params = getParameters(limit: limit, offset: offset)
        
        let req = Alamofire.request(URL, method: .get, parameters: params, encoding: URLEncoding.default)
        req.responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success:
                do {
                    let item = try JSONDecoder().decode(SeriesModel.self, from: response.data!)
                    
                    if item.code == 409 {
                        completion(nil, self.getErrorWith(message: item.status))
                    } else {
                        completion(item.data?.results ?? [], nil)
                    }
                } catch let jsonError {
                    print("Error serializing json: ", jsonError)
                    completion(nil, jsonError as NSError)
                }
                
            case .failure(let error):
                print(error)
                completion(nil,error as NSError)
            }
        })
    }
    
    func getComics(limit: Int, offset: Int, completion: @escaping([Comic]?, Error?) ->()) {
        let URL = APIUrl.comics
        let params = getParameters(limit: limit, offset: offset)
        
        let req = Alamofire.request(URL, method: .get, parameters: params, encoding: URLEncoding.default)
        req.responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success:
                do {
                    let item = try JSONDecoder().decode(ComicsModel.self, from: response.data!)
                    
                    if item.code == 409 {
                        completion(nil, self.getErrorWith(message: item.status))
                    } else {
                        completion(item.data?.results ?? [], nil)
                    }
                } catch let jsonError {
                    print("Error serializing json: ", jsonError)
                    completion(nil, jsonError as NSError)
                }
                
            case .failure(let error):
                print(error)
                completion(nil,error as NSError)
            }
        })
    }
    
    private func getParameters(limit: Int, offset: Int) -> Parameters {
        return [
            "apikey" : APIConfig.apikey,
            "ts": APIConfig.ts,
            "hash": APIConfig.hash,
            "limit": limit,
            "offset": offset
        ]
    }
    
    private func getErrorWith(message: String?, code: Int = 409) -> NSError {
        let userInfo: [String: Any] = [
            NSLocalizedDescriptionKey: NSLocalizedString(message ?? "generic 409 error", comment: "") ,
            ]
        return NSError(domain: "marvel.com", code: code, userInfo: userInfo)
    }
}

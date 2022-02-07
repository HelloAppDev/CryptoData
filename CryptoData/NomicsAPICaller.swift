//
//  APICaller.swift
//  CryptoData
//
//  Created by Мария Изюменко on 31.01.2022.
//

import Foundation

final class NomicsAPICaller {
    static let shared = NomicsAPICaller()
    
    private struct Constants {
        static let apiKey = "65d826b99ad9177574292332ff03b21ca80d24b6"
        static let assetsEndPoint = "https://api.nomics.com/v1/currencies/"
        
    }
    
    private init() {
        
    }
    
    public func getAllCryptoData (completion: @escaping (Result <[CryptoModel], Error>) -> Void) {
        guard let url = URL(string: Constants.assetsEndPoint + "ticker?key=" + Constants.apiKey + "&ranks=1&interval=1d,30d&convert=USD&per-page=10&page=1") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                //Decode
                let jsonResult = try JSONDecoder().decode([CryptoModel].self, from: data)
                completion(.success(jsonResult))
        } catch {
            completion(.failure(error))
        }
    }
        task.resume()
}
}

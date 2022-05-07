//
//  JokeModel.swift
//  ChallengeOne
//
//  Created by Сергей Шевелев on 06.05.2022.
//

import Foundation


protocol JokeDelegate {
    func didUpdateJoke(_ jokeModel: JokeManager, joke: JokeModel)
    func didFailWithError(error: Error)
}

class JokeManager {

    let url = "https://joke.deno.dev/"
    
    var delegate: JokeDelegate?
    
    func performRequest() {
        
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let joke = self.parseJSON(safeData) {
                        self.delegate?.didUpdateJoke(self, joke: joke)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ jokeData: Data) -> JokeModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(JokeModel.self, from: jokeData)
            return decodedData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}



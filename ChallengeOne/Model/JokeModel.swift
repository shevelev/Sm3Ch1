//
//  JokeModel.swift
//  ChallengeOne
//
//  Created by Сергей Шевелев on 06.05.2022.
//

import Foundation

struct JokeModel {
    

    
     func getData() -> ResponseJoke {
        
        let url = "https://joke.deno.dev/"
        var joke: ResponseJoke = ResponseJoke()
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            //have data
            
            var results: ResponseJoke?
            do {
                results = try JSONDecoder().decode(ResponseJoke.self, from: data)
            } catch {
                print("Error occurs - \(error)")
                return
            }
            
            guard let json = results else {
                return
            }
            
            joke = json
            
        })
        task.resume()
         
        return joke
    }
}



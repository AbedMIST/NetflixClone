//
//  APICaller.swift
//  NetflixClone
//
//  Created by BS1095 on 30/5/23.
//

import Foundation


struct NetworkConstants{
    static let API_Key = "7be6a7d280cde81cd8d4a5c4dd040b31"
    static let baseURL = "https://api.themoviedb.org"
    static let Youtube_API_Key = "AIzaSyDXj5FlBy-z8q7MWkziqjlmXoAiGC1bQfc"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search"
}

enum APIError: Error{
    
    case failedToGetData
}


class APICaller {
    
    static let shared = APICaller()  //Singleton Obj
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void){  //Callback closure
        
        let urlString = NetworkConstants.baseURL + "/3/trending/movie/day?language=en-US&api_key=" + NetworkConstants.API_Key
        
        guard let url = URL(string: urlString) else{ return }
        
        //Background task -> escaping closure
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else{
                return
            }
            do{
//                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let result = try JSONDecoder().decode(MovieResponseModel.self, from: data)
                print(result.results.count)
                
                completion(.success(result.results))  //passing data
            }
            catch{
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getTrendingTVs(completion: @escaping (Result<[Movie], Error>) -> Void){
        
        let urlString = NetworkConstants.baseURL + "/3/trending/tv/day?language=en-US&api_key=" + NetworkConstants.API_Key
        
        guard let url = URL(string: urlString) else{ return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode(MovieResponseModel.self, from: data)
                print(result.results.count)
                
                completion(.success(result.results))
            }
            catch{
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        
        let urlString = NetworkConstants.baseURL + "/3/movie/upcoming?language=en-US&api_key=" + NetworkConstants.API_Key
        
        guard let url = URL(string: urlString) else{ return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode(MovieResponseModel.self, from: data)
                print(result.results.count)
                
                completion(.success(result.results))
            }
            catch{
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        
        let urlString = NetworkConstants.baseURL + "/3/movie/popular?language=en-US&api_key=" + NetworkConstants.API_Key
        
        guard let url = URL(string: urlString) else{ return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode(MovieResponseModel.self, from: data)
                print(result.results.count)
                
                completion(.success(result.results))
            }
            catch{
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        
        let urlString = NetworkConstants.baseURL + "/3/movie/top_rated?language=en-US&api_key=" + NetworkConstants.API_Key
        
        guard let url = URL(string: urlString) else{ return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode(MovieResponseModel.self, from: data)
                print(result.results.count)
                
                completion(.success(result.results))
            }
            catch{
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
    func getDiscoverMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        
        let urlString = NetworkConstants.baseURL + "/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&api_key=" + NetworkConstants.API_Key
        
        guard let url = URL(string: urlString) else{ return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode(MovieResponseModel.self, from: data)
                print(result.results.count)
                
                completion(.success(result.results))
            }
            catch{
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
    func search(with query: String, completion: @escaping (Result<[Movie], Error>) -> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else{
            return
        }
        let urlString = NetworkConstants.baseURL + "/3/search/movie?query=\(query)&include_adult=false&language=en-US&page=1&api_key=" + NetworkConstants.API_Key
        
        guard let url = URL(string: urlString) else{ return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode(MovieResponseModel.self, from: data)
                print(result.results.count)
                
                completion(.success(result.results))
            }
            catch{
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getYoutubeVideo(with query: String, completion: @escaping (Result<videoElements, Error>) -> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else{
            return
        }
        let urlString = NetworkConstants.YoutubeBaseURL + "?q=\(query)&key=" + NetworkConstants.Youtube_API_Key
        
        guard let url = URL(string: urlString) else{ return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                print(result.items)
                
                completion(.success(result.items[0]))  //first search res element is taken
            }
            catch{
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

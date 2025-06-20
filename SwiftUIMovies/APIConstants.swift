//
//  APIConstants.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Hazzaa on 17/01/2025.
//

class APIConstants {
    
    
    static let apiKey = "dc4b2d235940944327077a6adf8f8f58"
    
    static let apiAccessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYzRiMmQyMzU5NDA5NDQzMjcwNzdhNmFkZjhmOGY1OCIsIm5iZiI6MTU1MDY2NTEyOS44NjIwMDAyLCJzdWIiOiI1YzZkNDVhOTkyNTE0MTI1MGEwZjkwZjUiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.eNun2PzygP8BjiuUX5GaHgzaMyTF0O-wVbrCLalWU-I"
    
    static let baseAPIURL = "https://api.themoviedb.org/3/movie/"
    static let imagesBaseURL = "https://image.tmdb.org/t/p/w500"
    
    static let nowPlayingMovies = baseAPIURL + "now_playing"
    static let popularMovies = baseAPIURL + "popular"
    static let upcomingMovies = baseAPIURL + "upcoming"
}

import Foundation

protocol MoviesLoading {
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void)
}

struct MoviesLoader: MoviesLoading {
    private let networkClient = NetworkClient()
    
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void) {
    
    }
}

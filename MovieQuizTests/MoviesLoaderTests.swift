import Foundation
import XCTest
@testable import MovieQuiz

class MovieMoviesLoaderTests: XCTestCase {
    func testSuccessLoading() throws {
        //Given
        let loader = MoviesLoader()
        
        //When
        let expectation = expectation(description: "Loading expectation")
        
        loader.loadMovies { result in
        //Then
        switch result {
        case .success(let movies):
            expectation.fulfill()
        case .failure(_):
                // мы не ожидаем, что пришла ошибка; если она появится, надо будет провалить тест
            XCTFail("Unexpected failure") // эта функция проваливает тест
            }
        }
    }
        
    func testFailureLoading() throws {
            
        }
    
    }


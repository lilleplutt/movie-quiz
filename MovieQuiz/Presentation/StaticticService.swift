import Foundation

final class StaticticService: StatisticServiceProtocol {
    
    private var correctAnswers: Int = 0
    private let storage: UserDefaults = .standard
    
    private enum Keys: String {
        case correct
        case bestGame
        case gamesCount
    }
    
    var gamesCount: Int {
        get {
            storage.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    var bestGame: GameResult {
        get {
            let correct = storage.integer(forKey: "bestGameCorrect")
            let total = storage.integer(forKey: "bestGameTotal")
            let date = storage.object(forKey: "bestGameDate") as? Date ?? Date()
            
            return GameResult(correct: correct, total: total, date: date)
        }
        set {
            storage.set(newValue.correct, forKey: "bestGameCorrect")
            storage.set(newValue.total, forKey: "bestGameTotal")
            storage.set(newValue.date, forKey: "bestGameDate")
        }
    }
    
    var totalAccuracy: Double {
        get {
            let totalQuestions = storage.integer(forKey: "totalQuestions")
            guard totalQuestions > 0 else { return 0 }
            
            return Double(correctAnswers) / Double(totalQuestions) * 100
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        <#code#>
    }
    
    
}


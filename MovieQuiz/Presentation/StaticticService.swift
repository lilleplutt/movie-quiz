import Foundation

final class StaticticService: StatisticServiceProtocol {
    var gamesCount: Int {
        get {
            UserDefaults.standard.integer(forKey: "gamesCount")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "gamesCount")
        }
    }
    var bestGame: GameResult {
        get {
            
        }
        set {
            
        }
    }
    var totalAccuracy: Double {
        get {
            
        }
        set {
            
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        <#code#>
    }
    
    
}


import UIKit

class MovieQuizViewController: UIViewController, AlertPresenterProtocol {
    
    //MARK: - Properties
    private var presenter = MovieQuizPresenter!
    private let statisticService: StatisticServiceProtocol = StatisticServiceImplementation()
    private lazy var alertPresenter = AlertPresenter(view: self)
    
    //MARK: - Outlets
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MovieQuizPresenter(viewController: self)
        
        questionFactory = QuestionFactory(moviesLoader: MoviesLoader(), delegate: self)
        showLoadingIndicator()
        questionFactory?.loadData()
    }
    
    //MARK: - QuestionFactoryDelegate
    
    func didLoadDataFromServer() {
        activityIndicator.isHidden = true
        questionFactory?.requestNextQuestion()
    }

    func didFailToLoadData(with error: Error) {
        showNetworkError(message: error.localizedDescription)
    }
    
    //MARK: - AlertPresenterProtocol
    
    func present(alert: UIAlertController, animated: Bool) {
        self.present(alert, animated: animated)
    }
    
    //MARK: - Private functions
    
    private func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    private func showNetworkError(message: String) {
        hideLoadingIndicator()
        
        let model = AlertModel(title: "Что-то пошло не так(",
                               message: "Невозможно загрузить данные",
                               buttonText: "Попробовать еще раз") { [weak self] in
            guard let self = self else { return }
            
            self.presenter.currentQuestionIndex = 0
            self.presenter.restartGame()
            
            self.questionFactory?.requestNextQuestion()
        }
        
        alertPresenter.show(alert: model)
    }
    
    func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        counterLabel.text = step.questionNumber
        textLabel.text = step.question
    }
    
    func showAnswerResult(isCorrect: Bool) {
        presenter.didAnswer(isYes: isCorrect)

        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.presenter.questionFactory = self.questionFactory
            self.presenter.showNextQuestionOrResults()
        }
    }
    
    func didReceiveNextQuestion(question: QuizQuestion?) {
            presenter.didReceiveNextQuestion(question: question)
        }

    func show(result: QuizResultsViewModel) {
    statisticService.store(correct: presenter.correctAnswers, total: presenter.questionsAmount)
        
        let currentResult = "Ваш результат: \(presenter.correctAnswers)/\(presenter.questionsAmount)\n"
        let bestGame = statisticService.bestGame
        let bestGameInfo = "Рекорд: \(bestGame.correct)/\(bestGame.total)(\(bestGame.date.dateTimeString))\n"
        let totalAccuracy = "Средняя точность: \(String(format: "%.2f", statisticService.totalAccuracy))%\n"
        let gamesCount = "Количество сыгранных квизов: \(statisticService.gamesCount)"
        
        let alertModel = AlertModel(
            title: result.title,
            message: currentResult + bestGameInfo + totalAccuracy + gamesCount,
            buttonText: result.buttonText,
            completion: { [weak self] in
            guard let self = self else { return }
            
            self.presenter.currentQuestionIndex = 0
            self.presenter.restartGame()
            self.questionFactory?.requestNextQuestion()
        }
    )
        alertPresenter.show(alert: alertModel)
    }
    
    //MARK: - Actions
    @IBAction private func yesButtonClicked(_ sender: Any) {
        presenter.yesButtonClicked((Any).self)
    }
    
    @IBAction private func noButtonClicked(_ sender: Any) {
        presenter.noButtonClicked((Any).self)
    }
    
}





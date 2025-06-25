import Foundation
import UIKit

protocol AlertPresenterProtocol: AnyObject {
    func presentAlert(alert: UIAlertController, animated: Bool)
}

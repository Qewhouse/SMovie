
import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont){
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = .label
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

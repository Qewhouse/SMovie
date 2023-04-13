
import UIKit

final class SearchCollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = self.isSelected ? Theme.violetColor : Theme.appColor
            categoryLabel.textColor = self.isSelected ? .white : Theme.grayColor
        }
    }
    
    static let identifier = "SearchCollectionViewCell"

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "AAA"
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = Theme.grayColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(categoryLabel)
        setupConstraints()
        self.layer.cornerRadius = 22
        self.layer.borderWidth = 1
        self.layer.borderColor = Theme.grayColor.cgColor
        self.backgroundColor = Theme.appColor

    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: topAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(categoryText text: String) {
        self.categoryLabel.text = text
    }
}

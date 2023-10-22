//
//  FruitCollectionViewCell.swift
//  Collections
//
//  Created by Maria Slepneva on 18.10.2023.
//

import UIKit

class FruitCollectionViewCell: UICollectionViewCell {
    
    // MARK: Constant

    private enum Fruit: String {
        case apple = "apple"
        case orange = "orange"
        case strawberry = "strawberry"
        case banana = "banana"
    }

    // MARK: - Identifier

    static let identifier = "FruitCollectionViewCell"

    // MARK: - Subviews

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    // MARK: - Methods

    func configure(title: String) {
        imageView.image = UIImage(named: title)
        contentView.addSubview(imageView)
        let fruit = Fruit(rawValue: title) ?? .none

        switch fruit {
            case .apple:
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
                    imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -35),
                    imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
                    imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19)
                ])
            case .orange:
                NSLayoutConstraint.activate([
                    imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                    imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 39),
                    imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -39)
                ])
            case .banana:
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                    imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -22),
                    imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 63),
                    imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
                ])
            case .strawberry:
            NSLayoutConstraint.activate([
                imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19)
            ])
            case .none:
                fatalError()
        }
    }

    private func configureUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12.0
    }
}

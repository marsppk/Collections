//
//  ViewController.swift
//  Collections
//
//  Created by Maria Slepneva on 18.10.2023.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Constants

    private enum Constant {
        enum Collection {
            static let cellHeight = 160.0
            static let cellWeight = 242.0
            static let sectionInsets = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
            static let lineSpacing = 30.0
            static let interitemSpacing = 12.0
        }
    }

    private enum MainSection: Int, CaseIterable {
        case main
    }

    // MARK: - Properties

    private var data = ["strawberry", "banana", "orange", "apple"]

    // MARK: - Subviews

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(FruitCollectionViewCell.self, forCellWithReuseIdentifier: FruitCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.userInterfaceStyle == .dark {
            for i in 0...data.count {
                collectionView.cellForItem(at: IndexPath(item: i, section: 0))?.layer.shadowColor = UIColor(named: "shadowDark")?.cgColor
            }
        }
        else {
            for i in 0...data.count {
                collectionView.cellForItem(at: IndexPath(item: i, section: 0))?.layer.shadowColor = UIColor(named: "shadowLight")?.cgColor
            }
        }
            
    }

    // MARK: - Methods

    private func configureUI() {
        view.backgroundColor = UIColor(named: "bg")

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        MainSection.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = MainSection.allCases[section]

        switch sectionType {
        case .main:
            return data.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let section = MainSection.allCases[indexPath.section]

        switch section {
        case .main:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FruitCollectionViewCell.identifier,
                for: indexPath
            ) as? FruitCollectionViewCell else { return UICollectionViewCell() }

            cell.configure(title: data[indexPath.item])
            
            if traitCollection.userInterfaceStyle == .dark {
                cell.layer.shadowColor = UIColor(named: "shadowDark")?.cgColor
            } else {
                cell.layer.shadowColor = UIColor(named: "shadowLight")?.cgColor
            }
            cell.layer.shadowOffset = CGSize(width: 10, height: 10)
            cell.layer.shadowOpacity = 1
            cell.layer.shadowRadius = 4.0

            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 || indexPath.item == 3 {
            let widthPeritem = view.frame.width / 2 - 80
            return CGSize(width: widthPeritem, height: 160)
        } else {
            let widthPeritem = view.frame.width / 2 + 25
            return CGSize(width: widthPeritem, height: 160)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        Constant.Collection.sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Constant.Collection.interitemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constant.Collection.lineSpacing
    }
}

//
//  IngredientSection.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 01.06.2023.
//

import UIKit

struct IngredientSection: Section {
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(10),
            heightDimension: .estimated(10)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
            leading: .fixed(5),
            top: .fixed(5),
            trailing: .fixed(5),
            bottom: .fixed(5)
        )

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(10),
            heightDimension: .estimated(10)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(44)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 7, bottom: 10, trailing: 7)
        section.boundarySupplementaryItems = [header]
        return section
    }
}

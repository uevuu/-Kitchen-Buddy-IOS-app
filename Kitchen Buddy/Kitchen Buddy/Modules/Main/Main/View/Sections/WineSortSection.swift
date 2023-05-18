//
//  WineSortSection.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 16.05.2023.
//

import UIKit

struct WineSort {
    let title: String
    let value: String
    let description: String
}

enum WineSortSectionType {
    case whiteWines
    case redWines
    case otherWines
    
    var wines: [WineSort] {
        switch self {
        case .whiteWines:
            return [
                WineSort(title: "White Wine", value: "white_wine", description: "A type of wine made from white grapes"),
                WineSort(title: "Dry White Wine", value: "dry_white_wine", description: "A white wine with minimal residual sugar"),
                WineSort(title: "Assyrtiko", value: "assyrtiko", description: "A Greek white grape variety known for its high acidity"),
                WineSort(title: "Pinot Blanc", value: "pinot_blanc", description: " A white grape variety producing light, crisp wines"),
                WineSort(title: "Cortese", value: "cortese", description: "An Italian grape variety used to make Gavi wines"),
                WineSort(title: "Roussanne", value: "roussanne", description: "A white grape variety often used in blends, known for its rich texture"),
                WineSort(title: "Moschofilero", value: "moschofilero", description: "A Greek white grape variety with aromatic and floral characteristics"),
                WineSort(title: "Muscadet", value: "muscadet", description: "A light-bodied, dry white wine from the Loire Valley in France"),
                WineSort(title: "Viognier", value: "viognier", description: "An aromatic white grape variety with flavors of apricot and peach"),
                WineSort(title: "Verdicchio", value: "verdicchio", description: "An Italian white grape variety used to produce crisp and zesty wines"),
                WineSort(title: "Greco", value: "greco", description: "An Italian white grape variety known for its fresh and citrusy wines"),
                WineSort(title: "Marsanne", value: "marsanne", description: "A white grape variety often used in Rhône blends, producing full-bodied wines"),
                WineSort(title: "White Burgundy", value: "white_burgundy", description: "High-quality Chardonnay wines from Burgundy, France"),
                WineSort(title: "Chardonnay", value: "chardonnay", description: "A versatile white grape variety producing a range of styles"),
                WineSort(title: "Gruener Veltliner", value: "gruener_veltliner", description: "An Austrian white grape variety with peppery and citrus flavors"),
                WineSort(title: "White Rioja", value: "white_rioja", description: "White wines from the Rioja region in Spain, often made from Viura grapes"),
                WineSort(title: "Frascati", value: "frascati", description: "A crisp and fruity white wine from the Frascati region in Italy"),
                WineSort(title: "Gavi", value: "gavi", description: "A white wine made from Cortese grapes in the Gavi region of Italy"),
                WineSort(title: "L'acadie Blanc", value: "l_acadie_blanc", description: "A Canadian white grape variety used to make dry and aromatic wines"),
                WineSort(title: "Trebbiano", value: "trebbiano", description: "An Italian white grape variety, also known as Ugni Blanc"),
                WineSort(title: "Sauvignon Blanc", value: "sauvignon_blanc", description: "A popular white grape variety with vibrant and herbaceous flavors"),
                WineSort(title: "Catarratto", value: "catarratto", description: "An Italian white grape variety used in both dry and sweet wines"),
                WineSort(title: "Albarino", value: "albarino", description: "A Spanish white grape variety known for its crisp and aromatic wines"),
                WineSort(title: "Arneis", value: "arneis", description: "An Italian white grape variety producing aromatic and floral wines"),
                WineSort(title: "Verdejo", value: "verdejo", description: "A Spanish white grape variety with citrus and tropical fruit flavors"),
                WineSort(title: "Vermentino", value: "vermentino", description: "A Mediterranean white grape variety known for its fresh and aromatic wines"),
                WineSort(title: "Soave", value: "soave", description: "A light and dry Italian white wine from the Veneto region"),
                WineSort(title: "Pinot Grigio", value: "pinot_grigio", description: "A white grape variety producing crisp and refreshing wines"),
                WineSort(title: "Dry Riesling", value: "dry_riesling", description: "A dry style of Riesling known for its acidity and floral aromas"),
                WineSort(title: "Torrontes", value: "torrontes", description: "An aromatic white grape variety commonly grown in Argentina"),
                WineSort(title: "Mueller Thurgau", value: "mueller_thurgau", description: "A white grape variety known for producing aromatic and fruity wines"),
                WineSort(title: "Grechetto", value: "grechetto", description: "An Italian white grape variety used to make crisp and dry wines"),
                WineSort(title: "Gewurztraminer", value: "gewurztraminer", description: "An aromatic white grape variety with distinct floral and spicy flavors"),
                WineSort(title: "Chenin Blanc", value: "chenin_blanc", description: "A versatile white grape variety producing both dry and sweet wines"),
                WineSort(title: "White Bordeaux", value: "white_bordeaux", description: "White wines from the Bordeaux region in France, often made from Sauvignon blanc and Muscadelle"),
                WineSort(title: "Semillon", value: "semillon", description: "A white grape variety known for its golden-colored and honed wines"),
                WineSort(title: "Riesling", value: "riesling", description: "A highly aromatic white grape variety with a range of styles from dry to sweet"),
                WineSort(title: "Sauternes", value: "sauternes", description: "A sweet white wine from the Sauternes region in France, often made from Semillon and Sauvignon Blanc "),
                WineSort(title: "Sylvaner", value: "sylvaner", description: "A white grape variety producing light and crisp wines, mainly in Germany and Alsace"),
                WineSort(title: "Lilletblanc", value: "lillet_blanc", description: "A French aperitif wine with a blend of Bordeaux wines and citrus liqueurs")
            ]
        case .redWines:
            return [
                WineSort(title: "Red wine", value: "red_wine", description: "A type of wine made from red or black grapes"),
                WineSort(title: "Dry Red Wine", value: "dry_red_wine", description: "Red wine with minimal residual sugar"),
                WineSort(title: "Petite Sirah", value: "petite_sirah", description: "A red grape variety known for its dark color and full-bodied wines"),
                WineSort(title: "Zweigelt", value: "zweigelt", description: "A red grape variety originating from Austria, producing medium-bodied wines"),
                WineSort(title: "Baco Noir", value: "baco_noir", description: "A hybrid red grape variety with dark fruit flavors, commonly grown in North America"),
                WineSort(title: "Bonarda", value: "bonarda", description: "A red grape variety grown in Argentina and Italy, producing fruity and medium-bodied wines"),
                WineSort(title: "Cabernet Franc", value: "cabernet_franc", description: "A red grape variety used in Bordeaux blends, known for its herbaceous flavors"),
                WineSort(title: "Bairrada", value: "bairrada", description: "A Portuguese red wine region known for its full-bodied and tannic wines"),
                WineSort(title: "Barbera Wine", value: "barbera_wine", description: "An Italian red grape variety producing wines with high acidity and flavors of dark fruits"),
                WineSort(title: "Primitivo", value: "primitivo", description: "An Italian red grape variety known for its rich and jammy wines, similar to Zinfandel"),
                WineSort(title: "Pinot Noir", value: "pinot_noir", description: "A red grape variety producing elegant and complex wines"),
                WineSort(title: "Nebbiolo", value: "nebbiolo", description: "An Italian red grape variety used in prestigious wines like Barolo and Barbaresco"),
                WineSort(title: "Dolcetto", value: "dolcetto", description: "An Italian red grape variety known for its soft and fruity wines"),
                WineSort(title: "Tannat", value: "tannat", description: "A red grape variety originating from South West France, producing robust and tannic wines"),
                WineSort(title: "Negroamaro", value: "negroamaro", description: "A red grape variety from Southern Italy, known for its dark and rich wines"),
                WineSort(title: "Red Burgundy", value: "red_burgundy", description: "High-quality Pinot Noir wines from Burgundy, France"),
                WineSort(title: "Corvina", value: "corvina", description: "An Italian red grape variety used in the production of Amarone and Valpolicella wines"),
                WineSort(title: "Rioja", value: "rioja", description: "Red wines from the Rioja region in Spain, often made from Tempranillo grapes"),
                WineSort(title: "Cotes du Rhone", value: "cotes_du_rhone", description: "Red wines from the Rhône Valley in France, known for their rich and spicy character"),
                WineSort(title: "Grenache", value: "grenache", description: "A red grape variety used in blends, producing wines with fruity and spicy flavors"),
                WineSort(title: "Malbec", value: "malbec", description: "A red grape variety known for its inky color and bold flavors, especially in Argentine wines"),
                WineSort(title: "Zinfandel", value: "zinfandel", description: "A red grape variety known for its fruity and jammy wines, particularly in California"),
                WineSort(title: "Sangiovese", value: "sangiovese", description: "An Italian red grape variety used in Chianti and Brunello wines"),
                WineSort(title: "Carignan", value: "carignan", description: "A red grape variety known for its deep color and high tannins, often used in blends"),
                WineSort(title: "Carmenere", value: "carmenere", description: "A red grape variety originally from Bordeaux, now mainly grown in Chile, producing rich and spicy wines"),
                WineSort(title: "Cesanese", value: "cesanese", description: "An Italian red grape variety used in the production of Lazio region wines"),
                WineSort(title: "Cabernet Sauvignon", value: "cabernet_sauvignon", description: "A widely planted red grape variety known for its bold and age-worthy wines"),
                WineSort(title: "Aglianico", value: "aglianico", description: "An Italian red grape variety producing powerful and tannic wines, mainly in Southern Italy"),
                WineSort(title: "Tempranillo", value: "tempranillo", description: "A Spanish red grape variety used in the production of Rioja and Ribera del Duero wines"),
                WineSort(title: "Shiraz", value: "shiraz", description: "A red grape variety known as Syrah in many parts of the world, producing full-bodied and spicy wines"),
                WineSort(title: "Mourvedre", value: "mourvedre", description: "A red grape variety often used in blends, known for its dark and tannic wines"),
                WineSort(title: "Merlot", value: "merlot", description: "A red grape variety known for its soft and approachable wines with flavors of black fruits"),
                WineSort(title: "Nero d'Avola", value: "nero_d_avola", description: "An Italian red grape variety from Sicily, producing rich and full-bodied wines"),
                WineSort(title: "Bordeaux", value: "bordeaux", description: "Red wines from the Bordeaux region in France, typically blends of Cabernet Sauvignon, Merlot, and other grape varieties"),
                WineSort(title: "Marsala", value: "marsala", description: " A fortified wine from Sicily, often used in cooking or enjoyed as an apéritif or dessert wine"),
                WineSort(title: "Port", value: "port", description: "A fortified wine from Portugal, typically sweet and enjoyed as a dessert wine"),
                WineSort(title: "Gamay", value: "gamay", description: "A red grape variety known for producing light-bodied red wines, particularly in Beaujolais, France"),
                WineSort(title: "Dornfelder", value: "dornfelder", description: " A German red grape variety producing medium-bodied wines with dark fruit flavors"),
                WineSort(title: "Concord wine", value: "concord_wine", description: "A sweet red wine made from Concord grapes, commonly used in grape juice and jelly production"),
                WineSort(title: "Sparkling Red Wine", value: "sparkling_red_wine", description: "A type of red wine with effervescence, offering a lively and refreshing character"),
                WineSort(title: "Pinotage", value: "pinotage", description: "A red grape variety created in South Africa, known for its smoky and earthy flavors"),
                WineSort(title: "Agiorgitiko", value: "agiorgitiko", description: "A red grape variety from Greece, producing medium-bodied wines with red fruit aromas")
            ]
        case .otherWines:
            return [
                WineSort(title: "Dessert Wine", value: "dessert_wine", description: "Sweet wines typically enjoyed with or as a dessert"),
                WineSort(title: "Pedro Ximenez", value: "pedro_ximenez", description: "A Spanish grape variety used to produce rich and sweet dessert wines"),
                WineSort(title: "Moscato", value: "moscato", description: "A sweet and aromatic white grape variety used in the production of dessert wines"),
                WineSort(title: "Late Harvest", value: "late_harvest", description: "Wines made from grapes left on the vine longer to concentrate sugars and flavors"),
                WineSort(title: "Ice Wine", value: "ice_wine", description: "A dessert wine made from grapes frozen on the vine, resulting in a concentrated and sweet flavor"),
                WineSort(title: "White Port", value: "white_port", description: "A fortified wine from Portugal, typically enjoyed as an apéritif or dessert wine"),
                WineSort(title: "Lambrusco Dolce", value: "lambrusco_dolce", description: "A sweet and fizzy red wine from the Emilia-Romagna region in Italy"),
                WineSort(title: "Madeira", value: "madeira", description: "A fortified wine from the Portuguese island of Madeira, known for its caramelized flavors"),
                WineSort(title: "Banyuls", value: "banyuls", description: " A sweet fortified wine from the Banyuls region of France, made from Grenache grapes"),
                WineSort(title: "Vin Santo", value: "vin_santo", description: "An Italian dessert wine made from dried grapes, often enjoyed with biscotti"),
                WineSort(title: "Port", value: "port", description: "A Portuguese fortified wine produced in the Douro Valley of northern Portugal"),
                WineSort(title: "Rose wine", value: "rose_wine", description: "A type of wine with a pink color, made from red grapes with limited skin contact"),
                WineSort(title: "Sparkling Rose", value: "sparkling_rose", description: "Rosé wine with effervescence, offering a lively and refreshing character"),
                WineSort(title: "Sparkling Wine", value: "sparkling_wine", description: "A wine with bubbles, often enjoyed as a celebratory or festive beverage"),
                WineSort(title: "Cava", value: "cava", description: "A sparkling wine produced in Spain using the traditional method"),
                WineSort(title: "Cremant", value: "cremant", description: "A sparkling wine produced in France using the traditional method but outside the Champagne region"),
                WineSort(title: "Champagne", value: "champagne", description: "A sparkling wine produced exclusively in the Champagne region of France"),
                WineSort(title: "Prosecco", value: "prosecco", description: "An Italian sparkling wine, typically light and fruity"),
                WineSort(title: "Spumante", value: "spumante", description: "An Italian sparkling wine with a range of sweetness levels"),
                WineSort(title: "Sherry", value: "sherry", description: "A fortified wine from the Andalusia region in Spain, available in both sweet and dry styles"),
                WineSort(title: "Cream Sherry", value: "cream_sherry", description: "A sweet style of Sherry with a rich and smooth flavor"),
                WineSort(title: "Dry Sherry", value: "dry_sherry", description: "A dry style of Sherry, often enjoyed as an apéritif"),
                WineSort(title: "Vermouth", value: "vermouth", description: "An aromatized and fortified wine flavored with various botanicals"),
                WineSort(title: "Dry Vermouth", value: "dry_vermouth", description: "A style of Vermouth with a drier taste profile"),
                WineSort(title: "Fruit Wine", value: "fruit_wine", description: "Wine made from fermented fruits other than grapes"),
                WineSort(title: "Mead", value: "mead", description: "An alcoholic beverage made from fermented honey and water, often flavored with fruits, spices, or herbs")
            ]
        }
    }
}
struct WineSortSection: Section {
    let numberOfItems: Int
    let wines: [WineSort]
    
    init(type: WineSortSectionType) {
        self.wines = type.wines
        self.numberOfItems = type.wines.count
    }
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.25)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.92),
            heightDimension: .fractionalHeight(0.4)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 4)

        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(44)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 20, trailing: 10)
        section.orthogonalScrollingBehavior = .groupPagingCentered

        return section
    }
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WineSortCell.reuseIdentifier,
            for: indexPath
        ) as? WineSortCell else {
            fatalError("error")
        }
        let wine = wines[indexPath.item]
        cell.configureCell(title: wine.title, description: wine.description)
        return cell
    }
    
    func getItemCount() -> Int {
        return numberOfItems
    }
}

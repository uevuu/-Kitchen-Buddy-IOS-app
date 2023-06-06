//
//  FilterModuleOutput.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 02.06.2023.
//

protocol FilterModuleOutput: AnyObject {
    func viewDidPop(animated: Bool, completion: (() -> Void)?)
    func moduleDidUnload()
    func showSelectableSetting(_ type: SelectableSettingType)
}

enum SelectableSettingType {
    case diet
    case meal
    case cusine
    case intolerance
}

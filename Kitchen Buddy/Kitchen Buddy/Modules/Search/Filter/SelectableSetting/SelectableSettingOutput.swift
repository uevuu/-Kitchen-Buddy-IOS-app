//
//  SelectableSettingOutput.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 04.06.2023.
//

protocol SelectableSettingOutput: AnyObject {
    func viewDidPop(animated: Bool, completion: (() -> Void)?)
    func moduleDidUnload()
}

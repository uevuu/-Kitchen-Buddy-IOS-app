//
//  WinesModuleOutput.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 01.05.2023.
//

protocol WinesModuleOutput: AnyObject {
    func viewDidPop(animated: Bool, completion: (() -> Void)?)
    func moduleDidUnload()
}

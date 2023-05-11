//
//  WinesViewModel.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 01.05.2023.
//

import Swinject

class WinesViewModel {
    private let output: WinesModuleOutput?
    private let networkService: NetworkService
    
    init(networkService: NetworkService, output: WinesModuleOutput?) {
        self.networkService = networkService
        self.output = output
    }
    
    func showWineInfo() {
        output?.showWineInfo()
    }
    
    func tapOnBackButton() {
        output?.goToPreviousModule(animated: true, completion: nil)
    }
    
    func controllerWasDeinit() {
        output?.moduleDidUnload()
    }
}

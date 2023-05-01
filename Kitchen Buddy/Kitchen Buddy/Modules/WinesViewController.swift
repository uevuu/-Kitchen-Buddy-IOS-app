//
//  WinesViewController.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 01.05.2023.
//

import UIKit

final class WinesViewController: UIViewController {
    private var viewModel: WinesViewModel
            
    private var wineButton: UIButton {
        let button = UIButton()
        button.frame = CGRect(x: 60, y: 120, width: 200, height: 50)
        button.setTitle("Go to Wine Info", for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(wineButtonTapped), for: .touchUpInside)
        return button
    }
    
    init(viewModel: WinesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(wineButton)
    }
        
    @objc func wineButtonTapped() {
        viewModel.showWineInfo()
    }
}

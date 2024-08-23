//
//  ViewController.swift
//  iOS Exmaple
//
//  Created by Apple on 22/08/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func handleButtonTapped(_ sender: UIButton) {
        let viewModel = ViewModel(withDataProvider: DataDummyProvider())
        let dataVC = storyboard?.instantiateViewController(identifier: "dataVC", creator: { coder in
            DataViewController(coder: coder, withViewModel: viewModel)
        })
        guard let dataVC else { return }
        navigationController?.pushViewController(dataVC, animated: true)
    }

}


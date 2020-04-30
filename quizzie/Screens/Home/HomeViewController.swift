//
//  HomeViewController.swift
//  quizzie
//
//  Created Ensar Baba on 30.04.2020.
//  Copyright © 2020 Ensar Baba. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, HomeViewProtocol {

	var presenter: HomePresenterProtocol!

	override func viewDidLoad() {
        super.viewDidLoad()

        presenter.view = self
        presenter.fetchData()
        setupUI()
    }

    func setupUI() {
        print("setup ui")
    }
}

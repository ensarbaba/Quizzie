//
//  HomeBuilder.swift
//  quizzie
//
//  Created by Ensar Baba on 2.05.2020.
//  Copyright © 2020 Ensar Baba. All rights reserved.
//

import Foundation

class HomeBuilder {
    class func build() -> HomeViewController {
        let view = HomeViewController()
        let presenter = HomePresenter(view: view)
        view.presenter = presenter
        return view
    }
}

//
//  FinalBuilder.swift
//  quizzie
//
//  Created by Ensar Baba on 2.05.2020.
//  Copyright © 2020 Ensar Baba. All rights reserved.
//

import Foundation

class FinalBuilder {
    class func buildWith(quizStatus: QuizStatusData) -> FinalViewController {
        let view = FinalViewController()
        let presenter = FinalPresenter(view: view, quizStatus: quizStatus)
        view.presenter = presenter
        return view
    }
}

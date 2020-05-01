//
//  HomePresenter.swift
//  quizzie
//
//  Created Ensar Baba on 30.04.2020.
//  Copyright © 2020 Ensar Baba. All rights reserved.
//
//  Template generated by Edward
//

import Foundation

// MARK: View -
protocol HomeViewProtocol: LoadDataView {
    func didFetchQuestions(quizResponse: QuizResponse)
    func didErrorOccur(error: AlertMessage)
}

// MARK: Presenter -
protocol HomePresenterProtocol: class {
	var view: HomeViewProtocol? { get set }
    var quizStatus: QuizStatusData { get set }
    func fetchQuestions()
}

class HomePresenter: HomePresenterProtocol {

    weak var view: HomeViewProtocol?
    public var quizStatus = QuizStatusData()
    private var quizQuestions: QuizResponse?
    
    init(view: HomeViewProtocol) {
        self.view = view
    }
    
    func fetchQuestions() {
        view?.startLoading()
        APIManager.shared().call(type: RequestItemsType.questions(count: "12")) { (questions: (QuizResponse)?, message: AlertMessage?) in
            if let questions = questions {
                self.quizQuestions = questions
                self.view?.didFetchQuestions(quizResponse: questions)
            } else {
                self.view?.didErrorOccur(error: message ?? AlertMessage(title: "Alert", body: "Something went wrong"))
            }
            self.view?.stopLoading()
        }
    }
    
}

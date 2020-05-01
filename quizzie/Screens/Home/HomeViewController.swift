//
//  HomeViewController.swift
//  quizzie
//
//  Created Ensar Baba on 30.04.2020.
//  Copyright © 2020 Ensar Baba. All rights reserved.
//

import UIKit

enum QuizSections: Int, CaseIterable {
    case status = 0
    case question
    case option
}

class HomeViewController: BaseViewController {
    
    var presenter: HomePresenterProtocol!
    
    lazy var quizTableView: UITableView = {
        let tv = UITableView()
//        tv.delegate = self
//        tv.dataSource = self
        tv.isHidden = true
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 100
        tv.tableFooterView = UIView()
        tv.separatorInset = UIEdgeInsets.small_LR
        tv.register(cellType: StatusCell.self)
        tv.register(cellType: QuestionCell.self)
        tv.register(cellType: OptionCell.self)
        return tv
    }()
    
    lazy var startQuizButton: UIButton = {
        let button = UIButton()
        button.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 150, height: 50))
        }
        button.setTitle("Start Quiz", for: .normal)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(startQuiz), for: .touchUpInside)
        return button
    }()
    
    @objc func startQuiz() {
        setupTableView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.fetchQuestions()
    }
    private func setupUI() {
        self.view.addSubview(startQuizButton)
        startQuizButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    private func setupTableView() {
        quizTableView.isHidden = false
        self.view.addSubview(quizTableView)
        self.view.bringSubviewToFront(quizTableView)
        
        quizTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension HomeViewController: HomeViewProtocol {
    func didErrorOccur(error: AlertMessage) {
        
    }
    
    func didFetchQuestions(quizResponse: QuizResponse) {
        setupUI()
    }
    
}
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return QuizSections.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = QuizSections(rawValue: section) else { return 1 }

          switch section {
          case .status:
            return presenter.quizStatusCount
          case .question:
            return 1
          case .option:
            return 1
          }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension HomeViewController: UITableViewDelegate {
    
}

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
        tv.delegate = self
        tv.dataSource = self
        tv.isHidden = true
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 100
        tv.tableFooterView = UIView()
        tv.separatorInset = UIEdgeInsets.small_LR
        tv.alwaysBounceVertical = false
        
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
            return 1
        case .question:
            return 1
        case .option:
            //Normally this count should be come from API but they mixed up the options and I can't get the option count properly
            return 4
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = QuizSections(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .status:
            let cell: StatusCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configureCell(statusData: presenter.quizStatus)
            return cell
            
        case .question:
            let cell: QuestionCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configureCell(questionTitle: presenter.currentQuestionData().question ?? "")
            return cell
            
        case .option:
            let cell: OptionCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configureCell(option: presenter.currentOption(index: indexPath.row), index: indexPath.row)
            return cell
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.modifyDataSourceWith(selectedIndex: indexPath.row)
        self.quizTableView.isUserInteractionEnabled = false
        self.quizTableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.presenter.quizStatus.currentQuestionNo += 1
            self.presenter.shuffledOptions.removeAll()
            self.quizTableView.isUserInteractionEnabled = true
            self.quizTableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = QuizSections(rawValue: indexPath.section) else { return 50 }
        
        switch section {
        case .status:
            return 80
        case .question:
            return UITableView.automaticDimension
        case .option:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 15))
        view.backgroundColor = .clear
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15.0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = QuizSections(rawValue: section) else { return "" }
        switch section {
        case .status:
            return ""
        case .question:
            return "Question"
        case .option:
            return "Answers"
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = QuizSections(rawValue: section) else { return 0 }
        switch section {
        case .status:
            return 0
        case .question:
            return 40
        case .option:
            return 40
        }
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textAlignment = NSTextAlignment.center
    }
    
}

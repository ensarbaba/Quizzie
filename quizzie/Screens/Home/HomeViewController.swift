//
//  HomeViewController.swift
//  quizzie
//
//  Created Ensar Baba on 30.04.2020.
//  Copyright © 2020 Ensar Baba. All rights reserved.
//

import UIKit
//New changes
enum QuizSections: Int, CaseIterable {
    case status = 0
    case question
    case option
    
    var numberOfRows: Int {
        switch self {
        case .status:
            return 1
        case .question:
            return 1
        case .option:
            //Normally this count should come from API but they mixed up the options and I can't get the option count properly
            return 4
        }
    }
    
    var rowHeight: CGFloat {
        switch self {
        case .status:
            return 80
        default:
            return 50
        }
    }
    var headerHeight: CGFloat {
        switch self {
        case .status:
            return 0
        case .question, .option:
            return 40
        }
    }
    
    var headerTitle: String {
        switch self {
        case .status:
            return ""
        case .question:
            return "Question"
        case .option:
            return "Option"
        }
    }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.fetchQuestions()
    }
    
    @objc func startQuiz() {
        setupTableView()
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
    func shouldProceedToNextQuestion() {
        self.quizTableView.isUserInteractionEnabled = true
        self.quizTableView.reloadData()
    }
    
    func shouldEndQuiz() {
        Alert.showBasicActionAlert(on: self, with: "Game Over", message: "You had no wildcards, quiz ended") { _ in
            self.navigationController?.pushViewController(FinalBuilder.buildWith(quizStatus: self.presenter.quizStatus), animated: true)
        }
    }
    
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
        return section.numberOfRows
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
            self.presenter.setPointAndWildCardCountForUser(index: indexPath.row)
            self.presenter.checkNextQuestionAvailable()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = QuizSections(rawValue: indexPath.section) else { return 50 }
        
        switch section {
        case .status:
            return section.rowHeight
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
        return section.headerTitle
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = QuizSections(rawValue: section) else { return 0 }
        return section.headerHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textAlignment = NSTextAlignment.center
    }
    
}

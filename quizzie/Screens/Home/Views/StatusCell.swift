//
//  StatusCell.swift
//  quizzie
//
//  Created by Ensar Baba on 30.04.2020.
//  Copyright © 2020 Ensar Baba. All rights reserved.
//

import UIKit

class StatusCell: BaseTableViewCell {
    
    private lazy var questionStatusView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var questionTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
//        label.font = UIFont.init(name: <#T##String#>, size: <#T##CGFloat#>)
        return label
    }()
    
    private lazy var questionNumberLabel: UILabel = {
        let label = UILabel()
                label.textColor = .black
        return label
    }()
    
    private lazy var wildCardStatusView: UIView = {
        let label = UILabel()
                label.textColor = .black
        return label
    }()
    
    private lazy var wildCardTitleLabel: UILabel = {
        let label = UILabel()
                label.textColor = .black
        return label
    }()
    
    private lazy var wildCardCountLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func commonInit() {
        super.commonInit()
        selectionStyle = .none
        
        // MARK: Setup cell components
        self.contentView.addSubview(questionStatusView)
        self.questionStatusView.addSubview(questionTitleLabel)
        self.questionStatusView.addSubview(questionNumberLabel)
        
        self.contentView.addSubview(wildCardStatusView)
        self.wildCardStatusView.addSubview(wildCardTitleLabel)
        self.wildCardStatusView.addSubview(wildCardCountLabel)
        
        // MARK: Set components constraints
        questionStatusView.snp.makeConstraints {
            $0.left.top.bottom.edges.equalToSuperview()
            $0.trailing.equalTo(wildCardStatusView.snp.leading)
            $0.width.equalTo(wildCardStatusView.snp.width)
        }
        wildCardStatusView.snp.makeConstraints {
            $0.right.top.bottom.edges.equalToSuperview()
            $0.leading.equalTo(questionStatusView.snp.trailing)
            $0.width.equalTo(questionStatusView.snp.width)
        }
        questionTitleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview()
            $0.height.equalTo(30)
        }
        questionNumberLabel.snp.makeConstraints {
            $0.top.equalTo(questionTitleLabel.snp.bottom).offset(15)
            $0.left.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview().offset(-15)
            $0.height.equalTo(30)
        }
    }
    
    public func configureCell(statusData: QuizStatusData) {
        self.questionTitleLabel.text = statusData.questionMockTitle
        self.questionNumberLabel.text = String(statusData.questionCount)
        self.wildCardTitleLabel.text = statusData.jokerMockTitle
        self.wildCardCountLabel.text = String(statusData.jokerCount)
    }
    
}

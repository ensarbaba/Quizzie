//
//  StatusCell.swift
//  quizzie
//
//  Created by Ensar Baba on 30.04.2020.
//  Copyright © 2020 Ensar Baba. All rights reserved.
//

import UIKit

class StatusCell: BaseTableViewCell {
    
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var wildCardTitleLabel: UILabel!
    @IBOutlet weak var wildCardCountLabel: UILabel!
    
    override func commonInit() {
        super.commonInit()
        self.isUserInteractionEnabled = false
    }
    
    public func configureCell(statusData: QuizStatusData) {
        self.questionTitleLabel.text = statusData.questionMockTitle
        self.questionNumberLabel.text = String(format: "%d / %d", statusData.currentQuestionNo, statusData.questionCount)
        self.wildCardTitleLabel.text = statusData.wildCardMockTitle
        self.wildCardCountLabel.text = String((statusData.wildCardCount))
    }
    
}

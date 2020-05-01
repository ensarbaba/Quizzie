//
//  QuestionCell.swift
//  quizzie
//
//  Created by Ensar Baba on 1.05.2020.
//  Copyright © 2020 Ensar Baba. All rights reserved.
//

import UIKit

class QuestionCell: BaseTableViewCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func commonInit() {
          super.commonInit()
        self.isUserInteractionEnabled = false
    }
    
    public func configureCell(questionTitle: String) {
        self.questionLabel.text = questionTitle
    }
}

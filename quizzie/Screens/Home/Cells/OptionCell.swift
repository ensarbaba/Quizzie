//
//  OptionCell.swift
//  quizzie
//
//  Created by Ensar Baba on 1.05.2020.
//  Copyright © 2020 Ensar Baba. All rights reserved.
//

import UIKit

class OptionCell: BaseTableViewCell {
    
    @IBOutlet weak var optionLabel: UILabel!

    private var optionLetters = ["a", "b", "c", "d"]
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func commonInit() {
        super.commonInit()
        self.isUserInteractionEnabled = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configureCell(option: Option, index: Int) {
        self.optionLabel.text = String(format: "%@) %@", optionLetters[index], option.optionTitle.htmlAttributedString!.string)
        self.contentView.backgroundColor = option.optionBackground
    }

}

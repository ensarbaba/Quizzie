//
//  String.swift
//  quizzie
//
//  Created by Ensar Baba on 2.05.2020.
//  Copyright © 2020 Ensar Baba. All rights reserved.
//

import Foundation
extension String {

    var htmlAttributedString: NSAttributedString? {
        return try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
}

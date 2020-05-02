//
//  Alert.swift
//  quizzie
//
//  Created by Ensar Baba on 2.05.2020.
//  Copyright © 2020 Ensar Baba. All rights reserved.
//

import UIKit

struct Alert {
    
    static public func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alertController, animated: true, completion: nil) }
    }
    static public func showBasicActionAlert(on vc: UIViewController, with title: String, message: String, actionHandler: ((UIAlertAction) -> Void)?) {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: actionHandler))
           DispatchQueue.main.async { vc.present(alertController, animated: true, completion: nil) }
       }
}

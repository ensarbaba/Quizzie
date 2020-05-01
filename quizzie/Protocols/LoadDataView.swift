//
//  LoadDataView.swift
//  quizzie
//
//  Created by Ensar Baba on 1.05.2020.
//  Copyright © 2020 Ensar Baba. All rights reserved.
//

import SVProgressHUD

protocol LoadDataView: class {
    func startLoading()
    func startLoading(message: String?)
    func stopLoading()
}

extension LoadDataView {
    
    func startLoading(message: String?) {
        if SVProgressHUD.isVisible() { return }
        UIApplication.shared.beginIgnoringInteractionEvents()
    
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setBackgroundColor(.orange)
        SVProgressHUD.setRingThickness(3)
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.show(withStatus: message)
    }
    
    func startLoading() {
        startLoading(message: nil)
    }
    
    func stopLoading() {
        if UIApplication.shared.isIgnoringInteractionEvents {
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        if !SVProgressHUD.isVisible() { return }
        SVProgressHUD.dismissOnMain()
    }
}

extension SVProgressHUD {
    public static func dismissOnMain() {
        DispatchQueue.main.async { SVProgressHUD.dismiss() }
    }
}

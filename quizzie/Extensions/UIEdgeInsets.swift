//
//  UIEdgeInsets.swift
//  quizzie
//
//  Created by Ensar Baba on 30.04.2020.
//  Copyright © 2020 Ensar Baba. All rights reserved.
//
import UIKit

// Predefined Spacings
public enum Spacing {
    /// Tiny 8
    public static let tiny: CGFloat = 8
    /// Small 16
    public static let small: CGFloat = 16
    /// Base 24
    public static let base: CGFloat = 24
    /// Large 48
    public static let large: CGFloat = 48
    /// XLarge 64
    public static let xlarge: CGFloat = 64
}

extension UIEdgeInsets {
    public static let small_LR = UIEdgeInsets(top: 0, left: Spacing.small, bottom: 0, right: Spacing.small)
    public static let small_LRTB = UIEdgeInsets(top: Spacing.small, left: Spacing.small, bottom: Spacing.small, right: Spacing.small)
    public static let tiny_LRTB = UIEdgeInsets(top: Spacing.tiny, left: Spacing.tiny, bottom: Spacing.tiny, right: Spacing.tiny)
    public static let tiny_LR = UIEdgeInsets(top: 0, left: Spacing.tiny, bottom: 0, right: Spacing.tiny)
}

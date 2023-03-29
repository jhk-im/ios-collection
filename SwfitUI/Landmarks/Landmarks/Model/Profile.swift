//
//  Profile.swift
//  Landmarks
//
//  Created by HUN on 2023/03/28.
//

// MARK: -
/*
 static let `default`
 - ProfileEditor(profile: .constant(.default))에서 .default처럼 어디에서는 접근 가능

 */

import Foundation

struct Profile {
    var username: String
    var prefersNotifications = true
    var seasonalPhoto = Season.winter
    var goalDate = Date()

    static let `default` = Profile(username: "jhk")

    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"

        var id: String { rawValue }
    }
}

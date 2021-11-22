//
//  TableKeys.swift
//  03_FacebookMe
//
//  Created by rae on 2021/11/21.
//

import Foundation

struct TableKeys {
    static let Section = "section"
    static let Rows = "rows"
    static let ImageName = "imageName"
    static let Title = "title"
    static let SubTitle = "subTitle"
    static let seeMore = "See More..."
    static let addFavorites = "Add Favorites..."
    static let logOut = "Log Out"
    
    static let testData: [[String:Any]] = [
        [
            TableKeys.Rows: [
                [TableKeys.ImageName: "bayMax", TableKeys.Title: "BayMax", TableKeys.SubTitle: "View your profile"]
            ]
        ],
        [
            TableKeys.Rows: [
                [TableKeys.ImageName: "fb_friends", TableKeys.Title: "Friends"],
                [TableKeys.ImageName: "fb_events", TableKeys.Title: "Events"],
                [TableKeys.ImageName: "fb_groups", TableKeys.Title: "Groups"],
                [TableKeys.ImageName: "fb_education", TableKeys.Title: "Education"],
                [TableKeys.ImageName: "fb_town_hall", TableKeys.Title: "Town Hall"],
                [TableKeys.ImageName: "fb_games", TableKeys.Title: "Instant Games"],
                [TableKeys.ImageName: "fb_placeholder", TableKeys.Title: TableKeys.seeMore],
            ]
        ],
        [
            TableKeys.Section: "FAVORITES",
            TableKeys.Rows: [
                [TableKeys.ImageName: "fb_placeholder",TableKeys.Title: TableKeys.addFavorites]
            ]
        ],
        [
            TableKeys.Rows: [
                [TableKeys.ImageName: "fb_settings", TableKeys.Title: "Settings"],
                [TableKeys.ImageName: "fb_privacy_shortcuts", TableKeys.Title: "Privacy Shortcuts"],
                [TableKeys.ImageName: "fb_help_and_support", TableKeys.Title: "Help and Support"]
            ]
        ],
        [
            TableKeys.Rows: [
                [TableKeys.Title: TableKeys.logOut]
            ]
        ]
    ]
}

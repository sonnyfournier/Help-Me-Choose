//
//  Localization.swift
//  Help Me Choose
//
//  Created by Sonny on 31/12/2021.
//

import Foundation

func localizedString(for key: String, tableName: String? = nil, comment: String = "") -> String {
    return NSLocalizedString(key, tableName: tableName, comment: comment)
}

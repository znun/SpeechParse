//
//  Model.swift
//  SpeechParse
//
//  Created by Mahmudul Hasan on 10/1/24.
//

import Foundation

struct Result: Identifiable {
    var id = UUID()
    var word: String
    var partOfSpeech: String
}

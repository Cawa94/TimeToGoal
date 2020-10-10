//
//  String+Extensions.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 10/10/2020.
//

import Foundation

extension String {

    func localized() -> String {
        return Bundle.main.localizedString(forKey: self, value: nil, table: nil)
    }

    func localizedWithSpecific(language: String) -> String {
        let language = language
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"), let bundle = Bundle(path: path)
            else { return self.localized() }
        return bundle.localizedString(forKey: self, value: nil, table: nil)
    }

}

//
//  Dictionary+Extensions.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 30/10/2020.
//

import Foundation

extension Dictionary {

    func merged(with second: [Key: Value]) -> [Key: Value] {
        var result = self
        for field in second {
            result[field.key] = field.value
        }
        return result
    }

}

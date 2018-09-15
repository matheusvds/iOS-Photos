//
//  Result.swift
//  BlendleiOSAssignment
//
//  Created by Matheus Vasconcelos on 15/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

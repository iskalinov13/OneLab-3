//
//  ConfigurableCell.swift
//  OneLab-3
//
//  Created by Farukh Iskalinov on 16.07.20.
//  Copyright © 2020 Farukh Iskalinov. All rights reserved.
//

import Foundation

protocol ConfigurableCell {
    associatedtype DataType
    func configure(data: DataType)
}

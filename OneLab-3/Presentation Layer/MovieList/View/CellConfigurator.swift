//
//  CellConfigurator.swift
//  OneLab-3
//
//  Created by Farukh Iskalinov on 16.07.20.
//  Copyright © 2020 Farukh Iskalinov. All rights reserved.
//

import UIKit

protocol CellConfigurator {
    static var reuseId: String { get }
    func configure(cell: UIView)
}

//CellType, DataType - Generics

class TableCellConfigurator<CellType: ConfigurableCell, DataType>: CellConfigurator where CellType.DataType == DataType, CellType: UITableViewCell {
    
    static var reuseId: String { return String(describing: CellType.self) }
    
    let item: DataType
    
    init(item: DataType) {
        self.item = item
    }
    
    func configure(cell: UIView) {
        (cell as! CellType).configure(data: item)
    }
}

//
//  ImageTableViewCell.swift
//  OneLab-3
//
//  Created by Farukh Iskalinov on 16.07.20.
//  Copyright © 2020 Farukh Iskalinov. All rights reserved.
//

import UIKit

typealias ImageCellConfigurator = TableCellConfigurator<ImageTableViewCell, UIImage>

class ImageTableViewCell: UITableViewCell, ConfigurableCell {
    typealias DataType = UIImage
    
    private let movieImageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        addSubview(movieImageView)
        movieImageView.snp.makeConstraints { (make) in
            make.size.equalTo(UIScreen.main.bounds.height / 2)
            make.edges.equalToSuperview().inset(10)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data image: UIImage) {
        movieImageView.image = image
    }
}

//
//  TitleTableViewCell.swift
//  OneLab-3
//
//  Created by Farukh Iskalinov on 16.07.20.
//  Copyright © 2020 Farukh Iskalinov. All rights reserved.
//

import UIKit
import UICircularProgressRing

extension UIColor {
    static let innerGreen = #colorLiteral(red: 0.1371958554, green: 0.8152719736, blue: 0.4784690142, alpha: 1)
    static let outerGreen = #colorLiteral(red: 0.1235490516, green: 0.2713127136, blue: 0.1626237929, alpha: 1)
    static let innerYellow = #colorLiteral(red: 0.8263435364, green: 0.8368340135, blue: 0.188344121, alpha: 1)
    static let outerYellow = #colorLiteral(red: 0.2613945007, green: 0.2400574386, blue: 0.06335037202, alpha: 1)
    static let innerRed = #colorLiteral(red: 0.8590859175, green: 0.1381891966, blue: 0.3759087324, alpha: 1)
    static let outerRed = #colorLiteral(red: 0.3414548039, green: 0.0788866207, blue: 0.2070862949, alpha: 1)
}

typealias InfoCellConfigurator = TableCellConfigurator<InfoTableViewCell, Movie>

class InfoTableViewCell: UITableViewCell, ConfigurableCell {
    
    typealias DataType = Movie
    
    private let voteAvergageProgressRing : UICircularProgressRing = {
        let progress = UICircularProgressRing()
        progress.maxValue = 100
        progress.style = .inside
        progress.font = .systemFont(ofSize: 20, weight: .bold)
        progress.fontColor = .black
        return progress
    }()
    
    private let movieTitleLabel: UILabel =  {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private let movieReleaseDateLabel: UILabel =  {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "info.circle.fill"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.01287723985, green: 0.1454687715, blue: 0.255453229, alpha: 1)
        return button
    }()
    
    private lazy var stackViewLabels: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieTitleLabel, movieReleaseDateLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var stackViewMain: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [voteAvergageProgressRing, stackViewLabels, infoButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(stackViewMain)
        stackViewMain.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
        
        voteAvergageProgressRing.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(voteAvergageProgressRing.snp.width)
        }
        
        infoButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.1)
            make.height.equalTo(infoButton.snp.width)        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: Movie) {
        movieTitleLabel.text = data.title
        movieReleaseDateLabel.text = data.releaseDate
        voteAvergageProgressRing.value = CGFloat(data.voteAverage * 10)
        
        switch data.voteAverage {
        case 0.0 ..< 5.0:
            voteAvergageProgressRing.innerRingColor = UIColor.innerRed
            voteAvergageProgressRing.outerRingColor = UIColor.outerRed
        case 5.0 ..< 7.0:
            voteAvergageProgressRing.innerRingColor = UIColor.innerYellow
            voteAvergageProgressRing.outerRingColor = UIColor.outerYellow
        case 7.0 ..< 10.0:
            voteAvergageProgressRing.innerRingColor = UIColor.innerGreen
            voteAvergageProgressRing.outerRingColor = UIColor.outerGreen
        default:
            voteAvergageProgressRing.innerRingColor = UIColor.innerGreen
            voteAvergageProgressRing.outerRingColor = UIColor.outerGreen
        }
    }
}

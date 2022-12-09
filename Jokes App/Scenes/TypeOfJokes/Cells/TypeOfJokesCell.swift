//
//  TypeOfJokesCell.swift
//  Jokes App
//
//  Created by Aibek on 14.10.2022.
//

import UIKit
import SnapKit

class TypeOfJokesCell: UITableViewCell {
    
    private lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
        label.textColor = .customGray
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubviews()
        setUpConstraints()
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = .zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews() {
        self.addSubview(cellImageView)
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
    }
    
    private func setUpConstraints() {
        cellImageView.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().offset(18)
            maker.height.equalTo(30)
            maker.width.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.leading.equalTo(cellImageView.snp.trailing).offset(13)
        }
        
        descriptionLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(titleLabel)
            maker.topMargin.equalTo(titleLabel).offset(15)
        }
        }
    
    
    func updateUI(model: TypeOfJokesModel) {
        
        cellImageView.image = UIImage(named: model.imageName )
        titleLabel.text = model.title
        
    }
}


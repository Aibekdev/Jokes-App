//
//  TypeOfJokesHeaderView.swift
//  Jokes App
//
//  Created by Aibek on 14.10.2022.
//

import UIKit
import SnapKit

class TypeOfJokesHeaderView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpSubviews() {
        [titleLabel, separatorView].forEach { addSubview($0) }
    }
    
    private func setUpConstraints() {
        titleLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { maker in
            maker.left.bottom.right.equalToSuperview()
            maker.height.equalTo(0.5)
        }
    }
    
    func updateUI(model: TypeOfJokesHeaderModel) {
        titleLabel.text = model.label
    }
}

//
//  TableViewCell.swift
//  vkServices
//
//  Created by Cyril Kardash on 13.09.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    private var iconImageView = UIImageView()
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        contentView.superview?.backgroundColor = .black
        titleLabel.textColor = .white
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.numberOfLines = 2
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.layer.cornerRadius = 15
        iconImageView.layer.masksToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.frame = .init(x: 10, y: 10, width: 50, height: 50)
        titleLabel.frame = .init(x: iconImageView.frame.maxX + 10, y: 10, width: contentView.frame.width - iconImageView.frame.width - 20, height: 20)
        descriptionLabel.frame = .init(x: iconImageView.frame.maxX + 10, y: titleLabel.frame.maxY , width: contentView.frame.width - iconImageView.frame.width - 20, height: 35)
    }
    
    func configure(with service: Service) {
        iconImageView.kf.setImage(with: URL(string: service.icon_url))
        titleLabel.text = service.name
        descriptionLabel.text = service.description
    }
}


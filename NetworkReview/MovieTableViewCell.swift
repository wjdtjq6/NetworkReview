//
//  MovieTableViewCell.swift
//  NetworkReview
//
//  Created by t2023-m0032 on 6/6/24.
//

import UIKit
import SnapKit


class MovieTableViewCell: UITableViewCell {

    
    let rankingLabel = UILabel()
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(rankingLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
            
        rankingLabel.snp.makeConstraints { make in
        //    make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-10)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(40)
        }
        rankingLabel.backgroundColor = .white
        rankingLabel.textAlignment = .center
        rankingLabel.font = .boldSystemFont(ofSize: 15)
        rankingLabel.textColor = .black
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-10)
            make.leading.equalTo(rankingLabel.snp_trailingMargin).offset(30)
            make.width.equalTo(200)
        }
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 15)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-10)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-20)
            
        }
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

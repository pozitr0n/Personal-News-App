//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Raman Kozar on 26/03/2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    static let identifier = "NewsCellID"
    
    let mainImageNews: UIImageView = {
        let mainImageNews = UIImageView()
        mainImageNews.translatesAutoresizingMaskIntoConstraints = false
        mainImageNews.frame = CGRect(x: 0, y: 0, width: 100.0, height: 100.0)
        return mainImageNews
    }()
    
    let mainDateNews: UILabel = {
        let mainDateNews = UILabel(frame: CGRect(x: 0, y: 0, width: 86.0, height: 14.5))
        mainDateNews.translatesAutoresizingMaskIntoConstraints = false
        mainDateNews.font = UIFont(name: "ArialHebrew", size: 12.0)
        mainDateNews.textColor = .black
        mainDateNews.textAlignment = .right
        return mainDateNews
    }()
    
    let mainTitleNews: UILabel = {
        let mainTitleNews = UILabel(frame: CGRect(x: 0, y: 0, width: 182.0, height: 27.5))
        mainTitleNews.translatesAutoresizingMaskIntoConstraints = false
        mainTitleNews.font = UIFont(name: "ArialHebrew-Bold", size: 16.0)
        mainTitleNews.textColor = .black
        mainTitleNews.numberOfLines = 2
        mainTitleNews.textAlignment = .left
        return mainTitleNews
    }()
    
    let mainDescriptionNews: UILabel = {
        let mainDescriptionNews = UILabel(frame: CGRect(x: 0, y: 0, width: 276.0, height: 55.5))
        mainDescriptionNews.translatesAutoresizingMaskIntoConstraints = false
        mainDescriptionNews.font = UIFont(name: "ArialHebrew", size: 15.0)
        mainDescriptionNews.textColor = .black
        mainDescriptionNews.numberOfLines = 3
        mainDescriptionNews.textAlignment = .left
        return mainDescriptionNews
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        
        contentView.backgroundColor = .white
        
        contentView.addSubview(mainImageNews)
        contentView.addSubview(mainTitleNews)
        contentView.addSubview(mainDescriptionNews)
        contentView.addSubview(mainDateNews)
        
    }
    
    func configureUI() {
        
        NSLayoutConstraint.activate([
        
            mainImageNews.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            mainImageNews.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            mainImageNews.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            mainTitleNews.firstBaselineAnchor.constraint(equalTo: mainDateNews.firstBaselineAnchor),
            mainTitleNews.leadingAnchor.constraint(equalTo: mainImageNews.trailingAnchor, constant: 10.0),
            mainTitleNews.leadingAnchor.constraint(equalTo: mainDescriptionNews.leadingAnchor),
            
            mainDescriptionNews.topAnchor.constraint(equalTo: mainDateNews.bottomAnchor, constant: 30.0),
            mainDescriptionNews.topAnchor.constraint(equalTo: mainTitleNews.bottomAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: mainDescriptionNews.bottomAnchor, constant: 10.0),
            
            mainDateNews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
            mainDateNews.leadingAnchor.constraint(equalTo: mainTitleNews.trailingAnchor),
            mainDateNews.trailingAnchor.constraint(equalTo: mainDescriptionNews.trailingAnchor),
            
            mainDateNews.widthAnchor.constraint(equalToConstant: 96.0),
            mainImageNews.widthAnchor.constraint(equalToConstant: 100.0),
            mainImageNews.heightAnchor.constraint(equalToConstant: 100.0)
        
        ])
        
    }
    
}

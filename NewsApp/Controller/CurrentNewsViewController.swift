//
//  CurrentNewsViewController.swift
//  NewsApp
//
//  Created by Raman Kozar on 26/03/2023.
//

import Foundation
import UIKit

class CurrentNewsViewCountoller: UIViewController {
    
    private let currentTitle: String?
    private let currentUrlToImage: URL?
    private let currentDescription: String?
    private let currentAuthor: String?
    
    private let mainImageNews: UIImageView = {
        let mainImageNews = UIImageView()
        mainImageNews.translatesAutoresizingMaskIntoConstraints = false
        mainImageNews.frame = CGRect(x: 0, y: 0, width: 374.0, height: 374.0)
        return mainImageNews
    }()

    private let mainTitleNews: UILabel = {
        let mainTitleNews = UILabel(frame: CGRect(x: 0, y: 0, width: 374.0, height: 77.0))
        mainTitleNews.translatesAutoresizingMaskIntoConstraints = false
        mainTitleNews.font = UIFont(name: "ArialHebrew-Bold", size: 20.0)
        mainTitleNews.textColor = .black
        mainTitleNews.numberOfLines = 3
        mainTitleNews.textAlignment = .left
        return mainTitleNews
    }()
    
    private let mainDescriptionNews: UILabel = {
        let mainDescriptionNews = UILabel(frame: CGRect(x: 0, y: 0, width: 374.0, height: 221.0))
        mainDescriptionNews.translatesAutoresizingMaskIntoConstraints = false
        mainDescriptionNews.font = UIFont(name: "ArialHebrew", size: 17.0)
        mainDescriptionNews.textColor = .black
        mainDescriptionNews.numberOfLines = 5
        mainDescriptionNews.textAlignment = .left
        return mainDescriptionNews
    }()
    
    private let mainAuthorNews: UILabel = {
        let mainAuthorNews = UILabel(frame: CGRect(x: 0, y: 0, width: 374.0, height: 43.0))
        mainAuthorNews.translatesAutoresizingMaskIntoConstraints = false
        mainAuthorNews.font = UIFont(name: "ArialHebrew", size: 15.0)
        mainAuthorNews.textColor = .black
        mainAuthorNews.textAlignment = .right
        return mainAuthorNews
    }()
    
    init(currentAuthor: String?, currentTitle: String?, currentDescription: String?, currentUrlToImage: URL?) {
        self.currentAuthor = currentAuthor
        self.currentTitle = currentTitle
        self.currentDescription = currentDescription
        self.currentUrlToImage = currentUrlToImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureUI()
        fillTheData()
    }
    
    func setupLayout() {
        
        view.backgroundColor = .white
        
        view.addSubview(mainTitleNews)
        view.addSubview(mainImageNews)
        view.addSubview(mainDescriptionNews)
        view.addSubview(mainAuthorNews)
        
    }
    
    func configureUI() {
     
        NSLayoutConstraint.activate([
        
            mainTitleNews.heightAnchor.constraint(equalToConstant: 60.0),
            mainImageNews.heightAnchor.constraint(equalToConstant: 374.0),
            mainDescriptionNews.heightAnchor.constraint(equalToConstant: 221.0),
            mainAuthorNews.heightAnchor.constraint(equalToConstant: 43.0),
            
            view.trailingAnchor.constraint(equalTo: mainTitleNews.trailingAnchor, constant: 20.0),
            view.trailingAnchor.constraint(equalTo: mainAuthorNews.trailingAnchor, constant: 20.0),
            view.trailingAnchor.constraint(equalTo: mainImageNews.trailingAnchor, constant: 20.0),
            view.trailingAnchor.constraint(equalTo: mainDescriptionNews.trailingAnchor, constant: 20.0),
            
            view.bottomAnchor.constraint(equalTo: mainAuthorNews.bottomAnchor, constant: 50.0),
            
            mainTitleNews.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0),
            mainTitleNews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            
            mainImageNews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            mainImageNews.topAnchor.constraint(equalTo: mainTitleNews.bottomAnchor, constant: 10.0),
           
            mainDescriptionNews.topAnchor.constraint(equalTo: mainImageNews.bottomAnchor, constant: 16.0),
            mainDescriptionNews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            
            mainAuthorNews.topAnchor.constraint(equalTo: mainDescriptionNews.bottomAnchor, constant: 18.0),
            mainAuthorNews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        
        ])
        
    }
    
    func fillTheData() {
        
        if let url = currentUrlToImage {
        
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    self.mainImageNews.image = UIImage(data: data)
                }
            }
            
            task.resume()
            
        } else {
            self.mainImageNews.image = UIImage(named: "error_logo")
        }
        
        guard let currentTitle = currentTitle else { return }
        mainTitleNews.text = currentTitle
        
        guard let currentDescription = currentDescription else { return }
        mainDescriptionNews.text = currentDescription
        
        guard let currentAuthor = currentAuthor else { return }
        mainAuthorNews.text = currentAuthor
        
    }
    
}

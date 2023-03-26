//
//  TableViewController.swift
//  NewsApp
//
//  Created by Raman Kozar on 26/03/2023.
//

import UIKit

class TableViewController: UITableViewController {

    let URLRequestString1: String = "https://newsapi.org/v2/everything?q=android&from=2019-04-00&sortBy=publi%20shedAt&apiKey=0761544563ac4a43b7ab0cc56b49d932&page=1"
    
    let URLRequestString2: String = "https://newsapi.org/v2/everything?q=android&from=2019-04-00&sortBy=publi%20shedAt&apiKey=0761544563ac4a43b7ab0cc56b49d932&page=2"
    
    let URLRequestString3: String = "https://newsapi.org/v2/everything?q=android&from=2019-04-00&sortBy=publi%20shedAt&apiKey=0761544563ac4a43b7ab0cc56b49d932&page=3"
    
    let URLRequestString4: String = "https://newsapi.org/v2/everything?q=android&from=2019-04-00&sortBy=publi%20shedAt&apiKey=0761544563ac4a43b7ab0cc56b49d932&page=4"
    
    let URLRequestString5: String = "https://newsapi.org/v2/everything?q=android&from=2019-04-00&sortBy=publi%20shedAt&apiKey=0761544563ac4a43b7ab0cc56b49d932&page=5"
    
    var allTheNews: [MainResultStructure] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        getTheNews()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTheNews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.mainTitleNews.text = allTheNews[indexPath.row].title
        cell.mainDateNews.text = allTheNews[indexPath.row].publishedAt
        cell.mainDescriptionNews.text = allTheNews[indexPath.row].description
        
        if let url = allTheNews[indexPath.row].urlToImage {
        
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    cell.mainImageNews.image = UIImage(data: data)
                }
            }
            
            task.resume()
            
        } else {
            cell.mainImageNews.image = UIImage(named: "error_logo")
        }
        
        return cell
    }
        
    func setupLayout() {
   
        view.backgroundColor = .white
        
        let labelTitle = UILabel()
        
        labelTitle.text = "World News"
        labelTitle.font = UIFont.boldSystemFont(ofSize: 35.0)
        labelTitle.textColor = .red
        labelTitle.textAlignment = .center
        
        self.navigationItem.titleView = labelTitle
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
    }
    
    private func getTheNews() {
    
        let jsonURL1 = URL(string: URLRequestString1)
        let jsonURL2 = URL(string: URLRequestString2)
        let jsonURL3 = URL(string: URLRequestString3)
        let jsonURL4 = URL(string: URLRequestString4)
        let jsonURL5 = URL(string: URLRequestString5)
        
        let arrayURLs: [URL?] = [jsonURL1,
                                 jsonURL2,
                                 jsonURL3,
                                 jsonURL4,
                                 jsonURL5]
        
        for currURL in arrayURLs {
            
            guard let jsonURL = currURL else { return }
            
            jsonURL.asyncDownload { data, response, error in
                
                guard let data = data else {
                    print("URLSession dataTask error:", error ?? "nil")
                    return
                }
                
                do {
                    
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dictionary = jsonObject as? [String: Any],
                       let results = dictionary["articles"] as? [[String: Any]] {
                        
                        DispatchQueue.main.async {
                            
                            results.forEach {
                                
                                var currentTitle: String = ""
                                if let title = $0["title"] as? String {
                                    currentTitle = title
                                }
                                
                                let currentDateBefore = $0["publishedAt"] as! String
                                
                                let currentDate = Date().convertDateToRequired(currentDate: currentDateBefore)
                                
                                var currentAuthor: String = ""
                                if let author = $0["author"] as? String {
                                    currentAuthor = author
                                }
                                
                                var currentDescription: String = ""
                                if let description = $0["description"] as? String {
                                    currentDescription = description
                                }
                                
                                var currenURL: URL = URL(fileURLWithPath: "")
                                if let urlString = $0["url"] as? String {
                                    currenURL = URL(string: urlString)!
                                }
                                
                                var currentImageURL: URL = URL(fileURLWithPath: "")
                                if let imageString = $0["urlToImage"] as? String {
                                    if imageString.isEmpty {
                                        currentImageURL = URL(fileURLWithPath: "")
                                    } else {
                                        currentImageURL = URL(string: imageString) ?? URL(fileURLWithPath: "")
                                    }
                                }
                                
                                let mainStruct = MainResultStructure(author: currentAuthor,
                                                                     title: currentTitle,
                                                                     description: currentDescription,
                                                                     url: currenURL,
                                                                     urlToImage: currentImageURL,
                                                                     publishedAt: currentDate)
                                
                                self.allTheNews.append(mainStruct)
                                
                            }
                            self.tableView.reloadData()
                        }
                    }
                    
                } catch {
                    print("JSONSerialization error:", error)
                }
                
            }
            
        }
 
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            
            let currentInfo = self.allTheNews[indexPath.row]
            
            let CurrentNewsViewCountoller = CurrentNewsViewCountoller(currentAuthor: currentInfo.author, currentTitle: currentInfo.title, currentDescription: currentInfo.description, currentUrlToImage: currentInfo.urlToImage)
            
            self.navigationController?.pushViewController(CurrentNewsViewCountoller, animated: true)
        }
        
    }
    
}

extension URL {
    
    func asyncDownload(completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()) {
        URLSession.shared
            .dataTask(with: self, completionHandler: completion)
            .resume()
    }
    
}

extension Date {
    
    func convertDateToRequired(currentDate: String) -> String {
     
        let dateFormatterBefore = DateFormatter()
        dateFormatterBefore.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatterBefore.date(from:currentDate)!
        
        let dateFormatterNow = DateFormatter()
        dateFormatterNow.dateFormat = "dd-MM-yyyy"
        
        return dateFormatterNow.string(from: date)
        
    }
    
}

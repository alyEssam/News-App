//
//  NewsViewController.swift
//  News App
//
//  Created by Aly Essam on 12/19/19.
//  Copyright © 2019 Aly Essam. All rights reserved.
//

import UIKit
import Firebase
import ReadMoreTextView


class NewsViewController: UITableViewController {

    var Articles = [Article]()
    var showMoreBtnIsSelected = [Bool] ()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(UINib(nibName: "NewsCustomCell", bundle: nil), forCellReuseIdentifier: "customNewsCell")
        
               tableView.separatorStyle = .singleLine
        for _ in 1...10{
            showMoreBtnIsSelected.append(false)
        }

        Newsapi.getTopheadlines(completion: handleResponse(Articles:error:))
    }
    func handleResponse(Articles: [Articles], error: Error?) {
          if error != nil{
              raiseAlertView(withTitle: "Failure", withMessage: error! .localizedDescription)
          } else {
            for articlee in Articles {
//                print("********")
//                print(articlee)
//                print("********")
               let article = Article()
                article.title = articlee.title
                article.displayImage = articlee.urlToImage
                article.sourceName = articlee.source.name
                article.author = articlee.author
                article.descriptionn = articlee.description
                article.publishedDate = articlee.publishedAt
                article.newsURL = articlee.url
                self.Articles.append(article)

                DispatchQueue.main.async {
                    self.configureTableView()
                    self.tableView.reloadData()
                }
                
            }
          }
      }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customNewsCell", for: indexPath) as! NewsCustomCell
        let article = Articles[indexPath.row]

        cell.title.text = article.title
        cell.publishedAt.text = article.publishedDate
        cell.author.text = "Published by:\(article.author ?? "")"
        //
        cell.descriptionText.text = article.descriptionn
        cell.descriptionText.isScrollEnabled = false
        cell.descriptionText.isSelectable = false
        //
        if showMoreBtnIsSelected[indexPath.row]{
            //print("Show more is pressed!")
            DispatchQueue.main.async {
              UIView.animate(withDuration: 0.5) {
                cell.showMoreButton.setTitle("Show less", for: .normal)
                let size = CGSize(width: self.view.frame.width, height: .infinity)
                let estimatedSize = cell.descriptionText.sizeThatFits(size)
                cell.descriptionText.constraints.forEach { (constraint) in
                    if constraint.firstAttribute == .height {
                        constraint.constant = estimatedSize.height
                       }
                }
                self.view.layoutIfNeeded()
              }
          }
        }
        else {
            //print("Show less is pressed!")
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.5) {
                    cell.showMoreButton.setTitle("Show more", for: .normal)
                    cell.descriptionText.constraints.forEach { (constraint) in
                        if constraint.firstAttribute == .height {
                            constraint.constant = 44.0
                           }
                        }
                    self.view.layoutIfNeeded()
                }
            }
        }
        //

        cell.sourceName.text = article.sourceName
        if let displayImageURL = article.displayImage {
            if let photoURL = URL(string: displayImageURL){
           // Download Photo
                let task = URLSession.shared.dataTask(with: photoURL) { (data, response, error) in
                if let error = error{
                 DispatchQueue.main.async {
                  self.showAlert(title: "Error", message: error.localizedDescription)
                 }
                 } else {
                     DispatchQueue.main.async {
                         cell.newsPicture.image = UIImage(data: data!)
                     }
                   }
                 }
                 task.resume()
            }
           }
        cell.shareButton.addTarget(self, action: #selector(self.selectShareButton), for: .touchUpInside)
        cell.showMoreButton.addTarget(self, action: #selector(self.selectShowMoreButton), for: .touchUpInside)
        return cell
    }
    /*
     UIView.animate(withDuration: 0.5) {
         self.heightConstraint.constant = 370
         self.view.layoutIfNeeded()
     }
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Additional Feature
        
//          let article = Articles[indexPath.row]
//          let url = article.newsURL
//          guard  UIApplication.shared.canOpenURL(URL(string: url!)!) == true else {
//                raiseAlertView(withTitle: "Invalid URL", withMessage: "It is invalid URL")
//                return
//            }
//          UIApplication.shared.open(URL(string: url!)!)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowHight = 0.0
        
        if showMoreBtnIsSelected[indexPath.row]{
             rowHight = 430
        }else {
             rowHight =  340
        }
        
        return CGFloat( rowHight)
    }
 
    //MARK: Activity view controller -> Share the news

    @objc func selectShareButton(sender: UIButton){
           let hitPoint: CGPoint = sender.convert(CGPoint.zero, to: self.tableView)
           let indexPath: NSIndexPath = self.tableView.indexPathForRow(at: hitPoint)! as NSIndexPath
           let article = Articles[indexPath.row]
           let url = article.newsURL
           let items = [URL(string: url!)!]
           let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
//            activityController.completionWithItemsHandler = { activity, success, items, error in
//                if success {
//
//                }
//            }
    }
    
   
    //Declare configureTableView here:
    func configureTableView(){
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 380
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
              try Auth.auth().signOut()
               print("Logged Out")
           }
           catch {
               print("Error: There was a problem logging out")
           }
    }


    
    @objc func selectShowMoreButton(sender: UIButton){
        //print("you have selected the Show more button")
        let hitPoint: CGPoint = sender.convert(CGPoint.zero, to: self.tableView)
        let indexPath: NSIndexPath = self.tableView.indexPathForRow(at: hitPoint)! as NSIndexPath
        showMoreBtnIsSelected[indexPath.row] = !showMoreBtnIsSelected[indexPath.row]
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

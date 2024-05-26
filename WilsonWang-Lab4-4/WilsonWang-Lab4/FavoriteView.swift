//
//  FavoriteView.swift
//  WilsonWang-Lab4
//
//  Created by Wilson Wang on 10/30/23.
//

import UIKit
import CoreServices


class FavoriteView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var Fav:[String] = []
    let favlist = FavList()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setTableView()
        if Fav.count != 0 {
            tabFav.badgeValue = String(Fav.count)
        }
    }
    

   
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return Fav.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            Fav.remove(at: indexPath.row)
            favlist.delete(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
            if Fav.count != 0 {
                tabFav.badgeValue = String(Fav.count)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "favoriteItem")
        
        cell.textLabel?.text = Fav[indexPath.row]
        
        return cell
    }
    
    func setTableView(){
        let path = Bundle.main.path(forResource: "UserFavorites", ofType: "plist")
        let dict: AnyObject = NSDictionary(contentsOfFile: path!)!
        
        Fav = dict.object(forKey: "userFav") as! Array<String>
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "favoriteItem")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let path = Bundle.main.path(forResource: "UserFavorites", ofType: "plist")
        let dict: AnyObject = NSDictionary(contentsOfFile: path!)!
        
        Fav = dict.object(forKey: "userFav") as! Array<String>
        
        tableView.reloadData()
        if Fav.count != 0 {
            tabFav.badgeValue = String(Fav.count)
        }
    }
    
    
    
    
    
    @IBOutlet weak var tabFav: UITabBarItem!
    
    
    
}

//extension FavoriteView{
//    
//    @available(iOS 13.0, *)
//    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: indexPath, point: CGPoint) -> UIContextMenuConfiguration?{
//        
//        let configuration = UIContextMenuConfiguration(identifier: nil, actionProvider: {_ in
//        
//            let add = UIAction(title: "Add to favorite", image: UIImage(symbol: .share)){_ in
//                print("added")
//            }
//            
//            
//            
//        })
//        
//        return configuration
//        
//    }
    


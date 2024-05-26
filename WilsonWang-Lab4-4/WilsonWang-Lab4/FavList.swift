//
//  FavList.swift
//  WilsonWang-Lab4
//
//  Created by Wilson Wang on 10/30/23.
//

import Foundation

class FavList {
    let plistURL : URL = Bundle.main.url(forResource: "UserFavorites", withExtension:"plist")!
    let plistPath = Bundle.main.path(forResource: "UserFavorites", ofType: "plist")!
    
    ////////////////////
    // The code below was cited from https://stackoverflow.com/questions/47419327/swift-4-adding-dictionaries-to-plist
    //
    func savePropertyList(_ plist: Any) throws
    {
        let plistData = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
        try plistData.write(to: plistURL)
    }
    //
    // End citing
    ////////////////////
    
    func loadPropertyList() throws -> [String:[String]]
    {
        let dict: AnyObject = NSDictionary(contentsOfFile: plistPath)!
        let plist = ["userFav" : dict.object(forKey: "userFav") as! Array<String>]
        return plist
    }
    
    func add(title: String) {
        do {
            var dictionary = try loadPropertyList()
            for item in dictionary["userFav"]! {
                if title == item {
                    return
                }
            }
            dictionary["userFav"]?.append(title)
            try savePropertyList(dictionary)
        } catch {
            print(error)
        }
    }
    
    func delete(index: Int) {
        do {
            var dictionary = try loadPropertyList()
            dictionary["userFav"]?.remove(at: index)
            try savePropertyList(dictionary)
        } catch {
            print(error)
        }
    }
    
}

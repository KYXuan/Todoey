//
//  AppDelegate.swift
//  Todoey
//
//  Created by 宣柯宇 on 2018-07-20.
//  Copyright © 2018 keyu xuan. All rights reserved.
//

import UIKit

import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey:
        Any]?) -> Bool {
        
        //location of Realm file
        //print(Realm.Configuration.defaultConfiguration.fileURL)
       
      
        
        do {
            _ =  try Realm()
            
        } catch {
            print("Error initialising new real \(error)")
        }
        

        
        return true
    }

  

 
    
   

}


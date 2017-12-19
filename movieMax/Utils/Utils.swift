//
//  Utils.swift
//  movieMax
//
//  Created by sagarmodak on 19/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class Utils {
    
    //MARK:- Alert Functions
    class func displayAlert(title: String, message: String, senderViewController: UIViewController? = nil, alertDisplayedHandler : @escaping ()-> Void = {}) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .destructive) { (action) in
            print("Dismiss button tapped!")
        }
        alert.addAction(alertAction)
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        var viewController = delegate.window?.rootViewController
        if senderViewController != nil {
            viewController = senderViewController
        }
        if let _ = viewController?.presentedViewController as? UIAlertController{
            
        } else {
            viewController!.present(alert, animated: true, completion: {
                alertDisplayedHandler()
            })
        }
        
    }
    
    
    //MARK:- Loader Functions
    class func showLoadingInView(view: UIView, withText text: String = "") {
        let loadingWheel = Utils.showLoadingIn(view: view, withText: text)
    }
    
    class func hideLoadingInView(view:UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    class func showLoadingIn(view: UIView, withText text: String = "") -> UIView {
        var progressView: MBProgressHUD!
        progressView = MBProgressHUD.showAdded(to: view, animated: true)
        progressView.isUserInteractionEnabled = true
        progressView.label.text = ""
        progressView.label.textColor = UIColor.black
        progressView.animationType = .zoom
        return progressView
    }
    
}

//MARK:- Storyboard extensions
extension UIStoryboard {
    
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func getMovieResultsListViewController() -> MovieResultsViewController {
        return mainStoryboard().instantiateViewController(withIdentifier: "MovieResultsViewController") as! MovieResultsViewController
    }
    
    class func getRecentSearchesViewController() -> RecentSearchesViewController {
        return mainStoryboard().instantiateViewController(withIdentifier: "RecentSearchesViewController") as! RecentSearchesViewController
    }
    
}

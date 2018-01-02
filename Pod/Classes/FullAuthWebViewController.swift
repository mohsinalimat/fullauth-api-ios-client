//
//  FullAuthWebViewController.swift
//  Pods
//
//  Created by Karthik on 01/12/16.
//
//

import UIKit
import Foundation
import SafariServices

public protocol AuthCodeDelegate {
    
    func didStartLoad()
    func didFinishLoad(withCode code: String, receiver: UIViewController)
    func didFailLoad(withError error: Error?, receiver: UIViewController)
}

public class FullAuthWebViewController: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var safariViewController: SFSafariViewController?
    
    public var delegate: AuthCodeDelegate?
    public var authCodeReq: AuthCodeRequest? // authcode must be setted
    public var authObj: FullAuthOAuthService?
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        loadRequest()
    }
    
    
    func loadRequest() {
        
        guard let authCodeModel = authCodeReq else {
            print("Error: AuthCode Request not found")
            return
        }
        
        let oauthObj = FullAuthOAuthService(authDomain: authCodeModel.authDomain)
        oauthObj.clientId = authCodeModel.clientId
    
        do {
            
            let urlStr = try oauthObj.getAuthCodeUrl(scopes: authCodeModel.scopes)
            
            //print("query str : \(urlStr)")
            
            guard var url = URL(string: urlStr) else {
                print("Error: Can't construct url components")
                return
            }
            
            let safariVc = SFSafariViewController(url: url)
            safariVc.delegate = self
            safariViewController = safariVc
            self.present(safariVc, animated: true, completion: nil)
            
        } catch let err {
            print("Error: \(err.localizedDescription)")
        }
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
    
        if webView.isLoading {
            webView.stopLoading()
        }
        self.dismiss(animated: true, completion: nil)
    }
}


extension FullAuthWebViewController {
    
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        print("safari did finish")
    }
    
    public func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        print("safari did comleted load")
    }
    
    public func safariViewController(_ controller: SFSafariViewController, activityItemsFor URL: URL, title: String?) -> [UIActivity] {
        return []
    }
}

public class FullAuthVC: UIViewController {
    
    public static var webViewController: FullAuthWebViewController? {
        
        guard let bundleUrl = Bundle(for: FullAuthWebViewController.self).url(forResource: "FullAuthIOSClient", withExtension: "bundle") else{
            return nil
        }
        
        let bundle = Bundle(url: bundleUrl)
        let storyboard = UIStoryboard(name: "FullAuth", bundle: bundle)
        
        guard let webVc = storyboard.instantiateViewController(withIdentifier: "FullAuthWebViewController") as? FullAuthWebViewController else{
            return nil
        }
        
        return webVc
    }
}

//
//  FullAuthWebViewController.swift
//  Pods
//
//  Created by Karthik on 01/12/16.
//
//

import UIKit
import Foundation


public protocol AuthCodeDelegate {
    
    func didStartLoad()
    func didFinishLoad(withCode code: String, receiver: UIViewController)
    func didFailLoad(withError error: Error?, receiver: UIViewController)
}


public class FullAuthWebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    public var delegate: AuthCodeDelegate?
    public var authCodeReq: AuthCodeRequest?
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        loadRequest()
    }
    
    
    func loadRequest() {
        
        guard let authCodeModel = authCodeReq else {
            print("Error: AuthCode Request not found")
            return
        }

        let urlString = "https://access.anywhereworks.com/o/oauth2/auth"
        
        let scopes = authCodeModel.scopes.joined(separator: " ")
        
        let query = "response_type=code&client_id=\(authCodeModel.clientId)&scope=\(scopes)&redirect_uri=urn:ietf:wg:oauth:2.0:oob:auto&approval_prompt=force&access_type=\(authCodeModel.accessType.rawValue)"
        
        print("query str : \(query)")

        guard var components = URLComponents(string: urlString) else{
            print("Error: Can't construct url components")
            return
        }
        
        components.query = query
        
        webView.loadRequest(URLRequest(url : components.url!))
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
    
        if webView.isLoading {
            webView.stopLoading()
        }
        self.dismiss(animated: true, completion: nil)
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

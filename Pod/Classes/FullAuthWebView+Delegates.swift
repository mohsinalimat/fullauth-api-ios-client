//
//  FullAuthWebView+Delegates.swift
//  Pods
//
//  Created by Karthik on 02/12/16.
//
//

import UIKit
import Foundation

extension FullAuthWebViewController: UIWebViewDelegate {
    
    public func webViewDidStartLoad(_ webView: UIWebView) {
        delegate?.didStartLoad()
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView) {
        
        guard let title = webView.stringByEvaluatingJavaScript(from: "document.title") else {
            delegate?.didFailLoad(withError: nil, receiver: self)
            return
        }
        
        if let data = title.data(using: String.Encoding.utf8) {
            
            do {
                guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any], let code = dict["code"] as? String else{
                    delegate?.didFailLoad(withError: nil, receiver: self)
                    return
                }
                
                print("auth code : \(code)")
                
                delegate?.didFinishLoad(withCode: code, receiver: self)
                
            } catch let error as Error {
                delegate?.didFailLoad(withError: error, receiver: self)
            }
        }
    }
    
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        print("didFailLoadWithError : \(error.localizedDescription)")
        
        delegate?.didFailLoad(withError: error, receiver: self)
    }
}

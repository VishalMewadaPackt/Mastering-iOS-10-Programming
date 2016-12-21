//
//  MessagesViewController.swift
//  The Daily Quote Messages
//
//  Created by Donny Wals on 01/10/2016.
//  Copyright © 2016 Donny Wals. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController, QuoteSelectionDelegate {
    
    var compactViewController: CompactViewController?
    var expandedViewController: QuotesTableViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        compactViewController = storyboard?.instantiateViewController(withIdentifier: "CompactViewController") as? CompactViewController
        compactViewController?.delegate = self
        
        expandedViewController = storyboard?.instantiateViewController(withIdentifier: "QuotesTableViewController") as? QuotesTableViewController
        expandedViewController?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showCompactView() {
        guard let compactViewController = self.compactViewController
            else { return }
        
        showViewController(compactViewController)
    }

    func showExpandedView() {
        guard let expandedViewController = self.expandedViewController
            else { return }
        
        showViewController(expandedViewController)
    }

    func showViewController(_ viewController: UIViewController) {
        cleanupChildViewControllers()
        
        viewController.willMove(toParentViewController: self)
        self.addChildViewController(viewController)
        viewController.didMove(toParentViewController: self)
        
        view.addSubview(viewController.view)
        viewController.view.frame = view.frame
    }
    
    func cleanupChildViewControllers() {
        for viewController in childViewControllers {
            viewController.willMove(toParentViewController: nil)
            viewController.removeFromParentViewController()
            viewController.didMove(toParentViewController: nil)
            
            viewController.view.removeFromSuperview()
        }
    }
    
    func shareQuote(_ quote: Quote) {
        guard let conversation = activeConversation
            else { return }
        
        conversation.insertText("\(quote.text) - \(quote.creator)", completionHandler: nil)
        
        dismiss()
    }
    
    // MARK: - Conversation Handling
    
    override func didBecomeActive(with conversation: MSConversation) {
        
    }
    
    override func willBecomeActive(with conversation: MSConversation) {
        if self.presentationStyle == .compact {
            showCompactView()
        } else if self.presentationStyle == .expanded {
            showExpandedView()
        }
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        if presentationStyle == .compact {
            showCompactView()
        } else if presentationStyle == .expanded {
            showExpandedView()
        }
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }

}
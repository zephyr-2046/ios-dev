//
//  DocumentBrowserViewController.swift
//  documentbasedapp01
//
//  Created by zephyr yang on 2019-06-24.
//  Copyright © 2019 zephyr yang. All rights reserved.
//

import UIKit


class DocumentBrowserViewController: UIDocumentBrowserViewController, UIDocumentBrowserViewControllerDelegate {
    
    var documentBrowserTransitionController: UIDocumentBrowserTransitionController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        allowsDocumentCreation = true
        allowsPickingMultipleItems = false
        
        // Update the style of the UIDocumentBrowserViewController
        // browserUserInterfaceStyle = .dark
        // view.tintColor = .white
        
        // Specify the allowed content types of your application via the Info.plist.
        
        // Do any additional setup after loading the view, typically from a nib.
        print( "Z document browser view controller viewDidiLoad" )
        
        // about button
        let aboutButtonItem : UIBarButtonItem = UIBarButtonItem.init(title: "About", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.openAbout(sender:)))
        
        self.additionalTrailingNavigationBarButtonItems = [aboutButtonItem]
        
        // custom action
        let documentBrowserAction : UIDocumentBrowserAction = UIDocumentBrowserAction.init(
            identifier: "com.cainluo.action",
            localizedTitle: "Lighter Color",
            availability: UIDocumentBrowserAction.Availability.menu,
            handler: self.documentbrosweractiona(urls:))
        
        documentBrowserAction.supportedContentTypes = ["com.cainluo.colorExtension"];
        
        self.customActions = [documentBrowserAction]
    }
    
    @objc func documentbrosweractiona(urls: [URL]) {
        print( "UIDocumentBrowserAction handler() is called" )

        let colorDocument = ColorDocument(fileURL: urls[0])
        colorDocument.open(){
 
            (success: Bool) in
            
            if success {
                colorDocument.colorModel = colorDocument.colorModel?.lighterColor(toAdd:60)
                self.presentColorController(colorDocument: colorDocument)
            }
        }
    }
    
    @objc func openAbout(sender: UIBarButtonItem) {
        print( "open About is called" )
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: UIDocumentBrowserViewControllerDelegate
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
        
        let newDocumentURL: URL? = Bundle.main.url(forResource: "ColorFile", withExtension: "color")
        
        print( "Z document browser view controller - newDocumentURL = \(newDocumentURL)" )

        // Set the URL for the new document here. Optionally, you can present a template chooser before calling the importHandler.
        // Make sure the importHandler is always called, even if the user cancels the creation request.
        if newDocumentURL != nil {
            importHandler(newDocumentURL, .move)
        } else {
            importHandler(nil, .none)
        }
        
        print( "Z document browser view controller - importHadler request" )
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
        
        guard let sourceURL = documentURLs.first else { return }
        
        print( "Z document browser view controller - didPickDocumentsAt" )

        // Present the Document View Controller for the first document that was picked.
        // If you support picking multiple items, make sure you handle them all.
        presentDocument(at: sourceURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
        
        print( "Z document browser view controller - didImportDocumentAt" )

        // Present the Document View Controller for the new newly created document
        presentDocument(at: destinationURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?) {
        // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
        
        print( "Z document browser view controller - failedToImportDocumentAt" )
    }
    
    // MARK: Document Presentation
    
    func presentDocument(at documentURL: URL) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        /*
        let documentViewController = storyBoard.instantiateViewController(withIdentifier: "DocumentViewController") as! DocumentViewController
        
        documentViewController.document = ColorDocument(fileURL: documentURL)

        present(documentViewController, animated: true, completion: nil)
         */

        print( "Z document browser view controller - presentDocument - enter" )

        let colorViewController = storyBoard.instantiateViewController(withIdentifier: "ColorViewController") as! ColorViewController
        colorViewController.colorDocument = ColorDocument(fileURL: documentURL)
        present(colorViewController, animated: true, completion: nil)
        
        // end
        print( "Z document browser view controller - presentDocument - exit" )
    }
    
    //#pragma mark - Present Controller
    func presentColorController( colorDocument: ColorDocument) {
    
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)

        let colorViewController = storyBoard.instantiateViewController(withIdentifier: "ColorViewController") as! ColorViewController
        colorViewController.colorDocument = colorDocument
        colorViewController.transitioningDelegate = self as? UIViewControllerTransitioningDelegate
    
        self.documentBrowserTransitionController = self.transitionController(forDocumentURL: colorDocument.fileURL)
    
        present(colorViewController, animated: true, completion: nil)
    }
}

//
//  DocumentViewController.swift
//  documentbasedapp01
//
//  Created by zephyr yang on 2019-06-24.
//  Copyright © 2019 zephyr yang. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController {
    
    @IBOutlet weak var documentNameLabel: UILabel!
    
    var document: UIDocument?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access the document
        document?.open(completionHandler: { (success) in
            
            print("DocumentViewController::viewWillAppear success = \(success)")
            
            if success {
                // Display the content of the document, e.g.:
                self.documentNameLabel.text = self.document?.fileURL.lastPathComponent
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    @IBAction func dismissDocumentViewController() {
        
        print("DocumentViewController::dismissDocumentViewController")

        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
}

//
//  ViewController.swift
//  ID
//
//  Created by Jackson Wang on 1/1/16.
//  Copyright © 2016 Jackson Wang. All rights reserved.
//

import UIKit
import SZTextView
import TextFieldEffects
import UITextField_Shake
import KVNProgress
import DynamicButton
import AVFoundation
import URBNAlert

class MainViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIWebViewDelegate, UINavigationBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    let backgroundImage = UIImage(named: "background.png")
    let backgroundImageView = UIImageView()
    let scrollView = UIScrollView()
    let confirm_button = DynamicButton()
    let your_email_textField = MinoruTextField()
    let lost_id_name = MinoruTextField()
    let your_name = MinoruTextField()
    let commentTextView = SZTextView()
    let color = UIColor(red: 0.43, green: 0.62, blue: 0.92, alpha: 1)
    let warningLabel = UILabel()
    let webView = UIWebView()
    let requestObj = NSURLRequest(URL: NSURL(string: "http://find.pitt.edu/")!)
    var clicked = false
    var email_address_found = false
    var imagePicker: UIImagePickerController!
    let imageAttachmentLabel = UILabel()
    var imageAttachment = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundImage()
        
        setupImageAttachment()
        
        setupTopButtons()
        
        setupScrollView()
        
        setupTextFields()
        
        setupTapGesture()
        
        setupWarningLabel()
        
        setupConfirmButton()
        
        setupWebView()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //------------------------ Background Image -------------------------//
    func setupBackgroundImage() {
        
        backgroundImageView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        
        backgroundImageView.image = backgroundImage
        
        backgroundImageView.contentMode = .ScaleToFill
        
        self.view.addSubview(backgroundImageView)
        
    }
    
    
    //------------------- Top Buttons ---------------------//
    func setupTopButtons() {
        
        // Create the navigation bar
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.width, 70))
        
        navigationBar.delegate = self
        
        // Create left and right button for navigation item
        let leftButton =  UIBarButtonItem(title: "About Us", style:   UIBarButtonItemStyle.Plain, target: self, action: #selector(MainViewController.showAboutUsInfo))
        let rightButton = UIBarButtonItem(title: "Camera", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(MainViewController.takePhoto))
        
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
        
        
    }
    
    func showAboutUsInfo() {
        
        let alert = URBNAlertViewController(title: "About Pitt ID Finder", message: "Pitt ID Finder was first developed in September 2015. Its ultimate goal is to help Pitt students find their lost IDs before they pay a rip-off fee ($20) at Panther Central. Note that it is $20 each time! Please share with your friends if you like this app.")
        
        alert.alertStyler.blurEnabled = true
                
        alert.addAction(URBNAlertAction(title: "Ok", actionType: .Normal, actionCompleted: { (action) -> Void in
            
            
            
        }))
        
        alert.show()
        
    }
    
    func takePhoto() {
        
        imagePicker =  UIImagePickerController()
        
        imagePicker.delegate = self
        
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        imageAttachmentLabel.hidden = false
        
        imageAttachment = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    //------------------- ScrollView --------------------------------//
    func setupScrollView() {
        
        scrollView.frame = CGRectMake(0, 80, self.view.frame.width, self.view.frame.height - 90)
        
        scrollView.backgroundColor = UIColor.clearColor()
        
        scrollView.contentSize = CGSizeMake(self.view.frame.width, self.view.frame.height - 20)
        
        scrollView.indicatorStyle = .White
            
        self.view.addSubview(scrollView)
        
    }
    
    //------------------- TextFields ------------------------//
    func setupTextFields() {
        
        your_name.delegate = self
        
        your_name.textColor = color
        
        your_name.frame = CGRectMake(50, 20, self.view.frame.width - 100, 50)
        
        your_name.placeholder = "Your name"
        
        your_name.backgroundColor = UIColor(red:0.96, green:0.94, blue:0.92, alpha:1)
        
        your_name.animateViewsForTextEntry()
        
        your_name.animateViewsForTextDisplay()
        
        your_name.placeholderFontScale = 0.7
        
        your_name.keyboardAppearance = .Dark
        
        your_name.returnKeyType = .Next
        
        scrollView.addSubview(your_name)
        
        
        your_email_textField.delegate = self
        
        your_email_textField.textColor = color
        
        your_email_textField.frame = CGRectMake(50, 90, self.view.frame.width - 100, 50)
        
        your_email_textField.placeholder = "Your Email Address"
        
        your_email_textField.backgroundColor = UIColor(red:0.96, green:0.94, blue:0.92, alpha:1)
        
        your_email_textField.animateViewsForTextEntry()
        
        your_email_textField.animateViewsForTextDisplay()

        your_email_textField.placeholderFontScale = 0.7
        
        your_email_textField.keyboardAppearance = .Dark
        
        your_email_textField.returnKeyType = .Next
        
        scrollView.addSubview(your_email_textField)
        
        
        lost_id_name.delegate = self
        
        lost_id_name.textColor = color
        
        lost_id_name.frame = CGRectMake(50, 160, self.view.frame.width - 100, 50)
        
        lost_id_name.placeholder = "Enter the name on the ID you just found"
        
        lost_id_name.backgroundColor = UIColor(red:0.96, green:0.94, blue:0.92, alpha:1)
        
        lost_id_name.animateViewsForTextEntry()
        
        lost_id_name.animateViewsForTextDisplay()
        
        lost_id_name.placeholderFontScale = 0.7
        
        lost_id_name.keyboardAppearance = .Dark
        
        lost_id_name.returnKeyType = .Next
        
        scrollView.addSubview(lost_id_name)
        
        
        commentTextView.delegate = self
        
        commentTextView.frame = CGRectMake(50, 250, self.view.frame.width - 100, 150)
        
        commentTextView.placeholder = "Comment?"
        
        commentTextView.placeholderTextColor = UIColor.whiteColor()
        
        commentTextView.layer.cornerRadius = 8
        
        commentTextView.backgroundColor = UIColor(red: 0.71, green: 0.84, blue: 0.66, alpha: 1)
        
        commentTextView.font = UIFont.systemFontOfSize(16)
        
        commentTextView.fadeTime = 0.2
        
        commentTextView.keyboardAppearance = .Dark
        
        commentTextView.returnKeyType = .Send
        
        scrollView.addSubview(commentTextView)
        
    }
    
    //----------------------------------------- Image Attachment --------------------------------//
    func setupImageAttachment() {
        
        imageAttachmentLabel.frame = CGRectMake(50, 420, self.view.frame.width - 100, 50)
        
        imageAttachmentLabel.text = "Image Attachments: 1"
        
        imageAttachmentLabel.textColor = UIColor.grayColor()
        
        imageAttachmentLabel.textAlignment = .Center
        
        scrollView.addSubview(imageAttachmentLabel)
        
        imageAttachmentLabel.hidden = true
        
    }
    
    //---------------------------------------- Warning Label -----------------------------------------//
    func setupWarningLabel() {
        
        warningLabel.frame = CGRectMake(50, 450, self.view.frame.width - 100, 50)
        
        warningLabel.text = ""
        
        warningLabel.font = UIFont(name: "ChalkboardSE-Bold", size: 16)
        
        warningLabel.textColor = UIColor.redColor()
        
        warningLabel.textAlignment = .Center
        
        scrollView.addSubview(warningLabel)
        
    }
    
    //---------------------------------------- Confirm Button ----------------------------------------//
    func setupConfirmButton() {
        
        confirm_button.lineWidth = 0
        
        confirm_button.frame = CGRectMake(self.view.frame.width / 2 - 50, 500, 100, 40)
        
        confirm_button.setTitle("Confirm", forState: .Normal)
        
        confirm_button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        confirm_button.titleLabel?.font = UIFont(name: "ChalkboardSE-Bold", size: 16)
        
        confirm_button.titleLabel?.textAlignment = .Center
        
        confirm_button.addTarget(self, action: #selector(MainViewController.confirmButtonPressed(_:)), forControlEvents: .TouchUpInside)
        
        confirm_button.backgroundColor = color
        
        confirm_button.layer.cornerRadius = 8
        
        scrollView.addSubview(confirm_button)
        
    }
    
    func confirmButtonPressed(sender: UIButton) {
        
        if your_name.isFirstResponder() {
            
            your_name.resignFirstResponder()
            
        }else if your_email_textField.isFirstResponder() {
            
            your_email_textField.resignFirstResponder()
            
        }else if lost_id_name.isFirstResponder() {
            
            lost_id_name.resignFirstResponder()
            
        }else if commentTextView.isFirstResponder() {
            
            commentTextView.resignFirstResponder()
            
        }
        
        warningLabel.text = ""
        
        warningLabel.alpha = 1
        
        if checkInput() {
            
            // ASK IF THE NAME IS CORRECT ONE MORE TIME
            
            let alert = UIAlertController(title: "One last check", message: "Is \(lost_id_name.text!), the name on the lost ID?", preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "YES", style: .Default, handler: { (alertAction) -> Void in
                
                let KVNConfig = KVNProgressConfiguration()
                
                KVNConfig.backgroundType = .Blurred

                KVNProgress.setConfiguration(KVNConfig)
                
                KVNProgress.showWithStatus("Searching...", onView: self.view)
                
                
                //then load url request
                self.webView.loadRequest(self.requestObj)
                
            }))
            
            alert.addAction(UIAlertAction(title: "NO", style: .Cancel, handler:{ (alertAction) -> Void in
                
                // set up textfield for user to reenter name
                
                self.lost_id_name.text = ""
                
                self.lost_id_name.becomeFirstResponder()
                
            }))

            presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }
    
    func checkInput() -> Bool {
        
        let name = your_name.text
        
        let name_on_id = lost_id_name.text
        
        let email = your_email_textField.text
        
        if name == "" || name?.characters.count > 30 {
            
            your_name.shake(10,
                withDelta: 5.0,
                speed: 0.03
            )
            
            warningLabel.text = "Enter your name."
            
            UIView.animateWithDuration(4, animations: { () -> Void in
                
                self.warningLabel.alpha = 0
                
            })
            
            return false
            
        }else if email == "" || email?.containsString("@") == false {
            
            your_email_textField.shake(10,
                withDelta: 5.0,
                speed: 0.03
            )
            
            warningLabel.text = "Enter a valid email."
            
            UIView.animateWithDuration(4, animations: { () -> Void in
                
                self.warningLabel.alpha = 0
                
            })
            
            return false
            
        }else if name_on_id == "" || name_on_id?.characters.count  > 30 {
            
            lost_id_name.shake(10,
                withDelta: 5.0,
                speed: 0.03
            )
            
            warningLabel.text = "Enter the name on the ID you just found."
            
            UIView.animateWithDuration(4, animations: { () -> Void in
                
                self.warningLabel.alpha = 0
                
            })
            
            return false
            
        }else if imageAttachmentLabel.hidden == true {
            
            warningLabel.text = "Take a photo of the ID."
            
            UIView.animateWithDuration(4, animations: { () -> Void in
                
                self.warningLabel.alpha = 0
                
            })
            
            return false
            
        }
        
        return true
        
    }
    
    
    //------------------------------------ WebView -----------------------------------------//
    func setupWebView() {
        
        webView.frame = CGRectMake(self.view.frame.width, self.view.frame.height, 0, 0)
        
        webView.delegate = self

    }
    
    
    //------------------------------------ WebView ----------------------------------------//
    func webViewDidFinishLoad(webView: UIWebView) {
        
        if !clicked {
            
            // first webpage
            
            webView.stringByEvaluatingJavaScriptFromString("document.getElementById('ctl00_ContentPlaceHolder1_txtSearchAll').value = '\(lost_id_name.text!)';document.getElementById('ctl00_ContentPlaceHolder1_btnSearchAll').click();")!
            clicked = true
            
        }else {
            
            
            // second webpage
            
            let email_address: String = webView.stringByEvaluatingJavaScriptFromString("document.getElementsByTagName('a')[2].text")!
           
            if email_address.containsString("@pitt.edu") {
            
                email_address_found = true
                
                let sendgrid = SendGrid(username: "SENDGRID USERNAME", password: "SENDGRID PASSWORD")
                
                let email = SendGrid.Email()
                
                do {
                    
                    try email.addTo(email_address, name: lost_id_name.text)
                    
                }catch {
                    
                    
                    
                }
                
                email.setFrom("pittidfinder@gmail.com", name: "Pitt ID Finder")
                
                email.subject = "Found Your Pitt ID!"
                
                if commentTextView.text != nil {
                    
                    email.html = "<h1><center><font = 'Comic Sans MS'>Someone found your Pitt ID!</font></center></h1><p><font face = 'Lucida Sans Unicode'>Hello \(lost_id_name.text!),</font></p><p><font face = 'Lucida Sans Unicode'>This is a friendly email from Pitt ID Finder. Your Pitt ID was found by \(your_name.text!). Please contact \(your_name.text!) at: \(your_email_textField.text!) <br><br>\(your_name.text!) also left a message for you:\(commentTextView.text!) <br><br>Pitt ID Finder was developed in September 2015. Its ultimate goal is to help Pitt students find their lost IDs before they pay a rip-off fee ($20) at Panther Central. If there's anything you would like to share with us, shoot us an email: pittidfinder@gmail.com<br><br>Sincerely,<br>Pitt ID Finder</font></p>"
                    
                }else {
                    
                    email.html = "<h1><center><font = 'Comic Sans MS'>Someone found your Pitt ID!</font></center></h1><p><font face = 'Lucida Sans Unicode'>Hello \(lost_id_name.text!),</font></p><p><font face = 'Lucida Sans Unicode'>This is a friendly email from Pitt ID Finder. Your Pitt ID was found by \(your_name.text!). Please contact \(your_name.text!) at: \(your_email_textField.text!) <br><br>Pitt ID Finder was developed in September 2015. Its ultimate goal is to help Pitt students find their lost IDs before they pay a rip-off fee ($20) at Panther Central. If there's anything you would like to share with us, shoot us an email: pittidfinder@gmail.com<br><br>Sincerely,<br>Pitt ID Finder</font></p>"
                    
                }
                
                
                let imageData = UIImagePNGRepresentation(imageAttachment)
                
                email.addAttachment("id.png", data: imageData!, contentType: "image/png", cid: "abc")
                                
                
                do{
                    
                    try sendgrid.send(email, completionHandler: { (response, data, error) -> Void in
                        
                        if error == nil {
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                KVNProgress.showSuccessWithStatus("An email has been sent to \(self.lost_id_name.text!)")
                                
                                self.your_name.text = ""
                                
                                self.your_email_textField.text = ""
                                
                                self.lost_id_name.text = ""
                                
                                self.commentTextView.text = ""
                                
                                self.imageAttachmentLabel.hidden = true
                                
                            })

                            
                        }
                        
                    })
                
                }catch {
                    
                    
                    
                }
                
            }else {
                
                KVNProgress.showErrorWithStatus("Failed to find user in Pitt database.")
                
            }
        }
        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
        KVNProgress.showErrorWithStatus("Internet connection failed.")
        
    }
    
    //------------------------------------ Tap Gesture --------------------------------------------//
    func setupTapGesture() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MainViewController.dismissKeyboard))
        
        self.view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        
        if your_name.isFirstResponder() {
            
            your_name.resignFirstResponder()
            
        }else if your_email_textField.isFirstResponder() {
            
            your_email_textField.resignFirstResponder()
            
        }else if lost_id_name.isFirstResponder() {
            
            lost_id_name.resignFirstResponder()
            
        } else {
            
            commentTextView.resignFirstResponder()
            
        }
    }


    //--------------------------------- UITextField/UITextView Delegate ----------------------------------------//
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if textField == your_name {
            
            let contentOffSet = CGPointMake(0, textField.frame.origin.y)
            
            scrollView.setContentOffset(contentOffSet, animated: true)
            
        }else if textField == your_email_textField {
            
            let contentOffSet = CGPointMake(0, textField.frame.origin.y)
            
            scrollView.setContentOffset(contentOffSet, animated: true)
            
        }else {
            
            let contentOffSet = CGPointMake(0, textField.frame.origin.y)
            
            scrollView.setContentOffset(contentOffSet, animated: true)
            
        }
        
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        
        let contentOffSet = CGPointMake(0, textView.frame.origin.y)
        
        scrollView.setContentOffset(contentOffSet, animated: true)
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        scrollView.contentSize = CGSizeMake(self.view.frame.width, self.view.frame.height - 20)
        
        scrollView.scrollRectToVisible(CGRectMake(0,0,scrollView.frame.width,scrollView.frame.height), animated: true)
        
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        
        scrollView.scrollRectToVisible(CGRectMake(0,0,scrollView.frame.width,scrollView.frame.height), animated: true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == your_name {
            
            your_name.resignFirstResponder()
            
            your_email_textField.becomeFirstResponder()
            
        }else if textField == your_email_textField {
            
            your_email_textField.resignFirstResponder()
            
            lost_id_name.becomeFirstResponder()
            
        }else if textField == lost_id_name {
            
            lost_id_name.resignFirstResponder()
        
        }
        
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            
            textView.resignFirstResponder()
            
            return false
            
        }
        
        return true
        
    }
    

    
}



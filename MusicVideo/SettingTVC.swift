//
//  SettingTVC.swift
//  MusicVideo
//
//  Created by Stephen Barrett on 17/06/2016.
//  Copyright © 2016 Stephen Barrett. All rights reserved.
//

import UIKit
import MessageUI

class SettingTVC: UITableViewController, MFMailComposeViewControllerDelegate {

    
    @IBOutlet weak var aboutDisplay: UILabel!
    @IBOutlet weak var feedbackDisplay: UILabel!
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var touchId: UISwitch!
    @IBOutlet weak var bestImageDisplay: UILabel!
    @IBOutlet weak var numberOfVideosToDisplay: UILabel!
    @IBOutlet weak var APICnt: UILabel!
    @IBOutlet weak var dragTheSliderDisplay: UILabel!
    @IBOutlet weak var sliderCnt: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MusicVideoTVC.preferredFontChange), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        tableView.alwaysBounceVertical = false  //don't bounce the table view (cannot scroll)
        
        touchId.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil) {
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            APICnt.text = "\(theValue)"
            sliderCnt.value = Float(theValue)
        } else {
            sliderCnt.value = 10.0
            APICnt.text = ("\(Int(sliderCnt.value))")
        }

    }
    
    @IBAction func valueChanged(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(sliderCnt.value), forKey: "APICNT")
        APICnt.text = ("\(Int(sliderCnt.value))")
    }
    
    @IBAction func touchIdSecurity(sender: UISwitch) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if touchId.on {
            defaults.setBool(true, forKey: "SecSetting")
        } else {
            defaults.setBool(false, forKey: "SecSetting")
        }
    }
    
    func preferredFontChange() {
        
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedbackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        numberOfVideosToDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        dragTheSliderDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if indexPath.section == 0 && indexPath.row == 1 {
            
            let mailComposeViewController = configureMail()
            
            if MFMailComposeViewController.canSendMail() {  //absolutely needed to be passed by Apple
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                //No email account
                mailAlert()
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func configureMail() -> MFMailComposeViewController {
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["mail@steviebarrett.com"])
        mailComposeVC.setSubject("Music Video App Feedback")
        mailComposeVC.setMessageBody("Hi Stevie,\n\nI would like to share the following feedback...\n", isHTML: false)
        return mailComposeVC
    }
    
    func mailAlert() {
        
        let alertController: UIAlertController = UIAlertController(title: "Alert", message: "No e-mail on phone!", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "ok", style: .Default) {
            action -> Void in
            // do something you want
        }
        
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Mail cancelled")
        case MFMailComposeResultSaved.rawValue:
            print("Mail saved")
        case MFMailComposeResultSent.rawValue:
            print("Mail sent")
        case MFMailComposeResultFailed.rawValue:
            print("Mail failed")
        default:
            print("Unknown issue")
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
}

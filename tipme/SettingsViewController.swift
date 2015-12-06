//
//  SettingsViewController.swift
//  tipme
//
//  Created by WUSTL STS on 12/4/15.
//  Copyright © 2015 jinseokpark. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController {

    @IBOutlet weak var lowSlider: UISlider!
    @IBOutlet weak var highSlider: UISlider!
    @IBOutlet weak var lowPerc: UILabel!
    @IBOutlet weak var highPerc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lowPerc.text = String(format: "%.f%%", lowBound*100)
        highPerc.text = String(format: "%.f%%", highBound*100)
        
        lowSlider.value = Float(lowBound / 0.5)
        highSlider.value = Float(highBound / 0.5)

        lowPerc.center.x = CGFloat(lowSlider.value) * (self.view.frame.width - 72) + 36
        highPerc.center.x = CGFloat(highSlider.value) * (self.view.frame.width - 72) + 36

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func lowerSliderChanged(sender: UISlider) {
        
        lowPerc.center.x = CGFloat(sender.value) * (self.view.frame.width - 72) + 36
        
        lowPerc.text = String(format: "%.f%%", lowSlider.value * 50)
        
        lowBound = Double(sender.value) / 2
        
        if lowSlider.value >= highSlider.value - 0.1 {
            if highSlider.value == 1 {
                lowBound = 0.45
                lowSlider.value = 0.9
                lowPerc.center.x = CGFloat(lowSlider.value) * (self.view.frame.width - 72) + 36
                lowPerc.text = String(format: "%.f%%", lowSlider.value * 50)
            }
            else {
                highBound = lowBound + 0.05
                highSlider.value = lowSlider.value + 0.1
                highPerc.center.x = CGFloat(highSlider.value) * (self.view.frame.width - 72) + 36
                highPerc.text = String(format: "%.f%%", highSlider.value * 50)
            }

        }
    }
    
    @IBAction func higherSliderChanged(sender: UISlider) {
        
        highPerc.center.x = CGFloat(sender.value) * (self.view.frame.width - 72) + 36
        
        highPerc.text = String(format: "%.f%%", highSlider.value * 50)
        
        highBound = Double(sender.value) / 2

        if highSlider.value <= lowSlider.value + 0.1 {
            if lowSlider.value == 0 {
                highBound = 0.05
                highSlider.value = 0.1
                highPerc.center.x = CGFloat(highSlider.value) * (self.view.frame.width - 72) + 36
                highPerc.text = String(format: "%.f%%", highSlider.value * 50)
            }
            else {
                lowBound = highBound - 0.05
                lowSlider.value = highSlider.value - 0.1
                lowPerc.center.x = CGFloat(lowSlider.value) * (self.view.frame.width - 72) + 36
                lowPerc.text = String(format: "%.f%%", lowSlider.value * 50)
            }
        }
        

    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

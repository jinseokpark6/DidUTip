//
//  ViewController.swift
//  tipme
//
//  Created by WUSTL STS on 12/4/15.
//  Copyright © 2015 jinseokpark. All rights reserved.
//

import UIKit

var lowBound = 0.1
var highBound = 0.2


class ViewController: UIViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var thumbsImageView: UIImageView!
    @IBOutlet weak var leastLabel: UILabel!
    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var mostLabel: UILabel!
    @IBOutlet weak var tipPLabel: UILabel!
    @IBOutlet weak var belowView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.inputTextField.becomeFirstResponder()
        
        totalAmountLabel.text = "$0.00"
        totalAmountLabel.alpha = 0
        tipAmountLabel.alpha = 0
        thumbsImageView.alpha = 0
        tipSlider.alpha = 0
        leastLabel.alpha = 0
        middleLabel.alpha = 0
        mostLabel.alpha = 0
        belowView.alpha = 0
        tipPLabel.alpha = 0
        
        leastLabel.text = String(format:"%.0f%%", lowBound*100)
        middleLabel.text = String(format:"%.0f%%", (lowBound+highBound)*50)
        mostLabel.text = String(format:"%.0f%%", highBound*100)
        tipPLabel.center.x = CGFloat(tipSlider.value) * (self.view.frame.width - 72) + 36
        tipPLabel.text = "15%"
        
        self.thumbsImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/2))
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir Next", size: 22)!]
        

    }
    
    override func viewWillAppear(animated: Bool) {

//        self.inputTextField.becomeFirstResponder()
//        
//        totalAmountLabel.text = "$0.00"
//        totalAmountLabel.alpha = 0
//        tipAmountLabel.alpha = 0
//        thumbsImageView.alpha = 0
//        tipSlider.alpha = 0
//        leastLabel.alpha = 0
//        middleLabel.alpha = 0
//        mostLabel.alpha = 0
//        belowView.alpha = 0
//        
        leastLabel.text = String(format:"%.0f%%", lowBound*100)
        middleLabel.text = String(format:"%.0f%%", (lowBound+highBound)*50)
        mostLabel.text = String(format:"%.0f%%", highBound*100)
        
        let percent = Double(tipSlider.value) * (highBound-lowBound) + lowBound

        let amountValue = inputTextField.text!._bridgeToObjectiveC().doubleValue
        let tipValue = amountValue * percent
        let total = amountValue * (percent + 1)
        totalAmountLabel.text = String(format:"$%.2f", total)
        tipAmountLabel.text = String(format:"%.2f", tipValue)
        tipPLabel.text = String(format:"%.0f%%", 100 * (lowBound + (highBound-lowBound) * Double(tipSlider.value)))

//
//
//        self.thumbsImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/2))
//        
//        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir Next", size: 22)!]

        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tipEditingChanged(sender: AnyObject) {
        
        if let amount = inputTextField.text {
            print("hi")
            if amount == "" {
                deanimate()
            }
            else {
                if inputTextField.center.y == 150 {
                    animate()
                }
                
                let percent = Double(tipSlider.value) * (highBound-lowBound) + lowBound
                
                let amountValue = amount._bridgeToObjectiveC().doubleValue
                let tipValue = amountValue * percent
                let total = amountValue * Double(percent + 1)
                
                totalAmountLabel.text = String(format:"$%.2f", total)
                tipAmountLabel.text = String(format:"%.2f", tipValue)

            }
        }
    }

    @IBAction func slideTip(sender: UISlider) {
        
        self.inputTextField.resignFirstResponder()

        
        if let amount = Double(inputTextField.text!) {
            
            // limits the percentage of tips
            
            let percent = Double(sender.value) * (highBound-lowBound) + lowBound
            
            let currValue = (Double(percent) + 1) * (amount)
            let tipValue = amount * Double(percent)
            totalAmountLabel.text = String(format:"$%.2f", currValue)
            tipAmountLabel.text = String(format:"%.2f", tipValue)
        }
        
        UIView.animateWithDuration(0.1) { () -> Void in
            
            print(sender.value)
            
            self.thumbsImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI)*CGFloat(1 - sender.value))
        }
        
        tipPLabel.center.x = CGFloat(sender.value) * (self.view.frame.width - 72) + 36
        tipPLabel.text = String(format:"%.0f%%", 100 * (lowBound + (highBound-lowBound) * Double(sender.value)))

    }
    
    func animate() {
        
        UIView.animateWithDuration(0.5) { () -> Void in
            
            self.inputTextField.center.y -= 48
            self.totalAmountLabel.alpha = 1
            self.tipAmountLabel.alpha = 1
            self.thumbsImageView.alpha = 1
            self.tipSlider.alpha = 1
            self.leastLabel.alpha = 1
            self.middleLabel.alpha = 1
            self.mostLabel.alpha = 1
            self.belowView.alpha = 1
            self.tipPLabel.alpha = 1

        }
    }
    
    func deanimate() {
        
        UIView.animateWithDuration(0.5) { () -> Void in
            
            self.inputTextField.center.y += 48
            self.totalAmountLabel.alpha = 0
            self.tipAmountLabel.alpha = 0
            self.thumbsImageView.alpha = 0
            self.tipSlider.alpha = 0
            self.leastLabel.alpha = 0
            self.middleLabel.alpha = 0
            self.mostLabel.alpha = 0
            self.belowView.alpha = 0
            self.tipPLabel.alpha = 0

        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
}


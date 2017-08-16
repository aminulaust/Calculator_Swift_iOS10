//
//  ViewController.swift
//  SwiftCalculator
//
//  Created by Appcelerator on 8/16/17.
//  Copyright © 2017 Appcelerator. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        outputLbl.text = "0"
        
    }
    func playSound() {
        if btnSound.playing{
            btnSound.stop()
        }
        
        btnSound.play()
    }
    

    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    
    
    @IBAction func divPressed(sender: AnyObject) {
            processOperation(.Divide)
        
    }
    
    
    @IBAction func mulPressed(sender: AnyObject) {
         processOperation(.Multiply)
        
    }
    
    
    @IBAction func addPressed(sender: AnyObject) {
             processOperation(.Add)
        
    }
    
    
    @IBAction func subPressed(sender: AnyObject) {
          processOperation(.Subtract)
        
    }
    
    
    @IBAction func eqaPressed(sender: AnyObject) {
         processOperation(currentOperation)
        
    }
    
    
    @IBAction func clearPressed(sender: AnyObject) {
         outputLbl.text = "0"
         currentOperation = Operation.Empty
         runningNumber = ""
         leftValStr = ""
         rightValStr = ""
         result = ""
         playSound()
    
    }
    
    func processOperation(operation: Operation) {
       playSound()
        if currentOperation != Operation.Empty {
            //A user selected an operator, but then selected another operator without first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
        } else {
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }

    
  
}


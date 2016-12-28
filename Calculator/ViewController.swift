//
//  ViewController.swift
//  Calculator
//
//  Created by Jeffrey Chan on 12/27/16.
//  Copyright © 2016 Jeffrey Chan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    private var userIsTyping = false
    private var hasDecimalPoint = false
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        let textInDisplay = display.text!
        
        if userIsTyping {
            display.text = textInDisplay + digit
        } else {
            display.text = digit
            userIsTyping = true
        }
    }
    
    @IBAction func addDecimal() {
        if !hasDecimalPoint {
            let textInDipslay = display.text!
            if userIsTyping {
                display.text = textInDipslay + "."
            } else {
                display.text = "0."
                userIsTyping = true
                hasDecimalPoint = true
            }
        }
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsTyping {
            brain.setOperand(operand: displayValue)
            userIsTyping = false
            hasDecimalPoint = false
        }
        if let mathSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathSymbol)
        }
        displayValue = brain.result
    }
    
    @IBAction func clearDisplay() {
        display.text = String(0)
        userIsTyping = false
        hasDecimalPoint = false
        brain.clear()
    }
}


//
//  printOnDebug.swift
//  Edvora
//
//  Created by TeCh_SavVy on 18/04/22.
//


import Foundation

/// print on debug mode
/// - Parameter message: Message To Print
/// 
func printOnDebug(_ message: Any){
    #if DEBUG
    print(message)
    #else
    #endif
}


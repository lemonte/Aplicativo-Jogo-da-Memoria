//
//  Array+Only.swift
//  Memorizando
//
//  Created by Geanderson Lemonte on 13/06/21.
//

import Foundation


extension Array {
    var only: Element? {
        count == 1 ? first : nil 
    }
}

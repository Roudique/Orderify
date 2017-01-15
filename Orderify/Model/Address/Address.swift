//
//  Address.swift
//  Orderify
//
//  Created by Roudique on 1/9/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import Foundation

struct Address {
    var firstName   : String
    var lastName    : String
    
    var address1    : String
    var address2    : String?
    var city        : String?
    var zip         : String?
    var province    : String?
    var country     : String
    
    var countryCode  : String
    var provinceCode : String
    
    var phoneNumber : String?
}

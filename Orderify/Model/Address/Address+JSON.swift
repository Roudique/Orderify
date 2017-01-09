//
//  Address+JSON.swift
//  Orderify
//
//  Created by Roudique on 1/9/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Address : JSONInitializable {
    
    init?(json: JSON) {
        let firstName   = json["first_name"].string
        let lastName    = json["last_name"].string
        
        let address1    = json["address1"].string
        let country     = json["country"].string
        
        let countryCode  = json["country_code"].string
        let provinceCode = json["province_code"].string
        
        if let firstName = firstName, let lastName = lastName, let address1 = address1, let country = country, let countryCode = countryCode, let provinceCode = provinceCode {
            self.firstName  = firstName
            self.lastName   = lastName
            
            self.address1   = address1
            self.address2   = json["address2"].string
            self.city       = json["city"].string
            self.zip        = json["zip"].string
            self.province   = json["province"].string
            self.country    = country
            
            self.countryCode  = countryCode
            self.provinceCode = provinceCode
        } else {
            return nil
        }
    }
}



//
//  URLSchemeType.swift
//  Github-API
//
//  Created by 豊岡正紘 on 2020/09/18.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import Foundation

enum URLSchemeType: String {
    case phone = "tel"
    case email = "mailto"
    
    init?(scheme: String?) {
        guard let value = scheme else {
            return nil
        }
        
        switch value {
        case "tel":
            self = .phone
        case "mailto":
            self = .email
        default:
            return nil
            
        }
    }
}

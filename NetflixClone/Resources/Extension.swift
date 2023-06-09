//
//  Extension.swift
//  NetflixClone
//
//  Created by BS1095 on 1/6/23.
//

import Foundation

extension String{    //any datatype can have extend function
    
    func capitalizeFirstLetter()->String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

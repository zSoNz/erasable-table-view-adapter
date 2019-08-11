//
//  SectionImages.swift
//  TableAdapter
//
//  Created by Bogdan Kikacheishvili on 8/11/19.
//  Copyright © 2019 Bendis. All rights reserved.
//

import UIKit

public struct SectionImage {
    
    public let view: UIView?
    public let height: CGFloat
    
    public init(view: UIView?, height: CGFloat) {
        self.view = view
        self.height = height
    }
}

public struct SectionImages {
    
    public let header: SectionImage?
    public let footer: SectionImage?
    
    public init(header: SectionImage? = nil, footer: SectionImage? = nil) {
        self.header = header
        self.footer = footer
    }
}

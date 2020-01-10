//
//  SectionDelimetrs.swift
//  TableAdapter
//
//  Created by Bogdan Kikacheishvili on 8/11/19.
//  Copyright © 2019 Bendis. All rights reserved.
//

import UIKit

public struct SectionDelimetr {
    
    public let view: UIView?
    public let height: CGFloat
    
    public init(view: UIView?, height: CGFloat) {
        self.view = view
        self.height = height
    }
}

public struct SectionDelimetrs {
    
    public let header: SectionDelimetr?
    public let footer: SectionDelimetr?
    
    public init(header: SectionDelimetr? = nil, footer: SectionDelimetr? = nil) {
        self.header = header
        self.footer = footer
    }
}

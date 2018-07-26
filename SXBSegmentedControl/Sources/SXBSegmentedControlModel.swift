//
//  SXBSegmentedControlModel.swift
//  Pods
//
//  Created by dev_min on 2018/7/25.
//

import UIKit

public struct ElegantSlideMenuDto {
    /** 对应标签标题 */
    public var title: String!
    /** 对应标签视图 */
    public var view: UIView!
    
    public init() {
        
    }
    
    public init(title: String, view: UIView) {
        self.title = title
        self.view = view
    }
}

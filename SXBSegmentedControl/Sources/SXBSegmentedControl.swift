//
//  SXBSegmentedControl.swift
//  Pods
//
//  Created by dev_min on 2018/7/25.
//

import UIKit

class SXBSegmentedControl: UIView {
    
    /** 顶部标签视图背景色 */
    public var topViewBackgroundColor: UIColor = UIColor.white {
        didSet {
            self.topScrollView.backgroundColor = topViewBackgroundColor
        }
    }
    /** 标签按钮间隔，默认10 */
    public var itemSpace: CGFloat = 10
    /** 所有的标签数组 */
    public var viewArray:[ElegantSlideMenuDto] = [] {
        didSet {
            if viewArray.count > 0 {
                for i in 0..<viewArray.count {
                    let model = viewArray[i]
                    //                    let itemWidth = self.getNormalStrSize(str: <#T##String?#>, attriStr: <#T##NSMutableAttributedString?#>, font: <#T##CGFloat#>, size: <#T##CGSize#>)
                    //                    let itemOffSetX = CGFloat(i)*()
                }
            } else {
                
            }
        }
    }
    /** 标签按钮正常attribute */
    var titleTextAttributes:[NSAttributedStringKey:Any] = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.white] {
        didSet {
            set(attributes: titleTextAttributes, state: .normal)
        }
    }
    /** 选中标签按钮attribute */
    var selectedTitleTextAttributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.blue] {
        didSet {
            set(attributes: selectedTitleTextAttributes, state: .selected)
        }
    }
    
    
    
    /** 顶部标签容器 */
    fileprivate var topScrollView: UIScrollView!
    
    public init(frame: CGRect, items: [ElegantSlideMenuDto]) {
        self.viewArray = items
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(attributes:[NSAttributedStringKey: Any], state: UIControlState) {
        for btn in topScrollView.subviews {
            if let btn = btn as? UIButton, let title = btn.title(for: state) {
                let titleAttributed = NSAttributedString(string: title, attributes: attributes)
                btn.setAttributedTitle(titleAttributed, for: state)
            }
        }
    }
    
    /** 创建标签按钮 */
    //    func buidBtn(title: String, tag: Int) {
    //        let buttont = UIButton(type: UIButtonType.custom)
    //        buttont.tag = tag
    //        buttont.titleLabel!.font = autoAdjustFontSize(fontSize: itemFontSize)
    //        buttont.setTitle(title, for: UIControlState.normal)
    //        buttont.setTitleColor(tabItemNormalTitleColor, for: UIControlState.normal)
    //        buttont.setTitleColor(tabItemSelectedTitleColor, for: UIControlState.selected)
    //        buttont.addTarget(self, action: #selector(ElegantSlideMenuView.selectedNameButton(sender:)), for: UIControlEvents.touchUpInside)
    //        if tag == defaultSelectedIndex{
    //            buttont.isSelected = true
    //        }else{
    //            buttont.isSelected = false
    //        }
    //        if buttont.isSelected{
    //            buttont.backgroundColor = tabItemSelectedBackgroundColor
    //        }else{
    //            buttont.backgroundColor = tabItemNormalBackgroundColor
    //        }
    //        btns.append(buttont)
    //        topScrollView.addSubview(buttont)
    
}

extension SXBSegmentedControl {
    /** 计算字符串的尺寸 */
    private func getNormalStrSize(str: String? = nil, attriStr: NSMutableAttributedString? = nil, font: CGFloat, size:CGSize) -> CGSize {
        //        if str != nil {
        //            let strSize = (str! as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: font)], context: nil).size
        //            return strSize
        //        }
        
        if attriStr != nil {
            let strSize = attriStr!.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil).size
            return strSize
        }
        
        return CGSize.zero
    }
    
    
}




/** 滚动条位置 */
public enum UnderLinePosition{
    case top
    case bottom
}

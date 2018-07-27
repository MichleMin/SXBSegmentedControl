//
//  SXBSegmentedControl.swift
//  Pods
//
//  Created by dev_min on 2018/7/25.
//

import UIKit

@objc public class SXBSegmentedControl: UIView {
    
    /** 顶部标签视图背景色 */
    @IBInspectable
    public var topViewBackgroundColor: UIColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1) {
        didSet {
            self.topScrollView.backgroundColor = topViewBackgroundColor
        }
    }
    /** 标滚动指示器填充样式，默认true */
    @IBInspectable
    public var indicatorWidthStyle: SelectionIndicatorWidthStyle = .custom
    /** 顶部标签视图高度,默认高度 50 */
    @IBInspectable
    public var topScrollViewHeight: CGFloat = 40
    /** 顶部标签视图是否可滚动,默认 true */
    @IBInspectable
    public var topScrollViewIsScrolled: Bool = true {
        didSet {
            topScrollView.isScrollEnabled = topScrollViewIsScrolled
        }
    }
    /** 自定义标签按钮宽度，默认50 */
    @IBInspectable
    public var itemWidth: CGFloat = 50
    /** 标签按钮间隔，默认10 */
    @IBInspectable
    public var itemSpace: CGFloat = 10
    /** 所有的标签数组 */
    public var viewArray: [SXBSegmentedControlModel] = [] {
        didSet {
            setupScrollView()
            self.isVCType = false
        }
    }
    public var vcArr: [UIViewController] = [] {
        didSet {
            var modelArray = [SXBSegmentedControlModel]()
            for vc in vcArr {
                let model = SXBSegmentedControlModel(title: vc.title ?? "", view: vc.view)
                modelArray.append(model)
            }
            viewArray = modelArray
            self.isVCType = true
        }
    }
    /** 标签按钮正常attribute */
    public var titleTextAttributes:[NSAttributedStringKey:Any] = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor(red: 68/255.0, green: 68/255.0, blue: 68/255.0, alpha: 1)] {
        didSet {
            set(attributes: titleTextAttributes, state: .normal)
        }
    }
    /** 选中标签按钮attribute */
    public var selectedTitleTextAttributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor(red: 35/255.0, green: 173/255.0, blue: 228/255.0, alpha: 1)] {
        didSet {
            set(attributes: selectedTitleTextAttributes, state: .selected)
        }
    }
    /** 默认选中tap index，从 0 开始，默认 0 */
    public var defaultIndex: Int = 0 {
        didSet {
            currentIndex = defaultIndex
            rootScrollView.contentOffset = CGPoint(x: CGFloat(defaultIndex)*self.frame.size.width, y: 0)
        }
    }
    /** 滚动条位置，默认 bottom */
    @IBInspectable
    public var scrollBarPosition: ScrollBarPosition = .bottom
    /** 滚动条颜色 */
    @IBInspectable
    public var scrollBarColor: UIColor = UIColor(red: 35/255.0, green: 173/255.0, blue: 228/255.0, alpha: 1) {
        didSet {
            scrollBar.backgroundColor = scrollBarColor
        }
    }
    /** 更新当前页面数据，回传当前界面的索引值。*/
    public var refreshDataBlock: ((_ index: Int)->Void)?
    
    
    
    
    /** 顶部标签容器 */
    fileprivate var topScrollView: UIScrollView!
    /** 所有标签按钮 */
    fileprivate var btnArray: [UIButton] = []
    /** 主视图容器 */
    fileprivate var rootScrollView: UIScrollView!
    /** 滚动条 */
    fileprivate var scrollBar: UIView!
    fileprivate var itemOffSetXArray: [CGFloat] = []
    fileprivate var itemWidthArray: [CGFloat] = []
    /** 索引值数组 */
    fileprivate var selectedIndexs: [Int] = []
    /** 当前选中的tap的索引 */
    fileprivate var currentIndex: Int = 0
    /** 传入数组类型 */
    fileprivate var isVCType:Bool = false
    
    public init(frame:CGRect,
                items: [SXBSegmentedControlModel],
                itemSpace: CGFloat=10,
                itemWidth: CGFloat=50,
                topScrollViewHeight: CGFloat=40,
                scrollBarPosition: ScrollBarPosition=ScrollBarPosition.bottom,
                indicatorWidthStyle: SelectionIndicatorWidthStyle=SelectionIndicatorWidthStyle.custom) {
        super.init(frame: frame)
        self.viewArray = items
        self.topScrollViewHeight = topScrollViewHeight
        self.indicatorWidthStyle = indicatorWidthStyle
        self.itemWidth = itemWidth
        self.scrollBarPosition = scrollBarPosition
        self.isVCType = false
        setupScrollView()
    }
    
    public init(frame:CGRect,
                vcArr: [UIViewController],
                itemSpace: CGFloat=10,
                itemWidth: CGFloat=50,
                topScrollViewHeight: CGFloat=40,
                scrollBarPosition: ScrollBarPosition=ScrollBarPosition.bottom,
                indicatorWidthStyle: SelectionIndicatorWidthStyle=SelectionIndicatorWidthStyle.custom) {
        super.init(frame: frame)
        self.topScrollViewHeight = topScrollViewHeight
        self.indicatorWidthStyle = indicatorWidthStyle
        self.itemWidth = itemWidth
        self.scrollBarPosition = scrollBarPosition
        self.vcArr = vcArr
        self.isVCType = false
        setupScrollView()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public override func layoutSubviews() {
        setupScrollView()
    }
    
}

/// 私有方法
extension SXBSegmentedControl {
    
    /** 布局上下两个scrollview */
    private func setupScrollView() {
        _ = self.subviews.map{$0.removeFromSuperview()}
        topScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: topScrollViewHeight))
        topScrollView.isPagingEnabled = false
        topScrollView.backgroundColor = topViewBackgroundColor
        topScrollView.showsVerticalScrollIndicator = false
        topScrollView.showsHorizontalScrollIndicator = false
        topScrollView.delegate = self
        self.addSubview(topScrollView)
        
        rootScrollView = UIScrollView(frame: CGRect(x: 0, y: topScrollViewHeight, width: self.frame.size.width, height: self.frame.size.height-topScrollViewHeight))
        rootScrollView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        rootScrollView.isPagingEnabled = true
        rootScrollView.showsHorizontalScrollIndicator = false
        rootScrollView.showsVerticalScrollIndicator = false
        rootScrollView.bounces = false
        rootScrollView.delegate = self
        self.addSubview(rootScrollView)
        setupSubViews()
    }
    
    /** 布局 */
    private func setupSubViews() {
        /// 修复重复添加子 view
        _ = rootScrollView.subviews.map {$0.removeFromSuperview()}
        _ = topScrollView.subviews.map {$0.removeFromSuperview()}
        itemOffSetXArray.removeAll()
        itemWidthArray.removeAll()
        
        let width = self.frame.size.width
        let height = self.frame.size.height
        let count = CGFloat(viewArray.count)
        
        var itemOffSetX: CGFloat = 0
        var itemWidth: CGFloat = 0
        if viewArray.count > 0 {
            for i in 0..<viewArray.count {
                let model = viewArray[i]
                if i == 0 {
                    itemOffSetX = 10
                } else {
                    itemOffSetX = itemOffSetX + itemWidth + itemSpace
                }
                if indicatorWidthStyle == .equal {
                    itemWidth = (width-itemSpace*(count-1))/count
                } else if indicatorWidthStyle == .dynamic {
                    let attriStr = NSAttributedString(string: model.title, attributes: titleTextAttributes)
                    itemWidth = getNormalStrSize(attriStr: attriStr, size: CGSize(width: 1000, height: topScrollViewHeight)).width+10
                } else {
                    itemWidth = self.itemWidth
                }
                itemOffSetXArray.append(itemOffSetX)
                itemWidthArray.append(itemWidth)
                let itemOffSetY: CGFloat = scrollBarPosition == .bottom ? 0:2
                let frame = CGRect(x: itemOffSetX, y: itemOffSetY, width: itemWidth, height: topScrollViewHeight-2)
                setupBtn(title: model.title, frame: frame, tag: i)
                let rootViewOffSeX = CGFloat(i)*width
                model.view.frame.origin = CGPoint(x: rootViewOffSeX, y: 0)
                model.view.frame.size = CGSize(width: width, height: height-topScrollViewHeight)
                rootScrollView.addSubview(model.view)
            }
        } else {
            
        }
        caclutaTopScrollViewSize(widthArr: itemWidthArray)
        rootScrollView.contentSize = CGSize(width: width*CGFloat(viewArray.count), height: 0)
        // 设置默认选中tap index 不为 0 时，使 rootScrollView 偏移
        rootScrollView.contentOffset = CGPoint(x: CGFloat(defaultIndex)*width, y: 0)
        createScrollBar()
    }
    
    /** 创建滚动条 */
    func createScrollBar() {
        scrollBar = UIView()
        let x = itemOffSetXArray[defaultIndex]
        let y = scrollBarPosition == .bottom ? topScrollViewHeight-2:0
        scrollBar = UIView(frame: CGRect(x: x, y: y, width: itemWidthArray[defaultIndex], height: 1.5))
        scrollBar.backgroundColor = scrollBarColor
        topScrollView.addSubview(scrollBar)
    }
    
    /** 创建标签按钮 */
    private func setupBtn(title: String, frame: CGRect, tag: Int) {
        let buttont = UIButton(type: UIButtonType.custom)
        buttont.frame = frame
        buttont.tag = tag
        buttont.setTitle(title, for: UIControlState.normal)
        let attriStr = NSAttributedString(string: title, attributes: titleTextAttributes)
        buttont.setAttributedTitle(attriStr, for: .normal)
        let selectedAttriStr = NSAttributedString(string: title, attributes: selectedTitleTextAttributes)
        buttont.setAttributedTitle(selectedAttriStr, for: .selected)
        buttont.addTarget(self, action: #selector(btnAction(sender:)), for: .touchUpInside)
        if tag == defaultIndex{
            buttont.isSelected = true
        }else{
            buttont.isSelected = false
        }
        btnArray.append(buttont)
        topScrollView.addSubview(buttont)
    }
    
    private func set(attributes:[NSAttributedStringKey: Any], state: UIControlState) {
        for btn in btnArray {
            if let title = btn.title(for: state) {
                let titleAttributed = NSAttributedString(string: title, attributes: attributes)
                btn.setAttributedTitle(titleAttributed, for: state)
            }
        }
    }
    
    /** 计算字符串的尺寸 */
    private func getNormalStrSize(attriStr: NSAttributedString, size:CGSize) -> CGSize {
        let strSize = attriStr.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil).size
        return strSize
    }
    
    private func caclutaTopScrollViewSize(widthArr: [CGFloat]) {
        var totalWidth: CGFloat = 0
        for width in widthArr {
            totalWidth += width
        }
        topScrollView.contentSize = CGSize(width: totalWidth+CGFloat(viewArray.count-1)*itemSpace+20, height: 0)
    }
    
    /** 选中按钮时，所要执行的动作 */
    @objc private func btnAction(sender: UIButton) {
        rootScrollView.setContentOffset(CGPoint(x: CGFloat(sender.tag)*self.frame.size.width, y: 0), animated: false)
        if !selectedIndexs.contains(sender.tag) && currentIndex != sender.tag {
            currentIndex = sender.tag
            selectedIndexs.append(sender.tag)
            if let refreshDataBlock = refreshDataBlock {
                refreshDataBlock(currentIndex)
            }
        }
        scrollBar.frame.origin.x = itemOffSetXArray[currentIndex]
        scrollBar.frame.size.width = itemWidthArray[currentIndex]
        btnArray.forEach({ (btn) in
            if btn.tag != sender.tag{
                btn.isSelected = false
            }else{
                btn.isSelected = true
            }
        })
        if isVCType {
            vcArr[currentIndex].viewDidAppear(true)
        }
    }
    
}

extension SXBSegmentedControl: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = self.frame.size.width
        if scrollView == rootScrollView {
            let indexFloat = scrollView.contentOffset.x/width
            currentIndex = Int(indexFloat)
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        if scrollView == rootScrollView {
            scrollBar.frame.origin.x = itemOffSetXArray[currentIndex]
            scrollBar.frame.size.width = itemWidthArray[currentIndex]
            btnArray.forEach({ (btn) in
                if btn.tag != currentIndex{
                    btn.isSelected = false
                }else{
                    btn.isSelected = true
                }
            })
            if !selectedIndexs.contains(currentIndex) {
                selectedIndexs.append(currentIndex)
                if let refreshDataBlock = refreshDataBlock {
                    refreshDataBlock(currentIndex)
                }
            }
            if isVCType {
                vcArr[currentIndex].viewDidAppear(true)
            }
        }
    }
}


/** 滚动条位置 */
@objc public enum ScrollBarPosition: Int{
    case top
    case bottom
}

/** 滚动指示器填充样式 */
@objc public enum SelectionIndicatorWidthStyle: Int{
    case dynamic /// 根据文字长度来适配
    case equal  /// 根据整个顶部容器宽度计算每个item的宽度
    case custom /// 自定义item的宽度
}

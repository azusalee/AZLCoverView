import UIKit

/**
蒙版视图

可以添加镂空
 */
open class AZLCoverView: UIView {
    
    /// 镂空路径
    var hollowPaths: [UIBezierPath] = []
    
    /// 镂空部分是否会穿透点击事件
    public var isThroughHollow = true
    
    /// 添加方形镂空范围
    /// 
    /// 镂空部分不处理点击事件(也就是点击镂空部分会穿透到下一层)
    /// - Parameters:
    ///   - frame: 镂空范围
    ///   - inset: 增加上下左右镂空范围
    public func addHollow(frame: CGRect, inset: UIEdgeInsets = .zero) {
        let insetFrame = CGRect.init(x: frame.origin.x-inset.left, y: frame.origin.y-inset.top, width: frame.size.width+inset.left+inset.right, height: frame.size.height+inset.top+inset.bottom)
        let path = UIBezierPath.init(rect: insetFrame).reversing()
        self.hollowPaths.append(path)
        
        self.setNeedsLayout()
    }
    
    /// 添加圆形镂空范围
    /// - Parameters:
    ///   - center: 中心点
    ///   - radius: 半径
    public func addHollow(center: CGPoint, radius: CGFloat) {
        let path = UIBezierPath.init(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: false)
        self.hollowPaths.append(path)
        self.setNeedsLayout()
    }
    
    /// 清空所有镂空范围
    public func clearHollow() {
        self.hollowPaths.removeAll()
        self.setNeedsLayout()
    }
    
    /// 更新镂空视图
    func updateHollow() {
        let layerPath = UIBezierPath.init(rect: self.bounds)
        for path in self.hollowPaths {
            layerPath.append(path)
        }
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = layerPath.cgPath
        
        self.layer.mask = maskLayer
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.updateHollow()
    }
    
    // 拦截点击，做到点击穿透
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isThroughHollow {
            for path in self.hollowPaths {
                if path.contains(point) {
                    // 传回空代表不处理
                    return nil
                }
            }
        }
        
        return super.hitTest(point, with: event)
    }
    
}

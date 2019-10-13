// 责任链模式
// 百度百科：在责任链模式里，很多对象由每一个对象对其下家的引用而连接起来形成一条链。请求在这个链上传递，直到链上的某一个对象决定处理此请求。发出这个请求的客户端并不知道链上的哪一个对象最终处理这个请求，这使得系统可以在不影响客户端的情况下动态地重新组织和分配责任。
// 设计模式分类：行为型模式

/// 钱堆
class MoneyPile {
    /// 价值
    let value: Int
    /// 数量
    var quantity: Int
    /// 下一堆
    var nextPile: MoneyPile?
    
    /**
     初始化
     
     - parameter value:    价值
     - parameter quantity: 数量
     - parameter nextPile: 下一堆
     
     - returns: 堆对象
     */
    init(value: Int, quantity: Int, nextPile: MoneyPile?) {
        self.value = value
        self.quantity = quantity
        self.nextPile = nextPile
    }
    
    /**
     判断是否可以提取
     
     - parameter value: 提取值
     
     - returns: true 可以， false 不行
     */
    func canWithdraw(value: Int) -> Bool {
        
        var v = value
        
        func canTakeSomeBill(want: Int) -> Bool {
            return (want / self.value) > 0
        }
        
        var q = self.quantity
        
        while canTakeSomeBill(v) {
            
            if q == 0 {
                break
            }
            
            v -= self.value
            q -= 1
        }
        
        if v == 0 {
            return true
        } else if let next = self.nextPile {
            return next.canWithdraw(v)
        }
        
        return false
    }
}

/// ATM取款机
class ATM {
        /// 100元堆
    private var hundred: MoneyPile
        /// 50元堆
    private var fifty: MoneyPile
        /// 20元堆
    private var twenty: MoneyPile
        /// 10元堆
    private var ten: MoneyPile
    
    private var startPile: MoneyPile {
        return self.hundred
    }
    
    /**
     初始化
     
     - parameter hundred: 100元堆
     - parameter fifty:   50元堆
     - parameter twenty:  20元堆
     - parameter ten:     10元堆
     
     - returns: atm对象
     */
    init(hundred: MoneyPile,
         fifty: MoneyPile,
         twenty: MoneyPile,
         ten: MoneyPile) {
        
        self.hundred = hundred
        self.fifty = fifty
        self.twenty = twenty
        self.ten = ten
    }
    
    /**
     判断是否可以提取
     
     - parameter value: 提取值
     
     - returns: true 可以， false 不行
     */
    func canWithdraw(value: Int) -> String {
        return "Can withdraw: \(self.startPile.canWithdraw(value))"
    }
}

// 创建一些钱堆， 并将它们链接在一起
let ten = MoneyPile(value: 10, quantity: 6, nextPile: nil)
let twenty = MoneyPile(value: 20, quantity: 2, nextPile: ten)
let fifty = MoneyPile(value: 50, quantity: 2, nextPile: twenty)
let hundred = MoneyPile(value: 100, quantity: 1, nextPile: fifty)

// 创建atm对象
var atm = ATM(hundred: hundred, fifty: fifty, twenty: twenty, ten: ten)

atm.canWithdraw(310) // false atm只有300
atm.canWithdraw(100) // true 100*1
atm.canWithdraw(165) // false atm没有面值5
atm.canWithdraw(30)  // true 20*1 + 10*1

// 解释器模式
// 百度百科：给定一个语言，定义它的文法的一种表示，并定义一个解释器，这个解释器使用该表示来解释语言中的句子
// 设计模式分类：行为型模式

/**
 *  表达式接口
 */
protocol IntegerExp {
    /**
     取值
     
     - parameter context: 上下文
     
     - returns: 值
     */
    func evaluate(context: IntegerContext) -> Int
    /**
     替换
     
     - parameter character:  字符
     - parameter integerExp: 表达式
     
     - returns: <#return value description#>
     */
    func replace(character: Character, integerExp: IntegerExp) -> IntegerExp
    /**
     复制
     
     - returns: 表达式
     */
    func copy() -> IntegerExp
}

/// 上下文
class IntegerContext {
    /// 数据字典
    private var data: [Character:Int] = [:]
    
    /**
     查找
     
     - parameter name: 字符
     
     - returns: 字符代表的值
     */
    func lookup(name: Character) -> Int {
        return self.data[name]!
    }
    
    /**
     分配值
     
     - parameter integerVarExp: 变量表达式
     - parameter value:         值
     */
    func assign(integerVarExp: IntegerVarExp, value: Int) {
        self.data[integerVarExp.name] = value
    }
}

/// 变量表达式
class IntegerVarExp: IntegerExp {
    let name: Character
    
    init(name: Character) {
        self.name = name
    }
    
    func evaluate(context: IntegerContext) -> Int {
        return context.lookup(self.name)
    }
    
    func replace(name: Character, integerExp: IntegerExp) -> IntegerExp {
        if name == self.name {
            return integerExp.copy()
        } else {
            return IntegerVarExp(name: self.name)
        }
    }
    
    func copy() -> IntegerExp {
        return IntegerVarExp(name: self.name)
    }
}

/// 加表达式
class AddExp: IntegerExp {
        /// 操作数1
    private var operand1: IntegerExp
        /// 操作数2
    private var operand2: IntegerExp
    
    init(op1: IntegerExp, op2: IntegerExp) {
        self.operand1 = op1
        self.operand2 = op2
    }
    
    func evaluate(context: IntegerContext) -> Int {
        return self.operand1.evaluate(context) + self.operand2.evaluate(context)
    }
    
    func replace(character: Character, integerExp: IntegerExp) -> IntegerExp {
        return AddExp(op1: operand1.replace(character, integerExp: integerExp),
                      op2: operand2.replace(character, integerExp: integerExp))
    }
    
    func copy() -> IntegerExp {
        return AddExp(op1: self.operand1, op2: self.operand2)
    }
}

/// 减表达式
class SubtractExp: IntegerExp {
    /// 操作数1
    private var operand1: IntegerExp
    /// 操作数2
    private var operand2: IntegerExp
    
    init(op1: IntegerExp, op2: IntegerExp) {
        self.operand1 = op1
        self.operand2 = op2
    }
    
    func evaluate(context: IntegerContext) -> Int {
        return self.operand1.evaluate(context) - self.operand2.evaluate(context)
    }
    
    func replace(character: Character, integerExp: IntegerExp) -> IntegerExp {
        return AddExp(op1: operand1.replace(character, integerExp: integerExp),
                      op2: operand2.replace(character, integerExp: integerExp))
    }
    
    func copy() -> IntegerExp {
        return AddExp(op1: self.operand1, op2: self.operand2)
    }
}

var a = IntegerVarExp(name: "A")
var b = IntegerVarExp(name: "B")
var c = IntegerVarExp(name: "C")

// 创建一个表达式 a - (b + c)
var expression: IntegerExp = SubtractExp(op1: a, op2: AddExp(op1: b, op2: c)) // a - (b + c)

// 创建一个上下文
var intContext = IntegerContext()
intContext.assign(a, value: 2) // a = 2
intContext.assign(b, value: 1) // b = 1
intContext.assign(c, value: 3) // c = 3

// 在上下文环境中执行表达式
var result = expression.evaluate(intContext) // 2 - (1 + 3) = -2

// 状态模式
// 百度百科：允许一个对象在其内部状态改变时改变它的行为。对象看起来似乎修改了它的类
// 设计模式分类：行为型模式

/// 持有状态的对象
class Context {
    private var state: State = UnauthorizedState()
    
    var isAuthorized: Bool {
        get { return state.isAuthorized(self) }
    }
    
    var userId: String? {
        get { return state.userId(self) }
    }
    
    func changeStateToAuthorized(userId userId: String) {
        state = AuthorizedState(userId: userId)
    }
    
    func changeStateToUnauthorized() {
        state = UnauthorizedState()
    }
    
}

/**
 *  状态接口
 */
protocol State {
    func isAuthorized(context: Context) -> Bool
    func userId(context: Context) -> String?
}

/// 未认证状态
class UnauthorizedState: State {
    func isAuthorized(context: Context) -> Bool { return false }
    
    func userId(context: Context) -> String? { return nil }
}

/// 认证状态
class AuthorizedState: State {
    let userId: String
    
    init(userId: String) { self.userId = userId }
    
    func isAuthorized(context: Context) -> Bool { return true }
    
    func userId(context: Context) -> String? { return userId }
}

let context = Context()
(context.isAuthorized, context.userId)
context.changeStateToAuthorized(userId: "admin")
(context.isAuthorized, context.userId) // now logged in as "admin"
context.changeStateToUnauthorized()
(context.isAuthorized, context.userId)

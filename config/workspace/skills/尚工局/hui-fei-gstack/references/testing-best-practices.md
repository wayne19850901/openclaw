# 测试最佳实践

## 测试金字塔

```
      /\
     /  \    E2E测试（少量）
    /----\   
   /      \  集成测试（适量）
  /--------\ 
 /          \ 单元测试（大量）
/------------\
```

### 单元测试
- 测试单个函数/组件
- 快速执行
- 高覆盖率
- 易于维护

### 集成测试
- 测试模块间交互
- 验证接口契约
- 数据库/API测试
- 中等速度

### E2E测试
- 测试完整流程
- 模拟用户行为
- 跨系统验证
- 执行较慢

## 单元测试原则

### FIRST原则
- **Fast**：快速执行
- **Independent**：独立运行
- **Repeatable**：可重复
- **Self-validating**：自验证
- **Timely**：及时编写

### 测试命名
```javascript
// 格式：[被测函数]_[场景]_[预期结果]
describe('calculateTotal', () => {
  it('should return 0 when cart is empty', () => {
    // ...
  });
  
  it('should calculate correct total with multiple items', () => {
    // ...
  });
});
```

### 测试结构
```javascript
describe('功能模块', () => {
  beforeEach(() => {
    // 凋试前准备
  });
  
  afterEach(() => {
    // 测试后清理
  });
  
  it('测试场景', () => {
    // Given: 准备数据
    const input = 'test';
    
    // When: 执行操作
    const result = functionUnderTest(input);
    
    // Then: 验证结果
    expect(result).toBe('expected');
  });
});
```

## Mock与Stub

### Mock使用场景
- 外部依赖（API、数据库）
- 复杂对象创建
- 时间相关操作
- 随机数生成

### Jest Mock示例
```javascript
// 函数Mock
jest.mock('./api', () => ({
  fetchData: jest.fn(() => Promise.resolve({ data: 'mock' })),
}));

// Spy使用
const spy = jest.spyOn(object, 'method');
expect(spy).toHaveBeenCalledWith('arg');
```

## 测试覆盖

### 覆盖率目标
- 单元测试：≥80%
- 关键路径：≥95%
- 新代码：≥90%

### 覆盖类型
- 语句覆盖（Statement）
- 分支覆盖（Branch）
- 函数覆盖（Function）
- 行覆盖（Line）

### 覆盖率报告
```bash
jest --coverage
```

## 测试数据

### 数据工厂
```javascript
function createUser(overrides = {}) {
  return {
    id: 1,
    name: 'Test User',
    email: 'test@example.com',
    ...overrides,
  };
}
```

### Fixtures
- 集中管理测试数据
- 可复用
- 易于维护

## 边界条件测试

### 边界值
- 最小值
- 最大值
- 空值
- 超出范围

### 异常场景
- 网络错误
- 数据格式错误
- 权限不足
- 资源不存在

## 测试工具

### JavaScript/TypeScript
- Jest：主流测试框架
- Mocha：灵活测试框架
- Testing Library：React/Vue测试
- Cypress：E2E测试

### Python
- pytest：主流测试框架
- unittest：标准库
- mock：Mock库

### 其他
- JUnit（Java）
- Go testing（Go）
- XCTest（Swift）
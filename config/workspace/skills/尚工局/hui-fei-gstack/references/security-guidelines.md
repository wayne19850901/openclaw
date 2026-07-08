# 安全开发规范

## 安全原则

### 最小权限原则
- 只授予必要的权限
- 避免过度授权
- 定期审查权限

### 安全默认原则
- 默认配置应安全
- 需要显式开启不安全选项
- 新功能默认安全

### 深度防御原则
- 多层安全措施
- 不依赖单一防护
- 失败时仍有保护

## 输入验证

### 验证原则
- 所有外部输入必须验证
- 白名单优于黑名单
- 验证类型、长度、格式、范围

### 验证示例
```javascript
// 白名单验证
const allowedTypes = ['image', 'video', 'document'];
if (!allowedTypes.includes(input.type)) {
  throw new Error('Invalid type');
}

// 类型验证
if (typeof input.id !== 'number') {
  throw new Error('ID must be number');
}

// 长度验证
if (input.name.length > 100) {
  throw new Error('Name too long');
}
```

## 输出编码

### 编码场景
- HTML输出：HTML编码
- JavaScript输出：JS编码
- URL输出：URL编码
- CSS输出：CSS编码

### 编码示例
```javascript
// HTML编码
function escapeHtml(str) {
  return str
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#x27;');
}
```

## SQL安全

### 防止SQL注入
- 使用参数化查询
- 不拼接SQL字符串
- 使用ORM/Query Builder

### 安全示例
```javascript
// 安全：参数化查询
const query = 'SELECT * FROM users WHERE id = ?';
db.query(query, [userId]);

// 不安全：字符串拼接
const query = `SELECT * FROM users WHERE id = ${userId}`;
```

## XSS防护

### 存储型XSS
- 输入验证
- 输出编码
- CSP策略

### 反射型XSS
- URL参数验证
- 输出编码
- 避免直接渲染URL参数

### DOM型XSS
- 避免innerHTML
- 使用textContent
- 安全的DOM操作

## CSRF防护

### 防护措施
- CSRF Token
- SameSite Cookie
- 验证Origin/Referer

### Token实现
```javascript
// 生成Token
const csrfToken = generateToken();
res.cookie('csrfToken', csrfToken);

// 验证Token
if (req.cookies.csrfToken !== req.body.csrfToken) {
  throw new Error('CSRF token mismatch');
}
```

## 认证与授权

### 认证安全
- 强密码策略
- 多因素认证
- 密码哈希存储
- 会话管理

### 授权安全
- RBAC（基于角色）
- ABAC（基于属性）
- 权限检查
- 资源所有权验证

## 数据保护

### 加密存储
- 密码：bcrypt/scrypt
- 敏感数据：AES加密
- 密钥管理：KMS/HSM

### 传输加密
- HTTPS强制
- TLS 1.2+
- 证书验证
- HSTS策略

## 日志安全

### 日志原则
- 不记录敏感信息
- 记录安全事件
- 日志访问控制
- 日志完整性保护

### 应记录
- 登录尝试
- 权限变更
- 数据访问
- 异常操作

### 不应记录
- 密码
- Token
- 个人敏感信息
- 信用卡号

## 安全测试

### 测试类型
- SAST：静态分析
- DAST：动态分析
- IAST：交互分析
- Pen Test：渗透测试

### 安全扫描
- 依赖漏洞扫描
- 代码安全扫描
- 配置安全检查

## 安全响应

### 漏洞响应流程
1. 发现漏洞
2. 评估影响
3. 制定修复方案
4. 实施修复
5. 验证修复
6. 发布补丁
7. 通知用户

### 安全事件处理
- 隔离受影响系统
- 收集证据
- 分析原因
- 恢复服务
- 总结改进
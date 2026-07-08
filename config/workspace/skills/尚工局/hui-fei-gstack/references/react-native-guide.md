# React Native 开发指南

## 环境配置

### 开发环境
- Node.js >= 18
- React Native CLI
- Xcode（iOS开发）
- Android Studio（Android开发）

### 项目初始化
```bash
npx react-native init ProjectName
cd ProjectName
npx react-native run-ios
npx react-native run-android
```

## 核心组件

### 基础组件
- View：容器组件
- Text：文本组件
- Image：图片组件
- ScrollView：滚动容器
- TextInput：输入组件

### 导航
- React Navigation：主流导航库
- Stack Navigator：栈导航
- Tab Navigator：标签导航
- Drawer Navigator：抽屉导航

## 样式系统

### Flexbox布局
```javascript
const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    justifyContent: 'center',
    alignItems: 'center',
  },
});
```

### 常用样式属性
- flex：弹性布局
- flexDirection：排列方向
- justifyContent：主轴对齐
- alignItems：交叉轴对齐
- margin/padding：间距
- width/height：尺寸

## 状态管理

### useState
```javascript
const [state, setState] = useState(initialValue);
```

### Context API
```javascript
const Context = createContext(defaultValue);
const Provider = Context.Provider;
const Consumer = Context.Consumer;
```

### Redux（可选）
- Store：状态存储
- Action：状态变更描述
- Reducer：状态变更函数
- Middleware：中间件

## 性能优化

### 避免不必要的渲染
- 使用React.memo
- 使用useMemo/useCallback
- 避免inline函数

### 图片优化
- 使用合适尺寸
- 懒加载
- 缓存策略

### 列表优化
- 使用FlatList/VirtualizedList
- 设置keyExtractor
- 使用getItemLayout

## 常见问题

### 样式不生效
- 检查StyleSheet.create
- 确认样式属性名称
- 注意平台差异

### 导航问题
- 确认NavigationContainer
- 检查路由配置
- 注意嵌套导航

### 性能问题
- 检查渲染次数
- 优化列表组件
- 减少状态更新

## 测试

### 单元测试
```bash
npm install --save-dev jest @testing-library/react-native
```

### E2E测试
- Detox：主流E2E测试框架
- Appium：跨平台测试框架
# React Native开发规范

## 项目结构

```
project/
├── src/
│   ├── components/     # 通用组件
│   ├── screens/        # 页面
│   ├── navigation/     # 导航配置
│   ├── services/       # API服务
│   ├── store/          # 状态管理
│   ├── utils/          # 工具函数
│   └── assets/         # 静态资源
├── App.tsx             # 入口文件
└── package.json
```

## 样式规范

### 使用StyleSheet

```tsx
import { StyleSheet } from 'react-native';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
  text: {
    fontSize: 16,
    color: '#333',
  },
});
```

### 响应式设计

```tsx
import { Dimensions } from 'react-native';

const { width, height } = Dimensions.get('window');

// 使用百分比或比例
const styles = StyleSheet.create({
  box: {
    width: width * 0.8,
    height: height * 0.3,
  },
});
```

## 性能优化

### 1. 列表优化

```tsx
// 使用FlatList而非ScrollView渲染长列表
<FlatList
  data={items}
  renderItem={renderItem}
  keyExtractor={item => item.id}
  initialNumToRender={10}
  maxToRenderPerBatch={10}
  windowSize={5}
/>
```

### 2. 图片优化

```tsx
// 使用FastImage
import FastImage from 'react-native-fast-image';

<FastImage
  source={{ uri: imageUrl, priority: FastImage.priority.normal }}
  resizeMode={FastImage.resizeMode.cover}
/>
```

### 3. 避免不必要的渲染

```tsx
// 使用React.memo
const MyComponent = React.memo(({ data }) => {
  return <View>{/* ... */}</View>;
});
```

## 常见陷阱

| 陷阱 | 解决方案 |
|------|----------|
| 内存泄漏 | 组件卸载时清理定时器、订阅 |
| 主线程阻塞 | 耗时操作使用InteractionManager |
| 图片过大 | 压缩、使用缩略图 |
| 无限重渲染 | 检查依赖数组、使用useMemo |

---

_尚科局·慧妃参考_

# React最佳实践

## 组件设计原则

### 单一职责

每个组件只做一件事：

```jsx
// ❌ 不好：组件做太多事
function UserDashboard() {
  // 数据获取
  // 状态管理
  // UI渲染
  // 业务逻辑
}

// ✅ 好：职责分离
function UserDashboard() {
  const user = useUser();
  return <UserLayout user={user} />;
}
```

### 组合优于继承

```jsx
// ✅ 使用组合
function Card({ header, body, footer }) {
  return (
    <div className="card">
      <div className="header">{header}</div>
      <div className="body">{body}</div>
      <div className="footer">{footer}</div>
    </div>
  );
}
```

## Hooks最佳实践

### 依赖数组完整性

```jsx
// ❌ 不好：遗漏依赖
useEffect(() => {
  fetchData(userId);
}, []); // userId 变化时不会重新执行

// ✅ 好：完整依赖
useEffect(() => {
  fetchData(userId);
}, [userId]);
```

### 自定义Hook提取复用逻辑

```jsx
// 提取复用逻辑为自定义Hook
function useWindowSize() {
  const [size, setSize] = useState({ width: 0, height: 0 });
  
  useEffect(() => {
    const handleResize = () => {
      setSize({ width: window.innerWidth, height: window.innerHeight });
    };
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);
  
  return size;
}
```

## 性能优化

### 避免不必要的重渲染

```jsx
// 使用 React.memo
const MemoizedComponent = React.memo(function Component({ data }) {
  return <div>{data}</div>;
});

// 使用 useMemo 缓存计算
const expensiveValue = useMemo(() => computeExpensive(data), [data]);

// 使用 useCallback 缓存回调
const handleClick = useCallback(() => doSomething(id), [id]);
```

### 列表渲染优化

```jsx
// ✅ 使用稳定key
{items.map(item => (
  <Item key={item.id} data={item} />
))}

// ❌ 避免使用索引作为key
{items.map((item, index) => (
  <Item key={index} data={item} />
))}
```

## 状态管理

### 状态就近原则

- 仅在当前组件使用的状态 → 组件内state
- 多个组件共享的状态 → 提升到共同父组件
- 全局状态 → Context或状态管理库

### 状态不可变性

```jsx
// ❌ 直接修改
state.items.push(newItem);
setState(state);

// ✅ 创建新对象
setState(prev => ({
  ...prev,
  items: [...prev.items, newItem]
}));
```

---

_尚科局·慧妃参考_

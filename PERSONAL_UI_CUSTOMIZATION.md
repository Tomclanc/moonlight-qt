# Moonlight V+ Personal UI Customization

这是 [Tomclanc](https://github.com/Tomclanc) 根据个人审美制作的 Moonlight V+ 非官方界面定制。它以 `qiin2333/moonlight-qt` 为基础，主要面向 Windows 11 桌面使用场景，不代表原项目的默认视觉方案。

This is an unofficial Moonlight V+ interface customization by [Tomclanc](https://github.com/Tomclanc), based on personal aesthetic preferences. It is derived from `qiin2333/moonlight-qt`, focuses on the Windows 11 desktop experience, and does not represent the upstream project's default visual design.

## 主要改动

- 增加“跟随系统 / 深色 / 亮色”外观设置，并持久保存选择。
- Windows 11 下启用原生 Mica 背景、沉浸式明暗模式和系统窗口圆角。
- 卡片、弹窗、按钮、输入框、下拉菜单、设置导航和滚动条使用统一圆角。
- 分类图标、工具栏提示框和窗口按钮提示框随明暗主题切换颜色。
- 修正手动添加电脑时示例 IP 地址的垂直对齐。
- 修正 Qt 6.7 下 HDR 设置组件的 QML 导入兼容问题，保证设置面板可打开。
- 保留 Moonlight V+ 原有功能和青绿色交互强调色。

## 验证环境

- Moonlight V+ 6.4.1
- Windows 11
- Qt 6.7.2 MSVC 64-bit
- 已验证亮色界面、设置面板、手动添加电脑弹窗、主题图标、圆角滚动条和主题提示框。

## 下载与兼容性

请从此 fork 的 Releases 下载完整 Windows 便携包。构建使用 Qt 私有头文件，因此可执行文件必须与包内 Qt 6.7.2 运行库一起使用；不要只把 EXE 复制到使用其他 Qt 版本的 Moonlight 安装目录。

发布包属于个人定制构建，使用前请自行保留原版安装和配置备份。源代码继续遵循仓库原有许可证。

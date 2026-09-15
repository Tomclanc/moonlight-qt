pragma Singleton
import QtQuick 2.9
import StreamingPreferences 1.0

// 全应用的设计 token。保留清晰的线条和偏移投影，同时加入 Windows 11
// Mica 适合的半透明层与克制圆角。
//
// 配方只有六件事：小圆角、零模糊硬投影、极简中性色、单一荧光强调色、
// 几何变宽字体 + 等宽数字、宽字距大写微标签。想改风格只动这一个文件。
QtObject {
    // Resolve the user's explicit choice first. System mode stays bound to Qt's
    // platform color scheme, so it also follows changes made while Moonlight runs.
    readonly property bool isLight:
        StreamingPreferences.colorTheme === StreamingPreferences.THEME_LIGHT ||
        (StreamingPreferences.colorTheme === StreamingPreferences.THEME_SYSTEM &&
         Qt.styleHints.colorScheme === Qt.Light)

    // ---- 表面 ----
    // 卡片仍保持较高不透明度，只透出少量 Mica 色彩和桌面环境。
    readonly property color ink: isLight ? "#F4F6F8" : "#0F1115"
    readonly property color surface: isLight ? "#FFFFFF" : "#171A20"
    readonly property color surface2: isLight ? "#E9EEF2" : "#1F232B"
    readonly property color surfaceLayer: isLight ? "#D9FFFFFF" : "#D9171A20"
    readonly property color surface2Layer: isLight ? "#E6E9EEF2" : "#E61F232B"
    readonly property color line: isLight ? "#CBD3DA" : "#2B3038"
    readonly property color lineStrong: isLight ? "#87939E" : "#3C434E"

    // ---- 文字 ----
    readonly property color text: isLight ? "#171A20" : "#EEF0EC"
    readonly property color textDim: isLight ? "#46515C" : "#AEB3AB"
    readonly property color textFaint: isLight ? "#697580" : "#7E858E"
    // 长说明比微标签更亮，避免在高 DPI 和复杂背景上退成一层灰雾。
    readonly property color textSettingsSubtitle: isLight ? "#303A44" : "#D7DBD5"

    // ---- 强调色 ----
    // 主色保留品牌青；酸性绿只留给「正在运行 / LIVE」这类抢眼状态标记，
    // 用得越少越有效，一旦到处都是就退化成普通的绿色装饰。
    readonly property color accent: isLight ? "#087F78" : "#39C5BB"
    readonly property color accentStrong: isLight ? "#006A64" : "#5DD9D0"
    readonly property color accentDim: isLight ? "#0A9289" : "#2BA39A"
    readonly property color accentSoft: isLight ? "#26087F78" : "#2639C5BB"
    readonly property color acid: isLight ? "#517A00" : "#C8FF4D"
    readonly property color acidGlow: isLight ? "#66517A00" : "#66C8FF4D"
    readonly property color danger: isLight ? "#B42318" : "#FF876F"

    // ---- 形状 ----
    // 窗口和卡片用较大的圆角；输入框、按钮和选项使用紧凑圆角。
    readonly property int radiusCard: 10
    readonly property int radiusControl: 6

    // 零模糊、纯偏移的实心投影，对应 box-shadow: 6px 6px #0000008c。
    // QML 没有 box-shadow，Panel.qml 用一个偏移的实心矩形垫在本体后面模拟。
    readonly property int shadowOffset: 6
    readonly property int shadowOffsetLift: 9     // hover/focus 抬起时的投影
    readonly property color shadowColor: isLight ? "#40000000" : "#8C000000"

    // border-left 粗条，参考站用 5px/9px 做强调，我们卡片用 4、状态标记用 5
    readonly property int accentBar: 4
    readonly property int accentBarStrong: 5

    // ---- 字体 ----
    // 打包在 app/res/fonts/，由 main.cpp 注册；中文靠系统字体回退。
    readonly property string fontSans: "Manrope"
    readonly property string fontMono: "DM Mono"

    // QML 的 font.letterSpacing 单位是像素，不是 em，所以要按字号折算。
    // 参考站的宽字距微标签是 .18em~.24em，标题是 -.03em。
    function tracking(pointSize, em) { return pointSize * 1.333 * em }
    function trackingWide(pointSize) { return tracking(pointSize, 0.2) }
    function trackingTight(pointSize) { return tracking(pointSize, -0.03) }
    // 常用字号的预折算值，绑定里直接用，省得到处调函数
    readonly property real trackingCaption: trackingWide(fontCaption)
    readonly property real trackingLabel: trackingWide(fontBody)

    // ---- 8pt 间距栅格 ----
    readonly property int spaceXs: 4
    readonly property int spaceSm: 8
    readonly property int spaceMd: 12
    readonly property int spaceLg: 16
    readonly property int spaceXl: 24

    // ---- 字号 ----
    readonly property int fontCardTitle: 13
    readonly property int fontHeroTitle: 18
    readonly property int fontRowTitle: 11
    readonly property int fontBody: 10
    readonly property int fontCaption: 9
    readonly property int fontSettingsSubtitle: fontBody

    // ---- 动效 ----
    // neo-brutalism 的动效更短更机械：不要弹、不要缓慢收尾，OutQuad 就够了。
    readonly property int durFast: 120
    readonly property int durNormal: 150
    readonly property int easing: Easing.OutQuad

    // ---- 布局 ----
    readonly property int railWidth: 208
    // 低于这个宽度时 rail 塌缩成顶部横向 tab
    readonly property int compactBreakpoint: 860
    // 低于这个内容宽度时，设置行把右侧控件移到说明文字下方。
    readonly property int settingsRowStackBreakpoint: 520
}

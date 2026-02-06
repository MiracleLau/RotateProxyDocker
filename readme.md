
---

# RotateProxy Docker 管理方案

本项目是基于 [akkuman/rotateproxy](https://github.com/akkuman/rotateproxy) 的 Docker 化部署方案。通过自动爬取 FOFA 上的开放代理，实现一个动态旋转的本地 SOCKS5 代理服务。

## 🚀 快速开始

### 1. 克隆项目 (包含子模块)

由于本项目使用 Git Submodule 管理核心源码，克隆时请务必带上 `--recursive` 参数：

```bash
git clone --recursive <你的仓库地址>
cd <项目目录>

```

如果你已经克隆了但文件夹是空的，请执行：

```bash
git submodule update --init --recursive

```

### 2. 配置环境变量

复制模板文件并填写你的 FOFA 信息：

```bash
cp .env.example .env

```

编辑 `.env` 文件：

* `FOFA_EMAIL`: 你的 FOFA 账号邮箱。
* `FOFA_TOKEN`: 你的 FOFA API Key。
* `SEARCH_RULE`: 搜索规则（已预设为 2025 年后的 CN 节点）。

### 3. 构建并启动

使用 Docker Compose 一键完成镜像构建与容器启动：

```bash
docker-compose up -d

```

---

## ⚙️ 配置详情

### 端口映射

* 默认监听端口：`5555` (可在 `.env` 中修改 `LISTEN_ADDR`)

### 代理认证

* **用户名**: `rotateproxy`
* **密码**: `rotateproxy`
*(建议在 `.env` 中修改 `PROXY_USER` 和 `PROXY_PASS` 以提高安全性)*

### 项目结构

```text
.
├── rotateproxy-src/     # 核心源码 (Git Submodule)
├── .env                 # 环境变量 (不进入 Git)
├── .dockerignore        # 排除文档与无效文件
├── Dockerfile           # 多阶段轻量化构建
└── docker-compose.yml   # 容器编排配置

```

---

## 🛠️ 常用命令

* **查看运行状态**:
```bash
docker-compose ps

```


* **查看抓取日志**:
```bash
docker logs -f rotateproxy

```


* **停止并移除容器**:
```bash
docker-compose down

```


* **更新代码后重新构建**:
```bash
git submodule update --remote
docker-compose up --build -d

```



---

## ⚠️ 注意事项

1. **FOFA 额度**: 程序会根据 `PAGE_COUNT` 消耗 FOFA API 额度，请根据自己的套餐等级合理配置。
2. **安全防护**: `.env` 文件已被包含在 `.gitignore` 中，请勿将其上传至任何公开仓库。
3. **规则有效期**: `-rule` 中的 `after="2025-03-01"` 会随着时间推移失效，建议定期更新 `.env` 中的日期以获取最新节点。
4. 本项目由AI生成，请自行确认是否含有安全问题4. 本项目由AI生成，请自行确认是否含有安全问题4. 本项目由AI生成，请自行确认是否含有安全问题4. 本项目由AI生成，请自行确认是否含有安全问题
---

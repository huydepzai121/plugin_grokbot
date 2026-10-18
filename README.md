# plugin_grokbot

Grok Bot điều phối, omp + DeepSeek viết code, để tiết kiệm quota Grok Bot. Thuật ngữ: [GLOSSARY.md](GLOSSARY.md).

## Cài trên máy cloud của Grok Bot

Có thể nhờ chính Grok Bot chạy các bước này.

1. Cài omp theo hướng dẫn: https://github.com/can1357/oh-my-pi#installation
2. Đặt key: `export DEEPSEEK_API_KEY=...` (thêm vào `~/.bashrc` hoặc `~/.zshrc`).
3. Kiểm tra id model thật: `curl -H "Authorization: Bearer $DEEPSEEK_API_KEY" https://api.deepseek.com/models`. Nếu id khác `deepseek-v4.1-flash` thì sửa trong `omp/models.yml`.
4. `mkdir -p ~/.omp/agent && cp omp/models.yml ~/.omp/agent/models.yml`
5. `git clone https://github.com/huydepzai121/plugin_grokbot ~/ds-code && chmod +x ~/ds-code/scripts/ds-code.sh` (làm bước này trước bước 4 nếu chưa có repo).
6. Kiểm tra cờ chạy không tương tác: `omp --help`. Nếu không phải `-p` thì sửa dòng gọi `omp` trong `scripts/ds-code.sh`.
7. Chạy thử:
   - Code: `~/ds-code/scripts/ds-code.sh "Tạo hello.py in ra Hello, chạy thử. Xong khi output đúng." /tmp/t1`
   - Ảnh: `~/ds-code/scripts/ds-code.sh "Vẽ hình tròn đỏ 200x200 ra c.png bằng Pillow, mở ảnh xem và mô tả lại." /tmp/t2`
8. Thêm nội dung `grokbot/skills/delegate-code.md` thành một skill trong Grok Bot.

## Chỉnh

- `DS_MODEL`: đổi model, ví dụ `DS_MODEL=deepseek/deepseek-v4-pro` cho task khó.
- `DS_LOG_DIR`: nơi lưu log đầy đủ (mặc định `~/.ds-code/logs`).

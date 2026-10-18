#!/usr/bin/env bash
# Giao một Task cho omp/DeepSeek, chạy không tương tác, in kết quả gọn cho Grok đọc.
# Dùng: ds-code.sh "<mô tả task + tiêu chí xong>" [thư mục làm việc]
set -euo pipefail

TASK="${1:?Thiếu mô tả task}"
WORKDIR="${2:-$PWD}"
MODEL="${DS_MODEL:-deepseek/deepseek-v4.1-flash}"
LOG_DIR="${DS_LOG_DIR:-$HOME/.ds-code/logs}"

: "${DEEPSEEK_API_KEY:?Chưa đặt DEEPSEEK_API_KEY}"
mkdir -p "$LOG_DIR"
LOG="$LOG_DIR/$(date +%Y%m%d-%H%M%S).log"

PROMPT="$TASK

Quy tắc:
- Tự viết code, tự chạy, tự kiểm tra tiêu chí xong.
- Nếu task sinh ảnh: render ra file, tự mở ảnh xem và sửa đến khi đạt.
- Kết thúc bằng đúng một khối:
RESULT: PASS | FAIL
FILES: <danh sách file đã tạo/sửa>
NOTES: <tối đa 3 dòng; nếu FAIL ghi lỗi chính>"

cd "$WORKDIR"
if omp -p --model "$MODEL" "$PROMPT" >"$LOG" 2>&1; then status=0; else status=$?; fi

# Chỉ trả phần tóm tắt để Grok không tốn quota đọc toàn bộ log.
if grep -q '^RESULT:' "$LOG"; then
  sed -n '/^RESULT:/,$p' "$LOG" | tail -n 20
else
  echo "RESULT: FAIL"
  echo "NOTES: omp thoát mã $status, không có khối RESULT. 20 dòng cuối log:"
  tail -n 20 "$LOG"
fi
echo "LOG: $LOG"

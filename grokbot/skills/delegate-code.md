# Skill: delegate-code (skill chung cho mọi việc)

Mục đích: tiết kiệm quota Grok Bot. Grok hỏi, điều phối, viết chữ và duyệt. Mọi việc sinh code (web, script, test, code vẽ/render ảnh, bài đăng có ảnh...) giao cho omp + DeepSeek.

Nguồn: https://github.com/huydepzai121/plugin_grokbot

## 0. Cài lần đầu (nếu chưa có ~/ds-code/scripts/ds-code.sh)

1. `git clone https://github.com/huydepzai121/plugin_grokbot ~/ds-code`
2. `chmod +x ~/ds-code/scripts/ds-code.sh`
3. Cài oh-my-pi theo https://github.com/can1357/oh-my-pi#installation
4. `mkdir -p ~/.omp/agent && cp ~/ds-code/omp/models.yml ~/.omp/agent/models.yml`
5. Kiểm tra `DEEPSEEK_API_KEY` đã có; nếu chưa thì hỏi người dùng, không tự bịa, không ghi key vào repo.
6. `curl -s -H "Authorization: Bearer $DEEPSEEK_API_KEY" https://api.deepseek.com/models` — nếu không có id `deepseek-v4.1-flash` thì sửa id trong `~/.omp/agent/models.yml` và báo người dùng.
7. `omp --help` — xác nhận cờ chạy không tương tác; nếu không phải `-p` thì sửa dòng gọi omp trong `~/ds-code/scripts/ds-code.sh`.

## 1. Hỏi một lần duy nhất

Với mọi yêu cầu chưa rõ, gom TẤT CẢ câu hỏi vào MỘT tin nhắn, đánh số, mỗi câu kèm giá trị mặc định để người dùng chỉ cần trả lời "ok". Bỏ câu người dùng đã nói rõ. Không hỏi vòng hai trừ khi thiếu thông tin bắt buộc.

Luôn hỏi (nếu chưa rõ):
- Mục tiêu và kết quả cuối cùng mong muốn.
- Thông tin bắt buộc phải có (dữ liệu, chữ, số liệu, link).
- Định dạng đầu ra (file gì, kích thước, nơi lưu).
- Ràng buộc (công nghệ, màu/thương hiệu, thời hạn).

Câu hỏi thêm theo loại việc:
- **Bài đăng mạng xã hội**: nền tảng (mặc định Facebook), mục đích, người đọc, giọng văn (mặc định thân thiện), CTA + link/SĐT, số ảnh và kích thước (Facebook/Instagram 1080x1350, story/TikTok 1080x1920, LinkedIn/X 1200x675), màu/logo/font, độ dài và hashtag (mặc định vừa, 3-5 hashtag).
- **Ảnh/đồ họa**: kích thước, chữ trên ảnh (chính xác từng chữ), màu, logo, số phương án.
- **Web/app**: trang/tính năng cần có, công nghệ (mặc định HTML/CSS/JS thuần), nơi chạy/deploy.
- **Script/tự động hóa**: đầu vào, đầu ra, chạy một lần hay theo lịch.
- **Sửa lỗi**: lỗi hiện ra thế nào, cách tái hiện, thư mục project.

## 2. Luật cứng khi làm

1. Việc cần viết hoặc sửa code: KHÔNG tự viết. Gọi:
   `~/ds-code/scripts/ds-code.sh "<task>" <thư mục project>`
2. Chỉ tự viết code khi ds-code.sh trả `RESULT: FAIL` 2 lần liên tiếp cho cùng task.
3. Không đọc toàn bộ code omp viết. Chỉ đọc khối RESULT/FILES/NOTES; chỉ mở file LOG khi cần hiểu lỗi.
4. Việc lớn: chia thành nhiều task nhỏ, giao lần lượt.
5. Grok tự làm: viết chữ (caption, nội dung, email), đăng nhập công cụ, thao tác trình duyệt, chia việc, duyệt kết quả.

## 3. Cách viết `<task>`

Ngắn, đủ 3 ý:
- Mục tiêu: làm gì.
- Phạm vi: file/thư mục được sửa.
- Tiêu chí xong kiểm chứng được: lệnh test/build phải pass, hoặc file ảnh đầu ra + kích thước + yêu cầu nhìn thấy. Có chữ tiếng Việt thì ghi "hiển thị đúng dấu tiếng Việt".

Ví dụ: "Vẽ poster 1080x1350 bằng Python Pillow, nền xanh navy, tiêu đề 'Sale 50%' ở giữa, xuất out/poster.png. Xong khi file tồn tại, đúng kích thước, chữ không tràn mép; tự mở ảnh kiểm tra."

## 4. Sau khi có kết quả

- PASS, việc code: báo xong kèm danh sách file.
- PASS, có ảnh: xem ảnh cuối một lần. Đạt thì báo xong; chưa đạt thì giao lại kèm nhận xét cụ thể (tính 1 lần fail).
- FAIL: giao lại một lần kèm NOTES và hướng sửa. Fail lần 2 thì tự làm.
- Không tự đăng, gửi, deploy ra ngoài khi người dùng chưa yêu cầu rõ.

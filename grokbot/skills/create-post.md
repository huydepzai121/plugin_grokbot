# Skill: create-post

Mục đích: tạo bài đăng mạng xã hội (chữ + ảnh) mà tốn ít quota. Grok hỏi đủ thông tin một lần, viết nội dung chữ, còn ảnh (render bằng code) giao cho omp qua skill delegate-code:
https://raw.githubusercontent.com/huydepzai121/plugin_grokbot/main/grokbot/skills/delegate-code.md

## Bước 1: Hỏi một lần duy nhất

Gom tất cả câu hỏi vào MỘT tin nhắn, đánh số, mỗi câu kèm giá trị mặc định để người dùng chỉ cần trả lời "ok". Bỏ qua câu nào người dùng đã nói rõ.

1. Nền tảng: Facebook / Instagram / TikTok / LinkedIn / X? (mặc định: Facebook)
2. Mục đích: bán hàng, thông báo, chia sẻ kiến thức, tuyển dụng? (mặc định: bán hàng)
3. Nội dung chính: sản phẩm/sự kiện gì, thông tin bắt buộc phải có (giá, ngày, địa chỉ, khuyến mãi)?
4. Người đọc: ai? (mặc định: khách hàng phổ thông)
5. Giọng văn: thân thiện / chuyên nghiệp / hài hước? (mặc định: thân thiện)
6. Lời kêu gọi (CTA): inbox, gọi điện, bấm link? Link hoặc số điện thoại nếu có.
7. Ảnh: cần mấy ảnh, kích thước? (mặc định theo nền tảng: Facebook/Instagram 1080x1350, story/TikTok 1080x1920, LinkedIn/X 1200x675)
8. Thương hiệu: màu chủ đạo, logo (đường dẫn file), font? (mặc định: tự chọn hài hòa)
9. Độ dài chữ và hashtag: ngắn/vừa/dài, có hashtag không? (mặc định: vừa, 3-5 hashtag)

Không hỏi thêm vòng hai trừ khi thiếu thông tin bắt buộc ở câu 3.

## Bước 2: Viết chữ (Grok tự làm)

- Viết caption theo nền tảng, giọng văn, CTA, hashtag.
- Đưa người dùng duyệt caption trước khi làm ảnh nếu bài quan trọng; còn lại làm song song.

## Bước 3: Ảnh (giao omp, không tự viết code)

Gọi:

```bash
~/ds-code/scripts/ds-code.sh "<task>" ~/posts/<tên-bài>
```

Task phải có: kích thước, màu, chữ xuất hiện trên ảnh (chính xác từng chữ, có dấu tiếng Việt), vị trí logo, file đầu ra `out/post-1.png`, và tiêu chí: "file tồn tại, đúng kích thước, chữ tiếng Việt hiển thị đúng dấu, không tràn mép; tự mở ảnh kiểm tra".

## Bước 4: Duyệt và giao

- Xem ảnh cuối một lần. Chưa đạt thì giao lại omp kèm nhận xét cụ thể (tối đa 2 lần, sau đó tự sửa).
- Gửi người dùng: caption + đường dẫn ảnh. Không tự đăng lên mạng xã hội nếu người dùng chưa yêu cầu rõ.

# Skill: delegate-code

Mục đích: tiết kiệm quota Grok Bot. Mọi việc sinh code giao cho Worker (omp + DeepSeek). Grok chỉ điều phối và duyệt.

## Luật cứng

1. Việc nào cần viết hoặc sửa code (kể cả code để vẽ/render ảnh, script, web, test): KHÔNG tự viết. Gọi Worker.
2. Chỉ tự viết code khi Worker đã trả `RESULT: FAIL` 2 lần liên tiếp cho cùng một task (Escalation).
3. Không đọc toàn bộ code Worker viết. Chỉ đọc khối RESULT/FILES/NOTES. Chỉ mở log khi cần hiểu lỗi.

## Cách giao việc

Chạy trong terminal:

```bash
~/ds-code/scripts/ds-code.sh "<task>" <thư mục project>
```

Viết `<task>` ngắn, gồm:
- Mục tiêu: làm gì.
- Phạm vi: file/thư mục được động vào.
- Tiêu chí xong kiểm chứng được: lệnh test/build phải pass, hoặc file ảnh đầu ra + kích thước + yêu cầu nhìn thấy.

Ví dụ:
> Vẽ poster 1080x1350 bằng Python (Pillow), nền xanh navy, tiêu đề "Sale 50%" ở giữa, xuất ra out/poster.png. Xong khi file tồn tại, đúng kích thước, chữ không tràn mép.

## Sau khi Worker trả về

- `PASS` và là task code: báo xong.
- `PASS` và có ảnh: mở ảnh cuối xem một lần. Đạt thì báo xong; chưa đạt thì giao lại kèm nhận xét cụ thể (tính là 1 lần fail).
- `FAIL`: giao lại một lần kèm NOTES và hướng sửa. Fail lần 2 thì tự làm.

## Việc Grok tự làm

Đăng nhập công cụ, thao tác trình duyệt, chia nhỏ yêu cầu lớn thành nhiều task, và Escalation.

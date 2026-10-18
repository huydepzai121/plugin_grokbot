# Glossary

**Orchestrator**: Grok Bot. Nhận yêu cầu, chia thành Task, giao cho Worker, chấm kết quả. Chỉ tự làm khi Escalation.

**Worker**: Agent rẻ (omp chạy model DeepSeek) thực thi một Task đã có tiêu chí rõ. Quy tắc: mọi việc sinh code đều là việc của Worker.

**Task**: Một đơn vị việc giao cho Worker, gồm mô tả ngắn, phạm vi file và tiêu chí "xong" kiểm chứng được.

**Escalation**: Khi Worker thất bại quá ngưỡng hoặc Task vượt khả năng Worker, Orchestrator tự làm.

**Grok-only capability**: Việc Worker không làm được (đăng nhập công cụ, thao tác trình duyệt). Luôn do Orchestrator làm, nhưng phần code đi kèm vẫn giao Worker.

**Rendered image**: Ảnh sinh ra bằng cách chạy code (không phải model sinh ảnh). Worker vừa viết code vừa tự xem lại ảnh; Orchestrator chỉ duyệt kết quả cuối.

**Quota**: Hạn mức sử dụng Grok Bot theo gói Cursor; thứ cần tiết kiệm (không phải tiền).

# پشتیبانی ویندوز و نسخه Python

| ویندوز | تشخیص | پوشه Python | نسخه |
|--------|--------|-------------|------|
| **۷** (6.1) | Legacy | `python38\` | **3.8.10** |
| **۸.۰** (6.2) | Legacy | `python38\` | **3.8.10** |
| **۸.۱** (6.3) | Modern | `python\` | **3.11.9** |
| **۱۰** | Modern | `python\` | **3.11.9** |
| **۱۱** | Modern | `python\` | **3.11.9** |

## پیش‌نیازها (داخل Setup آفلاین بعد از بیلد Actions)
- Python توکار + pip packages: `customtkinter`, `llama-cpp-python`, …
- tkinter/tcl کپی‌شده
- `llama-server` (اختیاری)
- کد `scripts\python\*.py`

## روی سیستم کاربر
- فقط فایل `.gguf` در `models\`
- VC++ Redistributable در صورت کمبود DLL (معمولاً با Setup کافی است)

## نکته
Setup فعلی که **فقط 3.11** دارد روی Win7 خطای `api-ms-win-core-path` می‌دهد — باید بیلد جدید Actions با هر دو `python` و `python38` نصب شود.

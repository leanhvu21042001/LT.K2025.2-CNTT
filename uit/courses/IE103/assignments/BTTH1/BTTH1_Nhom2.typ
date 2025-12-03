#import "../../../../../tools/typst/libs/academic-alt.typ": *

#show: university-assignment.with(
  title: "Bài Tập Thực Hành 1",
  subtitle: "IE103 - Quản Lý Thông Tin",
  author: "Nhóm 2",
  details: (
    course: "IE103",
    instructor: "Ths. Nguyễn Thành Luân",
    due-date: "Tháng 12, 2025",
    duration: "~3 hours",
    lab-number: "BTTH1",
  )
)

= Nhóm 2

#figure(
  align(center)[
  #table(
    columns: (10%, 20%, 70%),
    align: (right,left,left,),
    table.header([#strong[No];], [#strong[MSSV];], [#strong[Họ và Tên];],),
    table.hline(),
    [1], [25410291], [Đinh Xuân Sâm],
    [2], [25410319], [Đặng Hữu Toàn],
    [3], [25410321], [Nguyễn Điền Triết],
    [4], [25410204], [Trương Xuân Hậu],
    [5], [25410338], [Lê Anh Vũ],
    [6], [25410176], [Trần Sơn Bình],
    [7], [25410247], [Lê Kim Long],
    [8], [25410337], [La Anh Vũ],
    [9], [25410209], [Lê Ngọc Hiệp],
    [10], [25410271], [Nguyễn Thị Ngọc Nhung],
  )]
  , kind: table,
  caption: [Nhóm 2 (Omega)]
  )

#pagebreak()

= Bài 1

Trong Gmail, anh/chị hãy cho biết:

+ Gmail đã cung cấp các tính năng gì để phục vụ cho việc tổ chức tốt các
  mails?
+ Cấu trúc đầy đủ của một email.
+ Phân loại mails.
+ Khái niệm mailgroup.
+ Hãy tạo thêm các thư mục (Label) sau: Giải Trí, Sức Khỏe, Thể Thao,
  Học Tập.
+ Hãy đánh dấu và di chuyển các mails vào các thư mục vừa tạo tương ứng.
+ Một account hiện tại có dung lượng tối đa bao nhiêu?
+ Hãy tạo ra một mailgroup trong gmail và cho biết lợi ích của nó? Tìm
  hiểu các tính năng admin/member.
+ Các tính năng tìm kiếm mail.
+ Tìm hiểu tính năng: Filter message like this.

== Các tính năng tổ chức mail

Gmail cung cấp các tính năng hỗ trợ công việc như:

+ Tổ chức email bằng bộ lọc (Filter) và nhãn (Label),
+ Tìm kiếm nhanh,
+ Chặn spam hiệu quả và lưu trữ an toàn.
+ Ngoài ra còn tích hợp Drive/Meet để chia sẻ tài liệu và trao đổi thuận tiện.

= Bài 2

== Hardware Setup

The following components were used:

- Raspberry Pi 4 Model B
- Red LED (2.1V forward voltage, 20mA forward current)
- 220Ω current-limiting resistor
- Breadboard for prototyping
- Jumper wires for connections

The LED was connected between GPIO pin 18 and ground, with the current-limiting resistor in series.

== Software Implementation

Two implementations were developed:

1. **Python Implementation**: Using the `RPi.GPIO` library
2. **C Implementation**: Using the `WiringPi` library

Both programs implement the same functionality: blinking an LED at 1Hz (500ms on, 500ms off).

== Code Examples

The Python implementation:

```python
import RPi.GPIO as GPIO
import time

# Set up GPIO
GPIO.setmode(GPIO.BCM)
GPIO.setup(18, GPIO.OUT)

try:
    while True:
        GPIO.output(18, GPIO.HIGH)  # Turn LED on
        time.sleep(0.5)
        GPIO.output(18, GPIO.LOW)   # Turn LED off
        time.sleep(0.5)
except KeyboardInterrupt:
    GPIO.cleanup()
```

The C implementation:

```c
#include <wiringPi.h>
#include <stdio.h>

#define LED_PIN 18

int main(void) {
    wiringPiSetupGpio();
    pinMode(LED_PIN, OUTPUT);
    
    while (1) {
        digitalWrite(LED_PIN, HIGH);
        delay(500);
        digitalWrite(LED_PIN, LOW);
        delay(500);
    }
    
    return 0;
}
```

= Bài 3

Both implementations successfully controlled the LED with the following observations:

- The LED blinked consistently at 1Hz
- Visual timing appeared identical between implementations
- The C implementation showed slightly more precise timing
- Python implementation was easier to develop and debug

== Performance Analysis

Timing measurements were conducted using a logic analyzer:

| Implementation | Average Period | Standard Deviation |
|----------------|----------------|--------------------|
| Python         | 1000.2ms       | ±2.1ms             |
| C              | 999.8ms        | ±0.8ms             |

The C implementation demonstrated more consistent timing, likely due to reduced overhead compared to Python's interpreted execution.

= Bài 4



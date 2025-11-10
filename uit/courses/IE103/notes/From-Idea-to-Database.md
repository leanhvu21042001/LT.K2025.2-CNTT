# From Idea to Database: The 'Big Picture' of Design

Welcome! Let's be honest: just looking at SQL code or a complex diagram can be confusing. The "why" is often missing. Why do we draw these diagrams? How do they become actual code?

This lecture is the "missing manual." We're going to walk through the **entire workflow**, from a simple idea in your head to a real, working database.

Think of it like building a house:

1. **The Sketch:** You talk with the owner and draw a simple sketch. ("A 3-bedroom house with a big kitchen.")
    
2. **The Blueprint:** An architect turns the sketch into a detailed, technical blueprint. ("The wall here is 3.5m, using 2x4 studs...")
    
3. **The Building:** The construction crew uses the blueprint to build the _actual house_.
    

Database design is the **exact same**.

## The 3-Step Design Workflow

Everything in database design fits into one of these three steps.

### Step 1: The Sketch (Conceptual Model)

This is the high-level "sketch" of your system. Its goal is to help **humans** (developers, clients, managers) agree on what we're building. It's all about ideas, not technology.

We use two main tools for this "sketch":

1. **ERD (Entity-Relationship Diagram):** The classic _data-first_ model. Perfect for designing databases.
    
2. **CD (Class Diagram):** The modern _code-first_ model. Perfect for designing applications.
    

(We'll dive deep into both in a minute.)

### Step 2: The Blueprint (Logical Model)

This is the technical **blueprint**. We convert our "sketch" (the ERD or CD) into a formal, text-based plan. This plan is **independent of any specific database** (it's not SQL, but it's very close).

This is where you see that familiar format:

- `SINHVIEN (MSSV, HOTEN, DIACHI)`
    
- `LOP (MALOP, TENLOP, MAGV)`
    

### Step 3: The Building (Physical Model)

This is the **actual, physical code**. You take your "blueprint" (the Logical Model) and write the `CREATE TABLE` statements for your specific database (like SQL Server, MySQL, etc.).

## Step 1 (Deep Dive): Choosing Your "Sketch"

Let's look at your two main tools for sketching the Conceptual Model.

### Tool #1: The ERD (Entity-Relationship Diagram)

This is the best tool for designing a database. It focuses on _only_ the data. It has 3 key parts:

1. **Entity (Thực Thể):** A "thing" you want to store. A noun.
    
    - **Examples:** `SINHVIEN`, `MONHOC` (Subject), `GIAOVIEN` (Teacher).
        
    - **How we draw it:** A rectangle.
        
2. **Attribute (Thuộc Tính):** A property of an entity. An adjective.
    
    - **Examples:** `HOTEN` (Full Name), `NGAYSINH` (Date of Birth).
        
    - **How we draw it:** An oval connected to the entity. We underline the Primary Key (e.g., `MSSV`).
        
3. **Relationship (Mối Kết Hợp):** How two entities are connected. A verb.
    
    - **Examples:** A `SINHVIEN`... `THI` (takes)... a `MONHOC`.
        
    - **How we draw it:** A diamond connecting the entities.
        

#### The Most Important Part: Cardinality (Bản số)

This tells us the _rules_ of the relationship, using `(min, max)` notation.

- `(1,n)`: "One-to-Many"
    
- `(n,n)`: "Many-to-Many"
    
- `(0,1)`: "Zero-or-One"
    

**Example:** A `LOP` (Class) has one `GIAOVIEN` (Teacher) as its head. A `GIAOVIEN` can be the head of _zero or one_ `LOP`.

`GIAOVIEN` -- `(0,1)` -- (Homeroom) -- `(1,1)` -- `LOP`

### Tool #2: The Class Diagram (UML)

This is the best tool for designing an _application_. It shows **data + behavior**.

A class diagram has 3 parts:

1. **Name:** `SINHVIEN`
    
2. **Attributes:** `mssv`, `tenSV` (The data)
    
3. **Methods:** `ThemSV()`, `TimSV()` (The _behaviors_ or _functions_)
    

#### The Class Diagram's Superpower: Inheritance (Kế thừa)

This is the key difference! A Class Diagram can easily show "is-a" relationships, which a basic ERD cannot.

- `NV_KYTHUAT` (Technical Staff) **is a** `NHANVIEN` (Employee).
    
- `NV_HANHCHANH` (Admin Staff) **is a** `NHANVIEN`.
    

You draw this with a hollow triangle arrow. This is **essential** for object-oriented code, but less common for basic database tables.

## Step 2 (Deep Dive): The "Magic" (Converting to a Logical Model)

So... how do you get from your _drawing_ (ERD) to your _blueprint_ (Logical Model)?

You just follow these rules. This is the most important part of the process!

### Rule 1: Every Entity becomes a Table.

This is the easy one.

- The `SINHVIEN` entity becomes `SINHVIEN (...)`.
    
- The `MONHOC` entity becomes `MONHOC (...)`.
    

### Rule 2: Relationships are handled by Cardinality.

This is where the magic happens. You don't make tables for relationships... **you use Foreign Keys**.

#### **Case 1: 1-to-Many (`1..n`)**

_The **"Many"** side gets the Foreign Key._

- **Example:** One `PHONGBAN` (Department) has _many_ `NHANVIEN` (Employees).
    
- **Rule:** `NHANVIEN` is the "many" side. So, we add `MAPB` (Dept. ID) into the `NHANVIEN` table.
    
- **Blueprint:**
    
    - `PHONGBAN (MAPB, TenPB)`
        
    - `NHANVIEN (MANV, TenNV, **MAPB**)`
        

#### **Case 2: 1-to-1 (`1..1`)**

_You can put the Foreign Key in **either table**._

- **Example:** One `NHANVIEN` has one `LYLICH` (Resume).
    
- **Rule:** You can put `MANV` in the `LYLICH` table.
    
- **Blueprint:**
    
    - `NHANVIEN (MANV, TenNV)`
        
    - `LYLICH (MALL, ChiTiet, **MANV**)`
        

#### **Case 3: Many-to-Many (`n..n`)**

_You **MUST** create a **NEW table** (a "linking table")._

- **Example:** _One_ `SINHVIEN` takes _many_ `MONHOC`. _One_ `MONHOC` is taken by _many_ `SINHVIEN`.
    
- **Rule:** You cannot put a foreign key in either! How would you store many keys in one field? You can't.
    
- **Solution:** Create a new table, often named after the relationship (e.g., `THI` or `KETQUA`).
    
- **Blueprint:**
    
    - `SINHVIEN (MASV, TenSV)`
        
    - `MONHOC (MAMH, TenMH)`
        
    - `THI (**MASV**, **MAMH**, DIEM)`
        
        - The primary key of this new table is the _combination_ of both foreign keys.
            

## Step 3 (Deep Dive): The Finish Line (Physical Model)

This is the easiest step. You just translate your Logical "Blueprint" into SQL.

Your Blueprint (Logical):

LOP (MALOP, TENLOP, MAGV)

**Your Building (Physical):**

```
CREATE TABLE LOP (
    MALOP VARCHAR(10) PRIMARY KEY,
    TENLOP NVARCHAR(100),
    MAGV VARCHAR(10),
    FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV)
);
```

And you're done!

## Summary: The Workflow

You now have the full picture:

1. **We "Sketch" (Conceptual):** We draw an **ERD** (for data) or **CD** (for code) to understand the system and its rules (like `n..n`).
    
2. **We "Blueprint" (Logical):** We apply the conversion rules (like the `n..n` rule) to create a formal list of tables and foreign keys.
    
3. **We "Build" (Physical):** We write the `CREATE TABLE` SQL statements based on our blueprint.
    

A good blueprint prevents a collapsing building. A good logical model prevents a corrupt or broken database. Now, let's get building.

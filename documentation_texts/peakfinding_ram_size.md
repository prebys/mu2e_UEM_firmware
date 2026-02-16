# Peak FIFO Sizing: Start From Memory, Get Total Peaks, Then Distribute Across Subevents

This note shows how to compute the **maximum total number of peaks that can fit in a FIFO** (per channel), starting from FIFO memory size. After computing the total peak capacity, it explains how you can distribute those peaks across an event with multiple subevents.

Assumed fixed formats:
- **Peak height:** 2 × 32-bit words per peak (equivalently 1 × 64-bit entry per peak)
- **Peak area:**  6 × 32-bit words per peak

All calculations below are **per channel** (since peakfinding/FIFOs are instantiated per channel).

---

## 1) Start with FIFO memory size

A FIFO is commonly described as:

- `WIDTH × DEPTH`

Where:
- `WIDTH` is in **bits**
- `DEPTH` is in **entries**

Total bits stored:
```

TOTAL_BITS = WIDTH * DEPTH

```

To convert to 32-bit words:
```

TOTAL_32BIT_WORDS = TOTAL_BITS / 32

```

(Use integer division if you want a conservative floor.)

---

## 2) Convert FIFO size into “total peaks allowed”

### 2A) Peak Height FIFO (64 × 16384)

Current configuration:
- **peakhigh_fifo = 64 × 16384**

This means:
- Each entry is 64 bits
- There are 16384 entries

Total 64-bit entries:
```

TOTAL_HEIGHT_ENTRIES_64 = 16384

```

Peak height uses **1 × 64-bit entry per peak**, so:

```

TOTAL_HEIGHT_PEAKS_MAX = 16384 peaks

```

(Equivalent view: 64×16384 bits = 32×32768 32-bit words, and each peak consumes 2×32-bit words → 32768/2 = 16384 peaks.)

---

### 2B) Peak Area FIFO (32 × 32768)

Current configuration:
- **sumarea_fifo = 32 × 32768** (32-bit wide FIFO)

This means:
- Each entry is 32 bits
- There are 32768 entries

Total 32-bit words:
```

TOTAL_AREA_WORDS_32 = 32768 words

```

Peak area uses **6 × 32-bit words per peak**, so:

```

TOTAL_AREA_PEAKS_MAX = floor(32768 / 6) = 5461 peaks

```

---

## 3) Summary: total peak capacity per channel (current settings)

Per channel:

- **Peak height capacity:**  
```

16384 total peaks

```

- **Peak area capacity:**  
```

5461 total peaks

```

Peak area is typically the tighter limit.

---

## 4) Distributing peaks across an event with subevents

Define:
- `S` = number of subevents in an event
- `P` = peaks per subevent (assume worst-case maximum is the same for all subevents)

Total peaks in the event:
```

TOTAL_PEAKS_EVENT = S * P

```

To avoid FIFO overflow, require:
- For peak height:
```

S * P ≤ TOTAL_HEIGHT_PEAKS_MAX

```
- For peak area:
```

S * P ≤ TOTAL_AREA_PEAKS_MAX

```

So the maximum allowable peaks per subevent is:

- Peak height:
```

P_max_height = floor(TOTAL_HEIGHT_PEAKS_MAX / S)
= floor(16384 / S)

```

- Peak area:
```

P_max_area = floor(TOTAL_AREA_PEAKS_MAX / S)
= floor(5461 / S)

```

---

## 5) Example distributions

### Example A: 80 subevents per event

Let `S = 80`.

Peak height:
```

P_max_height = floor(16384 / 80) = 204 peaks/subevent

```

Peak area:
```

P_max_area = floor(5461 / 80) = 68 peaks/subevent

```

So for 80 subevents, a safe upper bound is:
- height: up to 204 peaks/subevent
- area:  up to 68 peaks/subevent

---

### Example B: 45 subevents per event

Let `S = 45`.

Peak height:
```

P_max_height = floor(16384 / 45) = 364 peaks/subevent

```

Peak area:
```

P_max_area = floor(5461 / 45) = 121 peaks/subevent

```

---

## 6) Key takeaways

1. **Compute total peak capacity from FIFO size first**  
   - Height: 64×16384 → 16384 peaks
   - Area:  32×32768 → 5461 peaks

2. **Then distribute across subevents** using:
```

P_max = floor(TOTAL_PEAKS_MAX / S)

```

3. In typical operation, **peak area limits the event** before peak height does.

---
```
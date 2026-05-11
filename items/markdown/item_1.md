### Question 
A student scored the following percentages on their end of the year exams:

* Alchemy: 47
* Astrology: 32
* Falconry: 37
* Logic: 89
* Music: 56
* Swordsmanship: 35
* Tarot: 46
* Xylomancy: 34

What was their mean score?



### Correct Answer
47

### Solution:
The mean score is calculated as:

$$\frac{\sum x}{N} = \frac{47 + 32 + 37 + 89 + 56 + 35 + 46 + 34}{8} = \frac{376}{8} = 47$$

**R Code:**

```r
x <- c(47, 32, 37, 89, 56, 35, 46, 34)
mean(x)
```
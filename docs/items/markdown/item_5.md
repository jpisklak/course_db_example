### Question 
Destinee rolled two six-sided die and plotted their values on the histogram below. What percentage of the rolls were either a 6, 7, or 8?

![](item_5.svg)



### Correct Answer
35

### Solution:
Each bar shows the number of times a certain value was rolled. Therefore the total percentage of rolls for 6, 7, and 8 is . . .

$$
\begin{align}
\text{Percent} &=
\frac{2+1+4}{1+2+3+1+2+1+4+2+2+2} \times 100 \\[0.5em]
&= \frac{7}{20} \times 100 \\[0.5em]
&= 35.00
\end{align}
$$

<br>

**R Code:**

```r
freq_678 <- c(2, 1, 4)
freq_tot <- c(1, 2, 3, 1, 2, 1, 4, 2, 2, 2)

sum(freq_678) / sum(freq_tot) * 100
```
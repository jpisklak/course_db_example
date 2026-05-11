### Question 
Using the data file `pearson_lee_1903.csv`, convert the children's heights
into centimetres (the data file has them in inches). Then calculate the
mean height of all the children.

Note: 1 in = 2.54 cm



### Correct Answer
167.7142933

### Solution:
```r
# Load data
heights <- read.csv("pearson_lee_1903.csv")

# Convert values to cm and calculate mean
result <- mean(heights$child * 2.54)
```
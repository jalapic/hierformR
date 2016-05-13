# hierformR
Hierarchy Network Formation

Authors -   James P. Curley (Columbia University) & Ivan D. Chase (Stony Brook University)

R Code for analyzing social hierarchy and network formation.  Based upon algorithms described in Lindquist & Chase, 2009, Bulletin of Mathematical Biology
- "Data-Based Analysis of Winner-Loser Models of Hierarchy Formation in Animals" -

http://link.springer.com/article/10.1007%2Fs11538-008-9371-9


### Installation
```
library(devtools)
devtools::install_github("jalapic/hierformR")

library(hierformR)
```


### Quick Example


 Example dataframe of winners and losers:

```
df<-data.frame(winner=c(1,2,3,1,2,3,2,1,2,3,3,1,2,3,4,3,1,3,2,1,1,1,1,2,2),
loser=c(2,4,4,4,3,2,1,3,3,4,4,2,3,2,3,4,2,4,3,3,3,2,2,4,3)
)

   winner loser
1       1     2
2       2     4
3       3     4
4       1     4
5       2     3
6       3     2
7       2     1
8       1     3
9       2     3
10      3     4
11      3     4
12      1     2
13      2     3
14      3     2
15      4     3
16      3     4
17      1     2
18      3     4
19      2     3
20      1     3
21      1     3
22      1     2
23      1     2
24      2     4
25      2     3

```


 For each row, get last interaction between each pair of nodes - return a list of same length as df

```
lastints(df)
```

 Get directed network object based on most recent interactions between each pair of nodes

```
lastnet(df)
```

 Return the characteristics of the network relevant for determining its current state

```
gs <- lastnet(df)
g <- gs[[25]]
get_statespace(g)

  X003 X012 X021D X021U X021C X030T X030C maxdom noedges nonodes distance degreediff
     0    0     0     0     0     4     0      3       6       4        1          3

```



 
 
The most useful function is `addstates`.  This will take any winner-loser dataframe and add the id and class of the states:

```
addstates(df)

   winner loser id class
1       1     2  1     1
2       2     4  3     L
3       3     4 13     C
4       1     4 22    Ht
5       2     3 32    Ft
6       3     2 33    Ft
7       2     1 32    Ft
8       1     3 40    Si
9       2     3 38    St
10      3     4 38    St
11      3     4 38    St
12      1     2 38    St
13      2     3 38    St
14      3     2 38    St
15      4     3 39    Si
16      3     4 38    St
17      1     2 38    St
18      3     4 38    St
19      2     3 38    St
20      1     3 38    St
21      1     3 38    St
22      1     2 38    St
23      1     2 38    St
24      2     4 38    St
25      2     3 38    St
```





More  functions coming soon.

Contact me at:   jc3181 AT columbia DOT edu

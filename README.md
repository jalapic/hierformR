# hierformR
Hierarchy Network Formation

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


1. Example dataframe of winners and losers:

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


2. For each row, get last interaction between each pair of nodes - return a list of same length as df

```
lastints(df)
```

3. Get directed network object based on most recent interactions between each pair of nodes

```
lastnet(df)
```

4. Return the characteristics of the network relevant for determining its current state

```
gs <- lastnetdf
g <- gs[[25]]
get_statespace(g)
```


More  functions coming soon.

Contact me at:   jc3181 AT columbia DOT edu
